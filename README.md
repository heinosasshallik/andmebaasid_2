# andmebaasid_2

## Project setup:

Go (v1.13) setup:
* https://golang.org/doc/install
* Update the PATH. In Linux, add this to .bashrc: `export PATH=/usr/local/go/bin:$PATH`
* `git clone https://github.com/heinosasshallik/andmebaasid_2.git`

You can clone this project anywhere besides inside your $GOPATH.

## API

Based on this example project:
https://github.com/hugomd/go-todo

If you're wondering how Go dependency management works (not necessary to read):
https://medium.com/rungo/anatomy-of-modules-in-go-c8274d215c16

## Frontend

Requires Vue CLI.
Run `npm install` to download dependencies.

## Database

Start the developer database with `sudo run_developer_database.sh`

Host: 127.0.0.1
Username: postgres
Password: postgres
Database: andmebaasid
