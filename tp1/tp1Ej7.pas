






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

function existeCodigo(var arch: novelas; cod: integer): boolean;
	var
	n: novela;
	existe: boolean;
	
	begin
	// Al ejecutarlo debe estar en la primera posicion
	existe:= false;
	while (not EOF(arch) and (not existe))do
		begin
		read(arch, n);
		if(n.codigo = cod)then
			begin
			existe:= true;
			end;
		end;
	seek(arch, 0);
	existeCodigo:= existe;
	// Al finalizar debe quedar en la primera posicion
	end;

	
procedure agregarNovela(var arch: novelas);
	var
	n: novela;
	
	begin
	reset(arch);
	writeln('----- NUEVA NOVELA -----');
	write('* Ingrese codigo');
	readln(n.codigo);
	while(existeCodigo(arch, n.codigo))do
		begin
		write(' FATAL : Codigo existente. Ingrese otro codigo: ');
		readln(n.codigo);
		end;
	
	write('* Ingrese nombre del libro: ');
	readln(n.nombre);
	write('* Ingrese genero literario: ');
	readln(n.genero);
	write('* Ingrese precio: ');
	readln(n.precio);
	seek(arch, filesize(arch));
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
		2: agregarNovela(archNovelas);
		55: imprimirTodas(archNovelas);
		else 
			writeln('----- OPCION INCORRECTA ..!!!');
		end;
	writeln('--------------------');
	end;

end.
