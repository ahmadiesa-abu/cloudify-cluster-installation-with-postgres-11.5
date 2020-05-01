# cloudify-cluster-installation-with-postgres-11.5

— generateCA.sh : interactive creation of CA certificate 
— generateConfFile.sh : passing hostname and private-ip it will create the config-file to create certificate and key for host
— generateCertificateForHost.sh : passing hostname it will create the certificate and key for hosts
— preparePostgresqlRpms.sh : used to download and prepare the rpms that will be used by cfy_manager config.yaml 
— prepareServerFiles.sh : (passing hostname and ip) copy files to server given the private-key [cloud.key] 
— upgradePostgresql9.5-11.sh : it will download and install the database and do upgrade from 9.5 to 11 
— Postgresql11Client.sh : install postgresql11 libs that will be used by manager

To install a cloudify manager with postgresql 11 external database 

——————
DB Node : 

  steps followed to configure the database node :
  
1. install cloudify rpm 
2. execute preparePostgresqlRpms.sh
3. change the config.yaml : provide certificates
 
Change postgresql_server rpms to :

    libxslt_rpm_url: libxslt-1.1.28-5.el7.x86_64.rpm
    ps_libs_rpm_url: postgresql11-libs-11.5-1PGDG.rhel7.x86_64.rpm
    ps_rpm_url: postgresql11-11.5-1PGDG.rhel7.x86_64.rpm
    ps_contrib_rpm_url: postgresql11-contrib-11.5-1PGDG.rhel7.x86_64.rpm
    ps_server_rpm_url: postgresql11-server-11.5-1PGDG.rhel7.x86_64.rpm
    ps_devel_rpm_url: postgresql11-devel-11.5-1PGDG.rhel7.x86_64.rpm
    patroni_rpm_url: patroni-1.6.0-1.rhel7.x86_64.rpm
    etcd_rpm_url: etcd-3.3.11-2.el7.centos.x86_64.rpm

before running cfy_manager install — we need to change cfy_manager -- installation steps from 9.5 to 11:
  sudo yum groupinstall "Development Tools"
  sudo yum install -y epel-release
  sudo yum install -y python-devel python-pip
  sudo pip install virtualenv
  git clone https://github.com/cloudify-cosmo/cloudify-manager-install.git
  cd cloudify-manager-install
  virtualenv .
  source bin/activate
  copy file postgresql_server.py inside components/postgresql_server/
  pip install -e .

  run cfy_manager install --private-ip [] --public-ip []


Manager Node:

steps followed to configure the manager node :
1. install cloudify rpm 
2. execute preparePostgresqlRpms.sh
  3. change the config.yaml : provide certificates

  Change postgresql_client rpms to :

    ps_libs_rpm_url: postgresql11-libs-11.5-1PGDG.rhel7.x86_64.rpm
    ps_rpm_url: postgresql11-11.5-1PGDG.rhel7.x86_64.rpm
    psycopg2_rpm_url: python-psycopg2-2.7.7-1.el7.x86_64.rpm



    run cfy_manager install --private-ip [] --public-ip []


then we do the the following to make the manager use postgresql11 libs :

sudo vi /opt/manager/cloudify-rest.conf       ——> change the path from 9.5 to 11

sudo systemctl restart cloudify-restservice
sudo systemctl restart cloudify-mgmtworker
sudo systemctl restart cloudify-amqp-postgres
sudo systemctl restart cloudify-stage
sudo systemctl restart cloudify-composer

————————————————————

For upgrade :

On database node 

we run upgrade upgradePostgresql9.5-11.sh 

On manager node

We run Postgresql11Client.sh 

sudo vi /opt/manager/cloudify-rest.conf       ——> change the path from 9.5 to 11
sudo systemctl restart cloudify-restservice
sudo systemctl restart cloudify-mgmtworker
sudo systemctl restart cloudify-amqp-postgres
sudo systemctl restart cloudify-stage
sudo systemctl restart cloudify-composer
