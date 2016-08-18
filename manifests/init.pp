#----------------------------------------------------------------------------
#  Copyright (c) 2016 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#----------------------------------------------------------------------------

# Manages WSO2 Business Process Server deployment
class wso2bps inherits wso2base {
  $so_timeout                                 = hiera('wso2::so_timeout')
  $connection_timeout                         = hiera('wso2::connection_timeout')
  $mex_timeout                                = hiera('wso2::mex_timeout')
  $external_service_timeout                   = hiera('wso2::external_service_timeout')
  $max_connections_per_host                   = hiera('wso2::max_connections_per_host')
  $max_total_connections                      = hiera('wso2::max_total_connections')
  $ode_scheduler_thread_pool_size             = hiera('wso2::ode_scheduler_thread_pool_size')
  $scheduler_config_max_thread_pool_size      = hiera('wso2::scheduler_config_max_thread_pool_size')
  $enable_humantask_caching                   = hiera('wso2::enable_humantask_caching')
  $activity_datasources                       = hiera('wso2::activity_datasources')
  $bps_datasources                            = hiera('wso2::bps_datasources')
  $taskServerCount                            = hiera('wso2::taskServerCount')

  wso2base::server { $wso2base::carbon_home:
    maintenance_mode    => $wso2base::maintenance_mode,
    pack_filename       => $wso2base::pack_filename,
    pack_dir            => $wso2base::pack_dir,
    carbon_home_symlink => $wso2base::carbon_home_symlink,
    install_mode        => $wso2base::install_mode,
    install_dir         => $wso2base::install_dir,
    pack_extracted_dir  => $wso2base::pack_extracted_dir,
    wso2_user           => $wso2base::wso2_user,
    wso2_group          => $wso2base::wso2_group,
    patches_dir         => $wso2base::patches_dir,
    service_name        => $wso2base::service_name,
    service_template    => $wso2base::service_template,
    hosts_template      => $wso2base::hosts_template,
    template_list       => $wso2base::template_list,
    directory_list      => $wso2base::directory_list,
    file_list           => $wso2base::file_list,
    system_file_list    => $wso2base::system_file_list,
    enable_secure_vault => $wso2base::enable_secure_vault,
    key_store_password  => $wso2base::key_store_password
  }
}