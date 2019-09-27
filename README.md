# andmebaasid_2

## Project setup:

Go (v1.13) setup:
* https://golang.org/doc/install
* Update the PATH. In Linux, add this to .bashrc: `export PATH=/usr/local/go/bin:$PATH`
* Update the PATH(2). Add the following folder to your path: $GOPATH/bin. In Linux, add this to .bashrc: `export PATH=~/go/bin:$PATH`
* `git clone https://github.com/heinosasshallik/andmebaasid_2.git`

You can clone this project anywhere besides inside your $GOPATH.

## API

Based on this example project:
https://github.com/hugomd/go-todo

If you're wondering how Go dependency management works (not necessary to read):
https://medium.com/rungo/anatomy-of-modules-in-go-c8274d215c16

Run with `go run main.go`

If you want it to autoreload when you make changes then do this:

```
go get github.com/codegangsta/gin
gin run main.go
```

## Frontend

Requires Vue CLI.
Run `npm install` to download dependencies.
Run `npm run serve` to serve frontend.

## Database

Start the developer database with `sudo run_developer_database.sh`

Host: 127.0.0.1
Username: postgres
Password: postgres
Database: currently tasks, will be andmebaasid later.
