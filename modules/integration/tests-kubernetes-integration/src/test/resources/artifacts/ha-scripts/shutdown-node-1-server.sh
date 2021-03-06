#!/bin/bash
# Copyright (c) 2017, WSO2 Inc. (http://wso2.com) All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
echo "Shutting Down Node 1 Server"
kube_pods=($(kubectl get po | awk '{print $1}'))

for pod in "${kube_pods[@]}"
do
   :
   if [[ $pod == *"sp-ha-node-1"* ]];
   then
        #Getting the process id of the Worker
        pid=$(kubectl exec -ti $pod -- jps | grep Main | awk '{print $1}')
        kubectl exec -ti $pod -- kill -9 $pid
   fi
done
