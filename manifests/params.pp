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

class wso2as::params {

  if($::use_hieradata == 'true')
  {
    $is_datasource        = hiera('wso2::is_datasource')
    $template_list        = hiera_array('wso2::template_list')
    $post_install_resources   = hiera('wso2::post_install_resources', { } )
    $post_configure_resources = hiera('wso2::post_configure_resources', { } )
    $post_start_resources     = hiera('wso2::post_start_resources', { } )
  }
  else
  {
    $template_list          = [
      'repository/conf/carbon.xml',
      'repository/conf/user-mgt.xml',
      'repository/conf/registry.xml',
      'repository/conf/identity.xml',
      'repository/conf/datasources/master-datasources.xml',
      'repository/conf/tomcat/catalina-server.xml',
      'repository/conf/axis2/axis2.xml',
      'repository/conf/security/authenticators.xml',
      'bin/wso2server.sh'
    ]

    $post_install_resources             = undef
    $post_configure_resources           = undef
    $post_start_resources               = undef
    $is_datasource                      = 'wso2_carbon_db'
  }


}