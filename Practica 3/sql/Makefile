
#
# Makefile para la segunda parte de la practica-3.
# Hada 2012-2013
#


####################
# ¡¡¡¡ATENCION!!!! #
#########################################################################################
# Si en el laboratorio tienes un error al compilar diciendo que no encuentra el paquete #
#  'gee-0.8', sustituyelo por 'gee-1.0'.					        #
# 										        #
# Es decir, se quedaria una linea PKGS como esta:				        #
# 										        #
# PKGS=--pkg gee-1.0 --pkg gtk+-3.0 --pkg sqlite3 --pkg gmodule-2.0		        #
#########################################################################################

PKGS=--pkg gee-1.0 --pkg gtk+-3.0 --pkg sqlite3 --pkg gmodule-2.0
OPTS=--disable-warnings -X -w

all : vbd crea-bd

vbd : $(wildcard *.vala)
	@echo Compilando...
	@valac $(OPTS) $(PKGS) $^ -o vbd

crea-bd :
	@echo Recreamos la base de datos de prueba...
	@sh ./create-db.sh

clean:
	@echo Borrando ficheros...
	@rm -f vbd hadadb *~
