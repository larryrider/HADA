// Lawrence Rider Garcia

class HolaMundo : GLib.Object {
	public static int main (string[] args){
		string input ="";
		
		if (args.length==1){
			stdout.printf("Introduce tu nombre: ");
			input = stdin.read_line();
		}
		
		stdout.printf("Hola mundo\n");
		if (args.length>1){
			imprimirArgumentos(args);
		} else{
			stdout.printf(input+"\n");
		}
		return 0;
	}
	
	public static void imprimirArgumentos(string[] args){
		for (int i=1;i<args.length;i++){
			stdout.printf(args[i]);
			stdout.printf("\n");
		}
		
	}
}