package usermodels

import (
	"database/sql"
)

type Tootaja struct {
	IsikID    int
	Isikukood string
	RiikKood  string
	Emeil     string
	Nimi      sql.NullString
	MentorID  sql.NullInt32
	Staatus   string
	AmetID    int
	Amet      string
}
