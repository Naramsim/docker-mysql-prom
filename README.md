# docker-mysql-prom

> This project is just a coding challenge I was asked to do.

- Create a Linux server with Docker installed
- Deploy a MySql DB on Docker
- Deploy a Prom that monitors the DB on Docker
- Deploy a Docker service that reads/writes the DB
- Expose Prom to the Internet

## Architecture

Please look at the code

## Config

There is currently no IaaS code so you have to create on GCP a CentOS machine with a `disk-1` disk attached. Then change the fixed IP you find in the `hosts.yml`.

Before running ansible you should make a copy of the `compose/.env.sample` and change the password written in there.

```sh
cp .env.sample .env
nano .env
```

You should also change the user and public_key in `ansible/roles/identities/`.

## Init

```sh
cd ansible
ansible-playbook -e 'ansible_user=<user_of_public_key>' -i hosts.yml init.yml
```

This will create the user `ansible` on the machine which will be then used by ansible.

To run ansible:

```sh
ansible-playbook -i hosts.yml playbook.yml
```

## Run

I decided not to start the docker containers with Ansible, so you have to login into the instance and:

```sh
bash /opt/application/scripts/bootstrap.sh
```

Open `<http://instanceIP/graph>`

## Improvements
