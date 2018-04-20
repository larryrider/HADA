// -*- mode: vala -*-
/*
 *       vala-bd-gui.vala
 *
 *       Copyright 2013  HADA <hada@dlsi.ua.es>
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

using Gtk;
using Gee;

namespace Hada {
    
	public class BD_vista1 : GLib.Object {
		/**
		 * Constructor a partir de un Gtk.Builder para cargar el interfaz.
		 */
		public BD_vista1 (Builder b) {
			m_window    = b.get_object ("ventana_bd")  as Window;
			m_nombre    = b.get_object ("w_nombre")    as Entry;
			m_direccion = b.get_object ("w_direccion") as Entry;
			m_ciudad    = b.get_object ("w_ciudad")    as Entry;
			m_button_crear  = b.get_object ("w_crear")     as Button;
			m_button_borrar = b.get_object ("w_borrar")    as Button;

			try {
				m_clicad = new ClienteCAD ("../hadadb");
			} catch (Error e) {
				stderr.printf ("Error leyendo clientes: %s\n", e.message);
				return;
			}


			m_button_crear.clicked.connect(on_crear_clicked);
			m_button_borrar.clicked.connect(on_borrar_clicked);

			m_clientes = m_clicad.dame_todos_clientes ();
			//stdout.printf ("Clientes leidos: %d\n",m_clientes.length );
			m_curr_client = 0;
			b.connect_signals (this);
			m_window.destroy.connect (Gtk.main_quit);
			m_window.show_all ();

			//stdout.printf ("BD_vista1 creada!!!\n");
		}

		[CCode (instance_pos = -1)]
		public void on_crear_clicked(Button crear){
			ClienteEN cliente=new ClienteEN();
			
			cliente.nombre=m_nombre.text;
			cliente.direccion=m_direccion.text;
			cliente.ciudad=m_ciudad.text;
			
			cliente.inserta_cliente();
			
			m_clientes=m_clicad.dame_todos_clientes();
			
			update();
		}

		[CCode (instance_pos = -1)]
		public void on_borrar_clicked(Button borrar){
			ClienteEN cliente=new ClienteEN();

			cliente.nombre=m_nombre.text;
			cliente.borra_cliente();

			m_clientes=m_clicad.dame_todos_clientes();
			update();
		}

        /**
         * Método callback invocado cuando el usuario pulsa el botón 'siguiente'.
         */
        [CCode (instance_pos = -1)]
        public void on_siguiente_clicked (Button source) {
			if (m_curr_client < (m_clientes.size - 1) ) {
				set_model (m_clientes[++m_curr_client]);
			}
        }

        /**
         * Método callback invocado cuando el usuario pulsa el botón 'anterior'.
         */
        [CCode (instance_pos = -1)]
        public void on_anterior_clicked (Button source) {
			if (m_curr_client > 0) {
				m_curr_client--;
				set_model (m_clientes[m_curr_client]);
			}
        }

		/**
		 * Setter para el modelo de esta vista.
		 */
		public void set_model (Mvc.Model m) { 
			m_modelo = m as ClienteEN; 
			// Actualizamos la vista desde su modelo
			update ();
		}

		/**
		 * Actualizamos la vista desde el modelo.
		 */
		public void update () {
			m_nombre.text    = m_modelo.nombre;
			m_direccion.text = m_modelo.direccion;
			m_ciudad.text    = m_modelo.ciudad;
		}

		/**
		 * Actualizamos el modelo desde la vista
		 */
		public void update_model () {
			if (m_modelo == null) return;

			m_modelo.nombre    = m_nombre.text;
			m_modelo.direccion = m_direccion.text;
			m_modelo.ciudad    = m_ciudad.text;
		}

 
		//-- Datos ---------------------------------
		Window     m_window;
		Entry      m_nombre;
		Entry      m_direccion;
		Entry      m_ciudad;
		ClienteEN  m_modelo;
		ArrayList<ClienteEN> m_clientes;
		ClienteCAD m_clicad;
		int        m_curr_client;
		Button		m_button_crear;
		Button 		m_button_borrar;
	}

}
