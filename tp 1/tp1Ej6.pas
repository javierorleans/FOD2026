






{$CODEPAGE UTF8}
program tp1Ej6Celulares;
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
		
	celulares = file of celular;
	
procedure menu();
	begin
	writeln('---- MENU ----');
	writeln('1 - Crear archivo de celulares desde txt.');
	writeln('2 - Listar celulares con stock menor al minimo.');
	writeln('3 - Listar celulares según busqueda por descripcion.');
	writeln('4 - Exportar a un txt.');
	writeln('5 - Agregar un celular.');
	writeln('6 - Modificar stock.');
	writeln('7 - Exportar a txt celulares con stock cero.');
	writeln('22 - Imprimir todos los celulares.');
	writeln('99 - SALIR ---------');
	writeln('');
	write('Ingrese opción: ');
	//writeln('');
	//writeln('');
	//writeln('');
	end;
procedure crearEImportar(var arch: celulares; var unTxt: Text);
	var
	nomFisico: string;
	c: celular;
	
	begin
	rewrite(arch);
	write('Ingrese nombre de archivo .txt: '); //celulares.txt
	readln(nomFisico);
	assign(unTxt, nomFisico);
	reset(unTxt);
	while(not EOF (unTxt))do
		begin		
		readln(unTxt, c.codigo, c.precio, c.marca);
		readln(unTxt, c.stockDisp, c.stockMin, c.descripcion);
		readln(unTxt, c.nombre);
		write(arch, c);
		end;
	writeln('----- TXT copiado -----');
	writeln();	
	close(arch);
	close(unTxt);
	end;

procedure imprimirUno(c: celular);
	begin
	writeln('Codigo: ', c.codigo);
	writeln('Nombre: ', c.nombre);
	writeln('Descripcion: ', c.descripcion);
	writeln('Marca: ', c.marca);
	writeln('Precio: $', c.precio:0:2);
	writeln('Stock Minimo: ', c.stockMin, ' unidades.');
	writeln('Stock Disponible: ', c.stockDisp, ' unidades.');
	writeln('----------------');	
	end;
	
procedure imprimirTodo(var arch: celulares);
	var
	c: celular;
	
	begin
	reset(arch);
	writeln('----- TODOS LOS CELULARES -----');
	while not EOF (arch) do
		begin
		read(arch, c);
		imprimirUno(c);
		end;
	writeln();
	close(arch);
	end;
	
procedure listarPocoStock(var arch: celulares);
	var
	c: celular;
	
	begin
	writeln('----- CELULARES CON STOCK MENOR AL MÍNIMO -----');
	reset(arch);
	while(not EOF (arch))do
		begin
		read(arch, c);
		if(c.stockDisp < c.stockMin)then imprimirUno(c);		
		end;
	close(arch);
	writeln();
	end;	
	
procedure busquedaPorDescripcion(var arch: celulares);
	var
	c: celular;
	palabra: string;
	encontre: boolean;
	
	begin
	encontre:= false;
	reset(arch);
	writeln('----- BUSQUEDA POR DESCRIPCION -----');
	write('Ingrese texto para buscar celular: ');
	readln(palabra);
	while(not EOF(arch))do
		begin
		read(arch, c);
		if(pos(palabra, c.descripcion) <> 0)then
			begin
			imprimirUno(c);
			encontre:= true;
			end;
		end;
	if(not encontre)then writeln('Ninguna descripcion coincide con la búsqueda ingresada...');
	writeln();
	close(arch);
	end;
	
procedure exportarATxt(var arch: celulares; var unTxt: Text);
	var
	nomFisico: string;
	c: celular;
	
	begin
	reset(arch);
	write('Ingrese nombre de archivo .txt: '); // celulares.txt
	readln(nomFisico);
	assign(unTxt, nomFisico);
	rewrite(unTxt);
	
	while(not EOF (arch))do
		begin
		read(arch, c);		
		writeln(unTxt, c.codigo, ' ', c.precio:0:2, '', c.marca);
		writeln(unTxt, c.stockDisp, ' ', c.stockMin, '',c.descripcion);
		writeln(unTxt, c.nombre);		
		end;
	writeln('----- TXT exportado -----');
	writeln();	
	
	close(arch);
	close(unTxt);
	{NOTA: cuando hay dos campos contiguos en el write y son del mismo tipo, hay que agregar un espacio en blanco asi ' ' sino 
	* solo alcanza con poner ''}
	end;
	
procedure agregarCelular(var arch: celulares);
	var
	c: celular;
	
	begin
	writeln('----- AGREGAR UN CELULAR -----');
	reset(arch);
	write('Ingresar código: ');
	readln(c.codigo);
	write('Ingresar nombre: ');
	readln(c.nombre);
	write('Ingresar descripcion: ');
	readln(c.descripcion);
	write('Ingresar marca: ');
	readln(c.marca);
	write('Ingresar precio: ');
	readln(c.precio);
	write('Ingresar stock minimo: ');
	readln(c.stockMin);
	write('Ingresar stock disponible actualmente: ');
	readln(c.stockDisp);
	
	seek(arch, filesize(arch));
	write(arch, c);	
	
	close(arch);
	writeln('---- CELULAR AGREGADO -----');
	writeln();
	end;

procedure modificarStock(var arch: celulares);
	var
	c: celular;
	nombre: string;
	encontre: boolean;
	
	begin
	reset(arch);
	encontre:= false;
	writeln('----- MODIFICACION DE STOCK -----');
	write('Busqueda por nombre. Ingreselo: ');
	readln(nombre);
	while ((not EOF(arch)) and (not encontre)) do
		begin
		read(arch, c);
		if(c.nombre = nombre)then encontre:= true;
		end;
	if(not encontre)then writeln('No se encontró celular con ese nombre: ')
	else
		begin
		writeln('----- Datos del celular buscado -----');
		imprimirUno(c);
		write('Ingrese nuevo stock disponible: ');		
		readln(c.stockDisp);
		seek(arch, filepos(arch) - 1);
		write(arch, c);
		writeln('---- Stock modificado...');
		writeln();
		end;			
	close(arch);
	end;
	
procedure sinStockATXT(var arch: celulares; var unTxt: Text);
	var
	nomFisico: string;
	c: celular;
	
	begin
	reset(arch);
	write('Ingrese nombre de archivo .txt: '); // SinStock.txt
	readln(nomFisico);
	assign(unTxt, nomFisico);
	rewrite(unTxt);
	
	while(not EOF (arch))do
		begin
		read(arch, c);
		if(c.stockDisp = 0)then
			begin		
			writeln(unTxt, c.codigo, ' ', c.precio:0:2, '', c.marca);
			writeln(unTxt, c.stockDisp, ' ', c.stockMin, '',c.descripcion);
			writeln(unTxt, c.nombre);	
			end;
		end;
	writeln('----- TXT exportado -----');
	writeln();	
	
	close(arch);
	close(unTxt);
	{NOTA: cuando hay dos campos contiguos en el write y son del mismo tipo, hay que agregar un espacio en blanco asi ' ' sino 
	* solo alcanza con poner ''}
	end;

var
arch_celus: celulares;
txt_celus: text;
opcion: integer; 
nomFisico: string;

begin
write('Ingrese nombre de archivo: '); //archTp1Ej5
readln(nomFisico);
assign(arch_celus, nomFisico);
opcion:= 0;
while (opcion <> 99) do
	begin
	menu();
	readln(opcion);
	writeln();
	case opcion of
		1: crearEImportar(arch_celus, txt_celus);
		2: listarPocoStock(arch_celus);
		3: busquedaPorDescripcion(arch_celus);
		4: exportarATxt(arch_celus, txt_celus);
		5: agregarCelular(arch_celus);
		6: modificarStock(arch_celus);
		7: sinStockATXT(arch_celus, txt_celus);
		22: imprimirTodo(arch_celus);
		99: writeln('HASTA PRONTO !!!');
		else
			begin
			writeln('Opción no válida...');
			writeln();
			end;
		end;
	end;
end.
	
