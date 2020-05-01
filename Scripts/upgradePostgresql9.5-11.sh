sudo yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo yum install -y /opt/cloudify/sources/libicu-50.2-3.el7.x86_64.rpm
sudo yum install -y /opt/cloudify/sources/libicu-devel-50.2-3.el7.x86_64.rpm
sudo yum install -y /opt/cloudify/sources/postgresql11-plperl.x86_64
sudo yum install -y python3
sudo yum install -y wget
sudo yum install -y http://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/p/python36-psycopg2-2.7.7-1.el7.x86_64.rpm
sudo yum install -y postgresql11-libs.x86_64  postgresql11.x86_64  postgresql11-contrib.x86_64  postgresql11-server.x86_64 postgresql11-devel.x86_64 postgresql11-plperl.x86_64
sudo /usr/pgsql-11/bin/postgresql-11-setup initdb
sudo su - postgres -c "/usr/pgsql-11/bin/pg_upgrade --old-bindir=/usr/pgsql-9.5/bin --new-bindir=/usr/pgsql-11/bin/ --old-datadir=/var/lib/pgsql/9.5/data/ --new-datadir=/var/lib/pgsql/11/data/ --check"
sudo sed -i 's/#listen_addresses = \'localhost\'/listen_addresses = \'*\'/g' /var/lib/pgsql/11/data/postgresql.conf
sudo cp /var/lib/pgsql/9.5/data/pg_hba.conf /var/lib/pgsql/11/data/pg_hba.conf
sudo cp /var/lib/pgsql/9.5/data/server.* /var/lib/pgsql/11/data/
sudo cp /var/lib/pgsql/9.5/data/root.* /var/lib/pgsql/11/data/
sudo cp /var/lib/pgsql/9.5/data/cloudify-postgresql.conf /var/lib/pgsql/11/data/cloudify-postgresql.conf
sudo sed -i 's/\/9.5\//\/11\//g' /var/lib/pgsql/11/data/cloudify-postgresql.conf
sudo echo "include = '/var/lib/pgsql/11/data/cloudify-postgresql.conf'" >> /var/lib/pgsql/11/data/postgresql.conf
sudo chown postgres:postgres  /var/lib/pgsql/11/data/server.crt
sudo chown postgres:postgres  /var/lib/pgsql/11/data/server.key
sudo chown postgres:postgres  /var/lib/pgsql/11/data/root.crt
sudo chown postgres:postgres  /var/lib/pgsql/11/data/cloudify-postgresql.conf
sudo systemctl stop postgresql-9.5
sudo systemctl disable postgresql-9.5
sudo systemctl start postgresql-11
sudo systemctl enable postgresql-11
