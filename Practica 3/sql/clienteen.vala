// -*- mode: vala -*-
/*
 *       clienteen.vala
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

namespace Hada {
	/**
	 * Representa la EN de un cliente.
	 *
	 * Un cliente tiene:
	 * 
	 *  * nombre
	 *  * direccion
	 *  * ciudad
	 */
    public class ClienteEN : Mvc.Model{
		public ClienteEN (string n="", string d="", string c="") {
			nombre = n;
			direccion = d;
			ciudad = c;
		}

		public void mostrar_datos () {
			stdout.printf ("Nombre = %s\n", nombre);
			stdout.printf ("Direccion = %s\n", direccion);
			stdout.printf ("Ciudad = %s\n", ciudad);
		}

		public void inserta_cliente () {
			try {
				m_cc = new ClienteCAD ("../hadadb");
			} catch (Error e) {
				stderr.printf ("Error creando ClienteCAD: %s\n", e.message);
				return;
			}

			m_cc.inserta_cliente (this);
		}

		public void borra_cliente () {
			try {
				m_cc = new ClienteCAD ("../hadadb");
			} catch (Error e) {
				stderr.printf ("Error creando ClienteCAD: %s\n", e.message);
				return;
			}

			m_cc.borra_cliente (this.nombre);
		}

		/////////////////
        // Propiedades //
        /////////////////

		public string nombre { get; set; }
		public string direccion { get; set; }
		public string ciudad { get; set; }

		///////////
        // Datos //
        ///////////

		private ClienteCAD m_cc;
	}
}
