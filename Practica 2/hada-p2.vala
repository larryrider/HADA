// Lawrence Rider Garcia

namespace Hada{
	class Application : GLib.Object{
		private string m_name;

		public signal void on_init ();
		public signal void on_end ();

		public Application (string name){
			on_init.connect(al_inicio);
			on_end.connect(al_final);
			on_end.connect(al_final2);
			m_name = name;
		}

		public void run (){
			on_init();
		}

		public void quit (){
			on_end();
		}
	}

	public void al_inicio (){
		stdout.printf("\nComenzamos...\n");
	}

	public void al_final (){
		stdout.printf("\nAcabamos...\n");
	}

	public void al_final2 (){
		stdout.printf("\nAcabamos de verdad...\n");
	}

	class Stack : GLib.Object{
		private static const int tamanyo = 10;
		private static const int kERROR = -100;
		private string s_nombre;
		private Array<int> pila;

		public signal void stack_overflow(string nombre, int indice);
		public signal void stack_underflow(string nombre, int indice);

		public Stack(string nombre){
			stack_overflow.connect(on_overflow);
			stack_underflow.connect(on_underflow);

			s_nombre = nombre;
			pila = new Array<int>();
		}

		public void push (int num){
			if (pila.length<tamanyo){
				pila.append_val(num);
			} else{
				stack_overflow(s_nombre,tamanyo-1);
			}
		}

		public int pop (){
			int elemento;
			if (pila.length>0){
				elemento = pila.index(pila.length-1);
				pila.remove_index(pila.length-1);
			} else{
				elemento = kERROR;
				stack_underflow(s_nombre,-1);
			}
			return elemento;
		}
	}

	public void on_overflow(string nombre,int indice){
		stdout.printf("Stack overflow "+nombre+" index = "+indice.to_string()+"\n");
	}

	public void on_underflow(string nombre,int indice){
		stdout.printf("Stack underflow "+nombre+" index = "+indice.to_string()+"\n");
	}
}
