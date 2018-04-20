#!/bin/bash

# La borramos para empezar de cero
rm -f hadadb

sqlite3 hadadb <<SQL_ENTRY_TAG_1
CREATE TABLE clientes (nombre TEXT, direccion TEXT, ciudad TEXT);
INSERT INTO clientes VALUES ("Juan",   "Calle Alicante",      "Denia");
INSERT INTO clientes VALUES ("Pedro",  "Avenida de Madrid",   "San Vicente");
INSERT INTO clientes VALUES ("Manuel", "Avenida de Valencia", "Alicante");
INSERT INTO clientes VALUES ("Luis",   "Calle del Puerto",    "Cartagena");
INSERT INTO clientes VALUES ("Javier", "Calle la Palmera",    "Elche");
INSERT INTO clientes VALUES ("Alejandro", "Calle Calatrava",  "Alicante");
INSERT INTO clientes VALUES ("Arturo", "Calle Arniches",  "Madrid");
INSERT INTO clientes VALUES ("Alberto", "Calle Rio Ebro",  "Madrid");
INSERT INTO clientes VALUES ("Jordi", "Calle Rio Jucar",  "Barcelona");
INSERT INTO clientes VALUES ("Vicente", "Calle Islas Canarias",  "Alicante");
SQL_ENTRY_TAG_1
