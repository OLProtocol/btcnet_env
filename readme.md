# client
## install Bitcoin Core (MacOS app with UI): Bitcoin-Qt (option)
```shell
wget https://bitcoin.org/bin/bitcoin-core-25.0/bitcoin-25.0-x86_64-apple-darwin.dmg
open ./bitcoin-25.0-x86_64-apple-darwin.dmg
```

## install python3
```shell
brew install python3
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
```

```shell
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
echo 'eval "$(pyenv init -)"' >> ~/.profile
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc

mv /usr/bin/python2 python2_bak && mv /usr/bin/python3 python3_bak && mv /usr/bin/python python_bak
pyenv install 3.9.2
pyenv global 3.9.2
python3 get-pip.py


```

## install Sparrow
weg https://github.com/sparrowwallet/sparrow/releases/download/1.8.1/Sparrow-1.8.1-x86_64.dmg
open ./Sparrow-1.8.1-x86_64.dmg

# URL: 192.168.1.106 User/Pass: jacky/123456
open /Applications/Sparrow.app --args -n regtest

## install bitcoin: bitcoind bitcoin-cli bitcoin-tx bitcoin-util bitcoin-wallet 
```shell
brew install bitcoin
brew install redis-cli
```

## redis-cli
```shell
brew install redis-cli
```

## redis-client app: redis desktop client
wget https://github.com/redis/redis/archive/7.2.3.tar.gz
open 7.2.3.tar.gz

## install postgresql in macos
```shell
brew install postgrest
```

## remove postgresql10 in ubuntu18
## https://www.commandprompt.com/education/how-to-uninstall-postgresql-from-ubuntu/
```shell
sudo apt remove postgresql postgresql-contrib
sudo apt autoremove
dpkg -l |grep postgres
sudo apt-get –purge remove postgresql postgresql-10 postgresql-client-common postgresql-common postgresql-contrib
dpkg -l | grep postgres
```

## install postgresql10 in ubuntu18

```shell
sudo apt update
sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql.service
sudo systemctl status "postgresql*"
vi /etc/postgresql/10/main/postgresql.conf
listen_addresses = '*'
vi /etc/postgresql/10/main/pg_hba.conf
host    all             all             0.0.0.0/0            md5
sudo -u postgres psql #sudo -i -u postgres
ALTER USER postgres with password 'tinyverse';
\q
sudo systemctl restart postgresql.service
psql -h 192.168.1.106 -U postgres -W
# mount 200g to /data
mkdir -p /data/postgresql/postgresql1/10/main
cp -r /var/lib/postgresql/10/main to /data/postgresql/postgresql1/10/main
sudo chown -R postgres /data/postgresql
sudo chmod -R 0700 /data/postgresql/postgresql1/
vi /etc/postgresql/10/main/postgresql.conf
# data_directory = '/data/postgresql/postgresql1/10/main'
sudo systemctl restart postgresql.service
```

## virtual box for add space
## add vitual disk in virtual box
```shell
sudo fdisk -l
fdisk /dev/sdb #n,p,1
sudo mkfs.ext4 /dev/sdb1
sudo mkdir /data
sudo mount -t ext4 /data/sdb1 /data
df -h
vim /etc/fstab # add: /dev/sdb1 /data ext4 errors=remount-ro 0 1
reboot
```

## install redis
sudo apt install redis redis-client


## virtual box
```shell
sudo apt-get install virtualbox-guest-utils
```


## log bitcoind
```shell
tail -f /media/sf_bitcoin/testnet3/debug.log
tail -f /media/sf_bitcoin/main/debug.log
```

## remote channel for deml
## https://medium.com/botfuel/how-to-expose-a-local-development-server-to-the-internet-c31532d741cc
```shell
# server
ulimit -n 65535
vi /etc/ssh/sshd_config
AllowTcpForwarding yes
GatewayPorts yes
MaxSessions 10000
MaxStartups 100:30:100
sudo service ssh restart
# client
ssh -nN -R remotePort:localIp:localPort user@remoteIp
sudo apt install autossh
apt install autossh
autossh -M 0 -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -nN -R remotePort:localIp:localPort user@remoteIp
autossh -M 0 -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -fN -R remotePort:localIp:localPort user@remoteIp
# test
while true;do curl http://x.x.x.x:x/{path/} -H 'Accept: application/json' ;sleep 10;done
```

```shell
# electrs
# /data/btcnet_env/electors/target/release/electrs -vvvv --db-dir /data/electorsData --daemon-dir ./bitcoin/testnet -network testnet --cors "*"

# /data/btcnet_env/electors/target/release/electrs -vvvv --utxos-limit 5000 --electrum-txs-limit 5000 --db-dir /data/electorsData --daemon-rpc-addr "192.168.1.100:38443" --http-addr 0.0.0.0:3002 --network testnet --cors "*"

/data/btcnet_env/electors/target/release/electrs -vvvv --cookie jacky:123456 --db-dir /data/electorsData --daemon-dir /media/sf_bitcoin/ --daemon-rpc-addr "192.168.1.100:38443" --network testnet --cors "*" --utxos-limit 5000 --electrum-txs-limit 5000 --electrum-rpc-addr "0.0.0.0:60001" --http-addr "0.0.0.0:3002" --log-filters = "INFO"
```