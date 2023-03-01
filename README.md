# getec2-cpumem
get all ec2 instances id, cpu and memory to csv file with specific aws profile

# Usage

Download script then execute command below:
    wget https://github.com/myh-st/getec2-cpumem/blob/main/getec2-cpumem.sh
    chmod +x getec2-cpumem.sh
    ./getec2-cpumem AWSprofileName

# Staging result
    instancesID,MEMORYINFO,CpuCoreCount
    i-026xxxxxxxxxxx,8192,1
    i-038xxxxxxxxxxx,32768,2

# Final result
    instancesID,Memory,CPU
    i-026xxxxxxxxxxx,8GB,1
    i-038xxxxxxxxxxx,32GB,2

  output file :  ec2-instances-<AWSprofileName>.csv
