package tablemodels

import (
	"database/sql"
	"time"
)

type Laud struct {
	LauaKood           int
	Staatus            string
	Kommentaar         sql.NullString
	LauaVorguKorgus    int
	MaxMangijateArv    int
	RegAeg             time.Time
	Brand              string
	IsikuNimi          string
	IsikuEmail         string
	LauaKategooriaKood int
}
