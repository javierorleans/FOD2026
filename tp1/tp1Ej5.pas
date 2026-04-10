






{$CODEPAGE UTF8}
program tp1Ej5Celulares;
type 
	celular = record
		codigo: integer;
		nombre: string;
		descripcion: string;
		marca: string;
		precio: real;
		stockMin: integer;
		stockDisp: integer;
		end;
		
procedure menu();
	begin
	writeln('---- MENU ----');
	writeln('1 - Crear archivo de celulares desde txt.');
	writeln('2 - Listar celulares con stock menor al minimo.');
	writeln('3 - Listar celulares según busqueda por descripcion.');
	writeln('4 - Exportar a un txt.');
	writeln('22 - Imprimir todos los celulares.');
	writeln('99 - SALIR ---------');
	writeln('');
	write('Ingrese opción: ');
	//writeln('');
	//writeln('');
	//writeln('');
	end;

begin

end.
	
