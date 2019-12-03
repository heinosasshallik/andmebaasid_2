package usermodels

import (
	"database/sql"
)

type Tootaja struct {
	Staatus  string
	MentorID sql.NullInt32
	Ametid   []Amet
}
