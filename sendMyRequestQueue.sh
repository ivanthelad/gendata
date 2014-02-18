#!/bin/sh
value=$RANDOM

#value=15931
tmpdir="tmpdir"
#rm -rf $tmpdir
Suites="updateContract lookUpContract provisionContract renewContract"
faults="Business_fault Technical_fault Maintenance_fault"
#faults="Business_fault Technical_fault"

#Suites="provisionContract renewContract"
suite=($Suites)
num_suites=${#suite[*]}
operation_type=${suite[$((RANDOM%num_suites))]}

fault=($faults)
num_fault=${#fault[*]}
fault_type=${fault[$((RANDOM%num_fault))]}


echo $operation_type

mkdir $tmpdir
filename="SampleRequest"
url="http://127.0.0.1:8080/overlord-rtgov/activity/store"

echo "********* [BEGIN] Simulating for generated id $value ************"

namer="ivanservice"

echo $timer

timer=`date +%s`
file="$tmpdir/output.$filename.$value.json"
tmpfile="$tmpdir/output.$filename.$value.json.tmp"
cp ${filename}.json ${file}
for i in {1..13}
do
 # file="$tmpdir/output.$filename.$value.json"
   placeHolder="TIMESTAMP_REPLACE_${i}_"
  sed  "s/ID_REPLACE/${value}/g"  "${file}" | \
  sed -e "s/${placeHolder}/${timer}/g" | sed -e "s/OPERATION_TYPE/${operation_type}/g"| sed -e "s/FAULT_REPLACE/${fault_type}/g"| sed -e "s/contracthandlervb/${namer}/g" > "${tmpfile}"
  #curl -X POST -H "Content-Type: application/json" -d '{"username":"admin","password":"overlord"}' http://127.0.0.1:8080/overlord-rtgov/activity/store
#curl -X POST -d "@${file}" "${url}"  --user fswAdmin:notruf678# --header "Content-Type:application/json"
#let timer=$timer+300 ;
#if [ "$i" -eq "12" ]; then 
myDelay=$((RANDOM % 200))
echo "******* Creating artificial delay of [${myDelay}] ms ******* "

let timer=$timer+$myDelay
#fi
echo "Performing phase [$i] and operation ${operation_type} for conversationid=$value"
cp ${tmpfile} ${file}
done
#sleep $((RANDOM % 10))


echo "********* [END] Simulating for generated id $value ************"

echo "********* [Sending]  for generated file id $value ************"
curl -X POST -d "@${file}" "${url}"  --user fswAdmin:password --header "Content-Type:application/json"


rm ${tmpfile}
rm ${file}
echo ""


