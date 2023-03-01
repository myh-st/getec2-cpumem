#!/bin/bash
if [ $# -ne 1 ]; then
  echo "Usage: script.sh arg1 "
  echo "./script profileName"
  exit 1
fi

AWS_PROFILE="$1"

# Get instances id mem cpu write output to ec2-instances-$AWS_PROFILE.csv
echo "instancesID,MEMORYINFO,CpuCoreCount" > ec2-instances-$AWS_PROFILE.csv && \
aws ec2 describe-instances \
--query 'Reservations[*].Instances[*].[InstanceId, InstanceType, CpuOptions.CoreCount]' \
--output json \
--profile $AWS_PROFILE | jq -r '.[][] | @csv' | tr -d '"' | while IFS=, read -r id type cores; do \
  memory=$(aws ec2 describe-instance-types --query "InstanceTypes[?InstanceType=='$type'].MemoryInfo.SizeInMiB" --output text --profile $AWS_PROFILE); \
  echo "$id,$memory,$cores"; \
done >> ec2-instances-$AWS_PROFILE.csv

# Convert memory mb to GB
awk -F',' 'BEGIN{OFS=","} {print $1,$2/1024"GB",$3}' ec2-instances-$AWS_PROFILE.csv > ec2-instances-gb.csv
# Remove column header
sed -i '1d' ec2-instances-gb.csv
# Insert new column header
sed -i '1 i\instancesID,Memory,CPU' ec2-instances-gb.csv
mv ec2-instances-gb.csv ec2-instances-$AWS_PROFILE.csv
