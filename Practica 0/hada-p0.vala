// Lawrence Rider Garcia

public class Jugador : GLib.Object{
	private string nombrejugador;
	private int intentos;
	
	public Jugador(){
		nombrejugador="";
		intentos=0;
	}
	
	public void setNombreJugador(string nombre){
		nombrejugador=nombre;
	}
	
	public string getNombreJugador(){
		return nombrejugador;
	}
	
	public void sumarIntentos(){
		intentos++;
	}
	
	public int getIntentos(){
		return intentos;
	}
}

class Ejercicio : GLib.Object {
	private static int aleatorio;
	private static int min;
	private static int max;
	private static Jugador jugador;
	
	public static int main (string[] args){
		bool terminar=false;
		Jugador[] vectorJugadores=null;
		
		iniciarMinMax();
		comenzarPartida();
		
		do{
			stdout.printf("\nPrueba suerte: ");
			int introducido = int.parse(stdin.read_line());
			
			if (introducido==aleatorio){ //ha acertado
				stdout.printf("\nHas acertado!! \n");
				jugador.sumarIntentos();
				vectorJugadores+=jugador;
				
				string seguir="";
				stdout.printf("\n¿Quiere seguir jugando? (S/N)");
				seguir=stdin.read_line();
				if (seguir=="S"){
					comenzarPartida();
				} else{
					mostrarPuntuaciones(vectorJugadores);
					terminar=true;
				}
			} else{ 						//ha fallado
				stdout.printf("\nOh! Has fallado!");
				string seguir="";
				stdout.printf("\n¿Quiere seguir probando? (S/N)");
				seguir=stdin.read_line();
				if (seguir=="S"){
					jugador.sumarIntentos();
				} else{ //quiere abandonar
					string jugar="";
					stdout.printf("\n¿Quiere seguir jugando? (S/N)");
					jugar=stdin.read_line();
					if (jugar=="S"){
						cambiarJugador();
					}
					else{
						mostrarPuntuaciones(vectorJugadores);
						terminar=true;
					}
				}
			}
			
		}while (!terminar);
		//mostrar puntuaciones ordenadas
		
		return 0;
	}
	
	private static void comenzarPartida(){
		aleatorio = Random.int_range(min,max);
		jugador=new Jugador();
		stdout.printf("\nIntroduce tu nombre: ");
		jugador.setNombreJugador(stdin.read_line());
		stdout.printf("\nHola "+jugador.getNombreJugador()+"!\n");
	}
	
	private static void cambiarJugador(){
		stdout.printf("\nIntroduce tu nombre: ");
		jugador=new Jugador();
		jugador.setNombreJugador(stdin.read_line());
		//no se modifica el aleatorio, pero se inician los intentos y el nombre
	}
	
	private static void iniciarMinMax(){
		bool correcto = false;
		do{
			stdout.printf("Introduce el valor minimo: ");
			min= int.parse(stdin.read_line());
		
			stdout.printf("\nIntroduce el valor maximo: ");
			max = int.parse(stdin.read_line());
			if (min<=max){
				correcto =true;
			} else{
				stdout.printf("\nIntervalo incorrecto! Vuelve a introducirlo");
			}
		}while (!correcto);
	}

	private static void mostrarPuntuaciones(Jugador[] vectorJugadores){
		stdout.printf("\nPUNTUACIONES!");
		
		var vectorOrdenado=ordenarJugadores(vectorJugadores);
		for (int i=0;i<vectorJugadores.length;i++){
			stdout.printf("\n" + vectorOrdenado[i].getNombreJugador()+"-->"+vectorOrdenado[i].getIntentos().to_string()); 
		}
		stdout.printf("\n");
	}
	
	private static Jugador[] ordenarJugadores(Jugador[] vector){
		int i, j;
		Jugador temporal;
 
		for (i = vector.length - 1; i > 0; i--){
			for (j = 0; j < i; j++){
				if (vector[j].getIntentos() > vector[j + 1].getIntentos()) {
					temporal = vector[j];
					vector[j] = vector[j + 1];
					vector[j + 1] = temporal;
				}
			}
		}
		return vector;
	}
}
