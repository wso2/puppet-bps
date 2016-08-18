# WSO2 Business Process Server Puppet Module

This repository contains the Puppet Module for installing and configuring WSO2 Business Process Server on various environments. Configuration data is managed using [Hiera](http://docs.puppetlabs.com/hiera/1/). Hiera provides a mechanism for separating configuration data from Puppet scripts and managing them in a set of YAML files in a hierarchical manner.

## Supported Operating Systems

- Debian 6 or higher
- Ubuntu 12.04 or higher

## Supported Puppet Versions

- Puppet 2.7, 3 or newer

## How to Contribute
Follow the steps mentioned in the [wiki](https://github.com/wso2/puppet-base/wiki) to setup a development environment and update/create new puppet modules.

## Packs to be Copied
Copy WSO2 Business Process Server 3.5.1 distribution to `<PUPPET_HOME>/modules/wso2bps/files`

## Running WSO2 Business Process Server in the `default` profile
No changes to Hiera data are required to run the `default` profile.  Copy the above mentioned files to their corresponding locations and apply the Puppet Modules.

## Running WSO2 Business Process Server with clustering in specific profiles
Hiera data sets matching the distributed profiles of WSO2 Business Process Server (`manager`, `worker`) are shipped with clustering related configuration already enabled. Therefore, only a few changes are needed to setup a distributed deployment. For more details refer the [WSO2 Business Process Server clustering guide](https://docs.wso2.com/display/CLUSTER44x/Clustering+Business+Process+Server+3.5.0+and+3.5.1)

1. If the Clustering Membership Scheme is `WKA`, add the Well Known Address list.

   Ex:
    ```yaml
    wso2::clustering:
      enabled: true
      domain: bps.wso2.domain
      local_member_host: "%{::ipaddress}"
      local_member_port: 4000
      sub_domain: mgt
      membership_scheme: wka
      wka:
      members:
        -
          hostname: 192.168.100.31
          port: 4000
        -
          hostname: 192.168.100.32
          port: 4000
    ```

2. Uncomment and modify the MySQL based data sources to point to the external MySQL servers.

   Ex:
    ```yaml
    wso2_config_db:
      name: WSO2_CONFIG_DB
      description: The datasource used for config registry
      driver_class_name: "%{hiera('wso2::datasources::mysql::driver_class_name')}"
      url: jdbc:mysql://192.168.100.1:3306/WSO2CONFIG_DB?autoReconnect=true
      username: "%{hiera('wso2::datasources::mysql::username')}"
      password: "%{hiera('wso2::datasources::mysql::password')}"
      jndi_config: jdbc/WSO2_CONFIG_DB
      max_active: "%{hiera('wso2::datasources::common::max_active')}"
      max_wait: "%{hiera('wso2::datasources::common::max_wait')}"
      test_on_borrow: "%{hiera('wso2::datasources::common::test_on_borrow')}"
      default_auto_commit: "%{hiera('wso2::datasources::common::default_auto_commit')}"
      validation_query: "%{hiera('wso2::datasources::mysql::validation_query')}"
      validation_interval: "%{hiera('wso2::datasources::common::validation_interval')}"

    ```

3. Uncomment (and optionally configure) registry mounting

   Ex:
    ```yaml
    wso2_config_db:
      path: /_system/config
      target_path: /_system/config/bps
      read_only: false
      registry_root: /
      enable_cache: true

    wso2_gov_db:
      path: /_system/governance
      target_path: /_system/governance
      read_only: false
      registry_root: /
      enable_cache: true
    ```

4. Uncomment (and optionally configure) deployment synchronization

    Ex:
    ```yaml
    wso2::dep_sync:
      enabled: true
      auto_checkout: true
      auto_commit: true
      repository_type: svn
      svn:
        url: http://svnrepo.example.com/repos/
        user: username
        password: password
        append_tenant_id: true
    ```

## Running WSO2 Business Process Server with Secure Vault
WSO2 Carbon products may contain sensitive information such as passwords in configuration files. [WSO2 Secure Vault](https://docs.wso2.com/display/Carbon444/Securing+Passwords+in+Configuration+Files) provides a solution for securing such information.

Uncomment and modify the below changes in Hiera file to apply Secure Vault.

1. Enable Secure Vault

    ```yaml
    wso2::enable_secure_vault: true
    ```

2. Add Secure Vault configurations as below

    ```yaml
    wso2::secure_vault_configs:
      <secure_vault_config_name>:
        secret_alias: <secret_alias>
        secret_alias_value: <secret_alias_value>
        password: <password>
    ```

    Ex:
    ```yaml
    wso2::secure_vault_configs:
      key_store_password:
        secret_alias: Carbon.Security.KeyStore.Password
        secret_alias_value: repository/conf/carbon.xml//Server/Security/KeyStore/Password,false
        password: wso2carbon
    ```

3. Add Cipher Tool configuration file templates to `template_list`

    ```yaml
    wso2::template_list:
      - repository/conf/security/cipher-text.properties
      - repository/conf/security/cipher-tool.properties
      - bin/ciphertool.sh
    ```

    Please add the `password-tmp` template also to `template_list` if the `vm_type` is not `docker` when you are running the server in `default` platform.

## Running WSO2 Business Process Server on Kubernetes
WSO2 BPS Puppet Module ships Hiera data required to deploy WSO2 Business Process Server on Kubernetes. For more information refer to the documentation on [deploying WSO2 products on Kubernetes using WSO2 Puppet Modules](https://docs.wso2.com/display/PM210/Deploying+WSO2+Products+on+Kubernetes+Using+WSO2+Puppet+Modules).
