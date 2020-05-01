scp -i cloud.key $1* centos@$2:/home/centos
scp -i cloud.key cloudify-manager-install-5.0.5m2.rpm centos@$2:/home/centos
scp -i cloud.key root* centos@$2:/home/centos
