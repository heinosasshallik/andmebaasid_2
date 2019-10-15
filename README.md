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

## Frontend

Requires you to install Vue CLI. `npm install -g @vue/cli`

Run `npm install` to download dependencies.
Run `npm run serve` to serve frontend.

## Database

Start the developer database with `sudo run_developer_database.sh`

Host: 127.0.0.1
Username: postgres
Password: postgres
Database: andmebaasid

You can create new migrations either manually or with (has to be run in api/ folder):
`migrate create -ext sql -dir db/migrations -seq MIGRATION_NAME_HERE`

Running new database migrations:
1) use run_developer_database.sh
2) use the following command (POSTGRESQL_URL example in run_developer_database.sh):
`migrate -database ${POSTGRESQL_URL} -path db/migrations up`

