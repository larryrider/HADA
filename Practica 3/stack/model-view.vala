// -*- mode: vala -*-
/*
 *       model-view.vala
 *
 *       Copyright 2012 hada dlsi.ua.es
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

// Clases e interfaces para dar soporte para MV(C).

using Gee;

namespace Mvc {
    /**
	 * Model: Clase base de todos los modelos.
	 */
	public class Model : GLib.Object {
		public Model () {
			m_vl = new Gee.ArrayList<View>();
		}

		public void add_view (View v) { m_vl.add(v); v.set_model (this); }
		public void del_view (View v) { m_vl.remove(v); }

		public void notify_views () {
			foreach (var v in m_vl) {
				v.update ();
			}
		}

		//-- Data ----------------------------------
		private Gee.ArrayList<View> m_vl;
	}

	/**
	 * View: Interface a implementar por aquellas clases que quieran
	 * mostrar y/o modificar un modelo.
	 */
	public interface View : GLib.Object {
		/**
		 * Actualiza la vista desde el modelo
		 */
		public abstract void update ();  
		public abstract void set_model (Model m);
		/**
		 * Actualiza el modelo desde la vista
		 */
		public abstract void update_model (); 
	}
}
