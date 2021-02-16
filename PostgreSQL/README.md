# PostgreSQL Setup

Here's how you setup PostgreSQL on Manjaro. I'll also eventually include steps
for Ubuntu; but the steps should largely be the same!

External Reference:
https://dev.to/tusharsadhwani/how-to-setup-postgresql-on-manjaro-linux-arch-412l

This guide assumes that you want a locally installed PostgreSQL server to be
setup with multiple databases & users, on a per-project basis.

We also assume that you'd like this server to be configured for replication, to
send data to an external (usually a Raspberry Pi on the same LAN) hot standby
server, to protect against data loss.

TODO: Add docs for replication later!

## Initial Setup

```bash
yay -S postgresql postgis pgadmin4
sudo -u postgres -i # login as postgres
initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data/'
exit

sudo systemctl enable --now postgresql
sudo systemctl status postgresql # check for errors
```

## Configure `pg_hba.conf` & `postgresql.conf`

```bash
sudo su # switch to root
cd /var/lib/postgres/data
cp postgresql.conf postgresql.conf.bak
cp pg_hba.conf pg_hba.conf.bak
```

### `postgresql.conf`

```bash
vim postgresql.conf
```

Update the `password_encryption` field to `scram-sha-256`.

```bash
sudo systemctl restart postgresql
```

### Setup Password for postgres user

```bash
psql -U postgres
\password
```

The `\password` command prompts you to enter a password. Set this to a 99 byte
value. Now if you hadn't set the encryption method in the earlier section, the
encryption would've defaulted to `md5`, which is bad.

### `pg_hba.conf`

```
vim pg_hba.conf
```

Scroll down till you see a section that has headers `TYPE`, `DATABASE`, `USER`,
`ADDRESS`, and `METHOD`.

All instances of `trust` ought to be replaced with `scram-sha-256`, so that we
_mandate_ SCRAM-SHA-256 authentication.

## Setup Users and Databases

External Reference: https://medium.com/coding-blocks/creating-user-database-and-adding-access-on-postgresql-8bfcd2f4a91e

Switch to the `psql` command prompt as the database user `postgres` first by
running `psql -U postgres` and then typing the password you set earlier.

```sql
create database mydb;
create user myuser with encrypted password 'mypass';
grant all privileges on database mydb to myuser;
```
## Setting Up Replication To Remote Server

TODO

## Initializing A Database with a .sql File

```bash
psql -h localhost -U myuser -d mydb -a -f initdatabase.sql
```

You will be prompted to type the password before the command executes!

For a non-interractive setup, do:

```bash
PGPASSWORD=pass1234 psql -h localhost -U myuser -d mydb -a -f initdatabase.sql
```

