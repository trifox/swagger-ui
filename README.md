# Ufp Swagger UI Proxy

if you are looking for the swagger ui repository go to https://github.com/swagger-api/swagger-ui

this is ufp-swagger-proxy repository which is a swagger ui that routes all request through backend

# Prerequisites

  - docker
  - bash

# Quickstart

- general developing, please refer to original repo
- updates from original repo will be merged into here, swaggerui is main development repo for swagger-ui

To execute the build use 

    ./sidt-helm.sh -m

which builds the docker images used by the service, execute the component tests for the areas using

   ./sidt-helm.sh -t
  
 
start the individual areas and use localhost:8080 as entry point for both ares

    sidt.sh -a componenttest -u all
  
and  
  
    sidt.sh -a componenttest-e2e-selenium -u all
  
  


 
## License

Copyright 2018 SmartBear Software

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
