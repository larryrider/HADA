// Lawrence Rider Garcia

using Gee;

namespace Hada{
	public class Stack : Mvc.Model{
		public static const int kERROR = -100;
		private static const int tamanyo = 10;
		private static const int indexUnder= -1;
		private string s_nombre;
		private Array<int> pila;

		public signal void stack_overflow(string nombre, int index);
		public signal void stack_underflow(string nombre, int index);

		public Stack(string nombre){
			stack_overflow.connect(on_overflow);
			stack_underflow.connect(on_underflow);

			s_nombre = nombre;
			pila = new Array<int>();
		}

		public void push(int num){
			if (pila.length<tamanyo){
				pila.append_val(num);
			} else{
				stack_overflow(s_nombre,tamanyo-1);
			}
		}

		public int pop(){
			int elemento;
			if (pila.length>0){
				elemento = pila.index(pila.length-1);
				pila.remove_index(pila.length-1);
			} else{
				elemento = kERROR;
				stack_underflow(s_nombre,indexUnder);
			}
			return elemento;
		}

		public int getSize(){
			return (int) pila.length;
		}

		public int getInt(int index){
			return pila.index(index);
		}
	}

	public void on_overflow(string nombre,int index){
		stdout.printf("Stack overflow "+nombre+" index = "+index.to_string()+"\n");
	}

	public void on_underflow(string nombre,int index){
		stdout.printf("Stack underflow "+nombre+" index = "+index.to_string()+"\n");
	}
}