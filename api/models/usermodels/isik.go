package usermodels

import (
	"database/sql"
)

type Isik struct {
	IsikID      int
	Emeil       string
	Parool      string
	Isikukood   string
	RiikKood    string
	Nimi        sql.NullString
	TootajaInfo Tootaja
}
