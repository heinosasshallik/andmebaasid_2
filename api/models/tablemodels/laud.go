package tablemodels

import (
	"database/sql"
)

type Laud struct {
	LauaKood   int
	Staatus    string
	Kommentaar sql.NullString
}
