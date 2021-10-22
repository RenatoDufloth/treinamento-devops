cd /var/lib/jenkins/workspace/InfraPipeline/08-jenkins/deploy-infra-img-java-app/terraform
/usr/local/bin/terraform init 
/usr/local/bin/terraform apply -auto-approve 

echo "Aguardando criação de maquinas ..." 
# sleep 10 # 10 segundos 

echo "[ec2-dev-img-jenkins]" > ../ansible/hosts # cria arquivo 
echo "$(/usr/local/bin/terraform output | grep public_dns | awk '{print $2;exit}')" | sed -e "s/\",//g" >> /var/lib/jenkins/workspace/InfraPipeline/08-jenkins/deploy-infra-img-java-app/ansible/hosts # captura output faz split de espaco e replace de ", 

cat /var/lib/jenkins/workspace/InfraPipeline/08-jenkins/deploy-infra-img-java-app/ansible/hosts

echo "Aguardando criação de maquinas ..." 
# sleep 10 # 10 segundos 

cd /var/lib/jenkins/workspace/InfraPipeline/08-jenkins/deploy-infra-img-java-app/ansible

echo "Executando ansible ::::: [ ansible-playbook -i hosts provisionar.yml -u jenkins --private-key ssh -i /var/lib/jenkins/.ssh/id_rsa ]" 
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts provisionar.yml -u jenkins --private-key ssh -i /var/lib/jenkins/.ssh/id_rsa 
