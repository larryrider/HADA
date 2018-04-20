// -*- mode: vala -*-
/*
 *       clientecad.vala
 *
 *       Copyright 2013 HADA <hada@dlsi.ua.es>
 *     
 *       This program is free software; you can redistribute it and/or modify
 *       it under the terms of the GNU  General Public License as published by
 *       the Free Software Foundation; either version 3 of the License, or
 *       (at your option) any later version.
 *     
 *       This program is distributed in the hope that it will be useful,
 *       but WITHOUT ANY WARRANTY; without even the implied warranty of
 *       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *       GNU General Public License for more details.
 *      
 *       You should have received a copy of the GNU General Public License
 *       along with this program; if not, write to the Free Software
 *       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 *       MA 02110-1301, USA.
 */

using Sqlite;
using Gee;

namespace Hada {

    /**
	 * User defined exception types
	 */
	errordomain IOError {
		FILE_NOT_FOUND
	}

	/**
	 * Esta clase representa el Componente de Acceso a Datos para un cliente.
	 */
    public class ClienteCAD {

		public ClienteCAD (string dbf) throws IOError {

			if (!FileUtils.test (dbf, FileTest.IS_REGULAR)) {
				throw new IOError.FILE_NOT_FOUND(" \"%s\" no existe!".printf(dbf));
			} else {
				int rc = Database.open (dbf, out db);
			}
		}

		public void muestra_todos_clientes () {
			string orden = "select * from clientes";
			int rc = db.exec (orden, muestra_cb, null);
		}

		public ArrayList<ClienteEN> dame_todos_clientes () {
			string orden = "select * from clientes";

			alcen = new ArrayList<ClienteEN>();

			int rc = db.exec (orden, dame_todos_cb, null);

			//stdout.printf ("Leidos %d clientes\n", alcen.size);
			return alcen;
		}

		public ClienteEN dame_cliente (string nombre) {
			string orden = "select * from clientes where nombre = \"" + nombre + "\"";
			int rc = db.exec (orden, obtener_clienteen_cb, null);

			return cen;
		}

		public void actualiza_cliente (ClienteEN c) {
			int rc = 0;
			string orden = "update clientes ";

			orden += "set direccion = '" + c.direccion + "',";
			orden += " ciudad = '" + c.ciudad + "' ";
			orden += "where nombre = '" + c.nombre + "'";

			//stdout.printf ("Ejecutamos [%s]\n",orden );
			rc = db.exec (orden);
			if (rc != Sqlite.OK) {
				stdout.printf ("Error actualizando...\n"); 
			}
		}

		public void inserta_cliente (ClienteEN c) {

			string orden = "insert into clientes values ('";
			orden+=c.nombre+"','"+c.direccion+"','"+c.ciudad+"')";

			int rc = db.exec (orden);
			if (rc != Sqlite.OK) {
				stdout.printf ("Error insertando...\n"); 
			}
		}

		public void borra_cliente (string nombre) {

			string orden="delete from clientes where nombre='"+nombre+ "'";

			int rc = db.exec (orden);
			if (rc != Sqlite.OK) {
				stdout.printf ("Error borrando...\n"); 
			}
		}

		/////////////
        // Privado //
        /////////////

		private int muestra_cb (int n_columns, string[] values,
									   string[] column_names) {
			for (int i = 0; i < n_columns; i++) {
				stdout.printf ("%s = %s\n", column_names[i], values[i]);
			}
			stdout.printf ("\n");
			
			return 0;
		}

		private int dame_todos_cb (int n_columns, string[] values,
								   string[] column_names) {
			/*
			stdout.printf ("Leido el cliente (this: %lx) [%s - %s]\n", 
						   (long) this, values[0],values[2] );
			*/
			ClienteEN aux = new ClienteEN();

			aux.nombre    = values[0];
			aux.direccion = values[1];
			aux.ciudad    = values[2];

			alcen.add(aux);

			return 0;
		}

		private int obtener_clienteen_cb (int n_columns, string[] values,
										  string[] column_names) {
			cen = new ClienteEN (values[0], values[1], values[2]);
			
			return 0;
		}

		///////////
        // Datos //
        ///////////

		private Database db;
		private ClienteEN cen;
		private ArrayList<ClienteEN> alcen;
	}
}
