cd /var/lib/jenkins/workspace/InfraPipeline/08-jenkins/deploy-infra-img-java-app/terraform

#uri=$(/usr/local/bin/terraform output | grep public_ip | awk '{print $2;exit}' | sed -e "s/\",//g")
uri=$(/usr/local/bin/terraform output | grep public_dns | awk '{print $2;exit}' | sed -e "s/\",//g")

echo $uri

body=$(curl "http://$uri")

regex='Welcome to nginx!'

if [[ $body =~ $regex ]]
then 
    echo "::::: nginx está no ar :::::"
    exit 0
else
    echo "::::: nginx não está no ar :::::"
    exit 1
fi
