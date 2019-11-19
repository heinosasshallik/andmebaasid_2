# andmebaasid_2

## Project setup:

For Windows users:
I think it might be easiest for you to install and use WSL (Windows Subsystem for Linux). This will allow you to use linux commands inside windows and it will hopefully make setup easier for you.

Go (v1.13) setup:
* https://golang.org/doc/install
* Update the PATH. In Linux, add this to .bashrc: `export PATH=/usr/local/go/bin:$PATH`
* Update the PATH(2). Add the following folder to your path: $GOPATH/bin. In Linux, add this to .bashrc: `export PATH=~/go/bin:$PATH`
* Install our database migration program: `go get -tags 'postgres' -u github.com/golang-migrate/migrate/cmd/migrate`

Download the project to your preferred location (anywhere besides inside your $GOPATH): `git clone https://github.com/heinosasshallik/andmebaasid_2.git`

## API

### Basics

Learn Go from here:
https://tour.golang.org/basics/1

We use Go modules for dependency management (not necessary to read):
https://medium.com/rungo/anatomy-of-modules-in-go-c8274d215c16

Based on this example project:
https://github.com/hugomd/go-todo

Run with `go run main.go`

If you want it to autoreload when you make changes (requires you to have $GOPATH/bin in your PATH):
```
go get github.com/pilu/fresh
cd api/
fresh
```

Using this library for migrations:
https://github.com/golang-migrate/migrate

### Configuration

The configuration is takex from `apex.json` by default. Create the file and configure it with your credentials.

```
cd config
cp apex.sample.json apex.json
```

## Frontend

Requires you to install Vue CLI. `npm install -g @vue/cli`

Run `npm install` to download dependencies.
Run `npm run serve` to serve frontend.

## Database

### Connecting to the database from outside the university network

Have to port forward it. Replace my uniid with yours. You don't have to use pgcli to connect, you can use any client you want.

```
ssh -L 5432:localhost:5432 t179636@apex.ttu.ee
pgcli -h localhost --username t179636 --password
```


### Database setup

In apex, you have to run this before running the migrations. Switch t179636 for your username and 'secret' for your password. 

```
CREATE EXTENSION IF NOT EXISTS postgres_fdw;       

CREATE SERVER minu_testandmete_server_apex FOREIGN DATA WRAPPER
postgres_fdw OPTIONS (host 'apex.ttu.ee', dbname 'testandmed',
port '5432');


CREATE USER MAPPING FOR t179636 SERVER
minu_testandmete_server_apex OPTIONS (user 't179636', password
'secret');

CREATE FOREIGN TABLE Riik_jsonb (
riik JSONB )
SERVER minu_testandmete_server_apex;

CREATE FOREIGN TABLE Isik_jsonb (
isik JSONB )
SERVER minu_testandmete_server_apex;

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA
public;
```

### DEPRECATED, WE ARE USING APEX DATABASE

Start the developer database with `sudo run_developer_database.sh`.

Host: 127.0.0.1
Username: postgres
Password: postgres
Database: andmebaasid

### Creating new migrations

You can create new migrations either manually or with (has to be run in api/ folder):
`migrate create -ext sql -dir db/migrations -seq MIGRATION_NAME_HERE`

Running new database migrations:

`migrate -database postgres://USERNAME:PASSWORD@IP_ADDRESS:5432/TABLE_NAME?sslmode=disable -path db/migrations up`

Forcing the migration to a specific version. Fixed the "dirty" state. I don't think it actually makes any changes. Useful if a migration went wrong.

`migrate -database postgres://USERNAME:PASSWORD@IP_ADDRESS:5432/TABLE_NAME?sslmode=disable -path db/migrations force VERSION_NUMBER`
