// Lawrence Rider Garcia

using Gtk;
using Mvc;
using Hada;

public class Stack_vista : GLib.Object,Mvc.View {
	Window 			m_ventana1;
	Entry 			m_entry_push;
	Button 			m_button_push;
	Button 			m_button_pop;
	Button 			m_button_terminar;

	Array<Label> 	m_labels;
	Label 			m_label_pop;

	Stack 			m_modelo;

	public Stack_vista(Builder b) {
		m_ventana1 			= b.get_object ("ventana1")			as Window;
		m_entry_push 		= b.get_object ("entry_push")		as Entry;

		m_button_push 		= b.get_object ("button_push")		as Button;
		m_button_pop 		= b.get_object ("button_pop")		as Button;
		m_button_terminar 	= b.get_object ("button_terminar")	as Button;

		m_label_pop 		= b.get_object ("label_pop")		as Label;
		
		m_labels=new Array<Label>();

		for (int i=0;i<10;i++){
			m_labels.append_val(b.get_object("label"+i.to_string()) as Label);
		}

		m_button_terminar.clicked.connect(Gtk.main_quit);
		m_button_push.clicked.connect(push_clicked);
		m_button_pop.clicked.connect(pop_clicked);

		b.connect_signals (this);
		m_ventana1.destroy.connect(Gtk.main_quit);
		m_ventana1.show_all ();
	}

	[CCode (instance_pos = -1)]
	public void push_clicked(Button push){
		m_modelo.push(int.parse(m_entry_push.text));
		m_entry_push.text="";
		update_model();
	}

	[CCode (instance_pos = -1)]
	public void pop_clicked(Button pop){
		int numPop=m_modelo.pop();
		if (numPop!=Stack.kERROR || m_modelo.getSize()>0)
			m_label_pop.label=numPop.to_string();
		update_model();
	}

	public void set_model(Model m) { 
		m_modelo = m as Stack; 
		update();
	}
	
	public void update() {
		for (int i=0;i<10;i++){
			if (i<m_modelo.getSize()){
				m_labels.index(i).label=m_modelo.getInt(i).to_string();
			} else{
				m_labels.index(i).label="-";
			}
		}
	}

	public void update_model() {
		m_modelo.notify_views();
	}
}