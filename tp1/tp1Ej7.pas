






{$CODEPAGE UTF8}
program tp1Ej7novelas;
type 
	novela = record
		codigo: integer;
		nombre: string[50]; 
		genero: string[20];	
		precio: integer;
		end;

	novelas = file of novela;

procedure menu();
	begin
	writeln('----- MENU -----');
	writeln('1 - Traer novelas desde txt.');
	writeln('2 - Agregar novela.');
	writeln('3 - Modificar novela.');
	writeln('55 - Imprimir todas las novelas.');
	writeln('99 - Salir.');
	write('----- INGRESE OPCION: ');
	end;
	
procedure importar(var unTxt: Text; var archivo: novelas);
	var
	n: novela;
	
	begin
	reset(unTxt);
	rewrite(archivo);
	while (not EOF(unTxt)) do
		begin
		readln(unTxt, n.codigo, n.precio, n.genero);
		readln(unTxt, n.nombre);
		write(archivo, n);
		end;
	close(unTxt);
	close(archivo);
	end;
	
procedure imprimirUna(n: novela);
	begin
	writeln(n.codigo, ' | ', n.nombre, ' | ', n.genero, ' | $ ', n.precio);
	end;

procedure imprimirTodas(var arch: novelas);
	var
	n: novela;
	
	begin
	reset(arch);
	writeln('----- TODAS LAS NOVELAS -----');
	writeln('CODIGO | NOMBRE | GENERO | PRECIO');
	while(not EOF(arch))do
		begin
		read(arch, n);
		imprimirUna(n);
		end;
	close(arch);
	end;
 
var
archNovelas: novelas;
archTxt: Text;
nomFisico: string;
opcion: integer;

begin
assign(archTxt, 'novelas.txt');
write('Ingrese nombre de archivo: '); //tp1Ej7
readln(nomFisico);
writeln();
assign(archNovelas, nomFisico);
opcion:= 0;
while (opcion <> 99) do
	begin
	menu();
	readln(opcion);
	case opcion of
		1: importar(archTxt, archNovelas);
		
		55: imprimirTodas(archNovelas);
		else 
			writeln('----- OPCION INCORRECTA ..!!!');
		end;
	writeln('--------------------');
	end;

end.
