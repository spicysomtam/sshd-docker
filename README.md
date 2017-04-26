## Introduction

A quick Dockerfile based on Debian with sshd running. We can use this for testing ansible or anything else that takes our fancy. A substitute for vm's!

## How to build
```
docker build -t spicysomtam/sshd:0.1.0 .
```
## Bypassing security

Only do this if you don't care about security/it does not matter. Edit your ~/.ssh/config file, and add the following lines:

```
StrictHostKeyChecking no
UserKnownHostsFile /dev/null
```

## Running and logging in

```
docker run -d spicysomtam/sshd:0.1.0
```

Chances are if nothing else is running, the IP for the container will be 172.17.0.2. Otherwise use docker inspect to get the ip:

```
docker inspect $(docker ps |awk '/sshd:0.1.0/ {print $1}')|grep -i \"ipaddress
```

Then ssh to it; password is 'root':

```
ssh root@172.17.0.2
```

Finally add your public key to .ssh/authorized_keys in the container so you don't have to enter the password all the time. Something like:

```
cat ~/.ssh/id_rsa.pub |ssh root@172.17.0.2 "cat >> .ssh/authorized_keys"
```

If you are an admin and know all this; apologies in advance!
