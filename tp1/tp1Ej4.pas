

{$CODEPAGE UTF8}
program tp1Ej4;


type
	empleado = record
		num: integer;
		apellido: string;
		nombre: string;
		edad: byte; // va de 0 a 255
		dni: longint;
		end;

	emple = file of empleado;
	
procedure menu();
	begin
	writeln('---------- MENU');
	writeln('0 - Creacion de archivo de empleados.');
	writeln('1 - Listar empleados por un nombre o apellido determinado.');
	writeln('2 - Listar en pantalla los empleados de a uno por línea.');
	writeln('3 - Listar en pantalla los empleados mayores de 70 años, próximos a jubilarse.');
	writeln('4 - Agregar nuevo empleado.');
	writeln('5 - Modificar edad de un empleado');
	writeln('6 - Exportar TODO a un .txt.');
	writeln('7 - Exportar empleados sin DNI a un .txt.');
	writeln('11 - Imprimir todos los empleados.');
	writeln('99 - SALIR >>>');
	writeln('-');
	write('Elija una opción: ');
	end;

procedure solicitaDatos(var unEmple: empleado);
	begin
	write('Ingresar apellido (o la palabra "fin" para terminar): ');
	readln(unEmple.apellido);
	if(unEmple.apellido <> 'fin')then
		begin
		write('Ingresar nombre: ');
		readln(unEmple.nombre);
		write('Ingresar edad: ');
		readln(unEmple.edad);
		write('Ingresar DNI: ');
		readln(unEmple.dni);
		write('Ingresar Número de Empleado: ');
		readln(unEmple.num);
		end;
	end;

procedure carga(var arch: emple);
	var
	unEmple: empleado;
	
	begin
	writeln('-----------------------------');
	writeln('Creacion de archivo de empleados: ');	
	rewrite(arch);
	{write('Ingresar apellido (o la palabra "fin" para terminar): ');
	readln(unEmple.apellido);}
	solicitaDatos(unEmple);
	while(unEmple.apellido <> 'fin')do
		begin		
		write(arch, unEmple);
		writeln('-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.');		
		{write('Ingresar otro apellido (o la palabra "fin" para terminar): ');
		readln(unEmple.apellido);}
		solicitaDatos(unEmple);
		end;
	close(arch);
	end;
procedure unoPorLinea(e: empleado);
	begin
	writeln('Apellido y nombre: ', e.apellido, ' ', e.nombre, ' | DNI: ', e.dni, ' | Nro empleado: ', e.num, ' | Edad: ', e.edad);
	end;
	
procedure imprimirTodo(var arch: emple);
	var
	e: empleado;
	
	begin
	reset(arch);
	writeln('   <<<<< ARCHIVO DE EMPLEADOS >>>>>');
	writeln(' ---------------------------------------');
	while not EOF(arch) do
		begin
		read(arch, e);
		{writeln('Nombre y Apelldo: ', e.nombre, ' ', e.apellido);
		writeln('Edad: ', e.edad);
		writeln('DNI: ', e.dni);
		writeln('Nro. Empleado: ', e.num);
		writeln(' ---------------------------------------');}
		unoPorLinea(e);		
		end;
	close(arch);
	writeln();
	writeln();
	end;
	
procedure buscarPorNomApe(var arch: emple);
	var
	e: empleado;
	op: char;
	busqueda: string;
	existe: boolean;
	
	begin
	existe:= false;
	reset(arch);
	write('--- ¿Busqueda por nombre (n) o apellido (a)?. Ingresar letra: ');
	readln(op);
	if(op = 'n') then 
		begin
		write('Ingrese nombre a buscar: ');
		readln(busqueda);
		end
	else
		begin
		write('Ingrese apellido a buscar: ');
		readln(busqueda);
		end;	
	writeln(' - Resultados - ');
	while not EOF (arch) do
		begin
		read(arch, e);
		case op of
			'n': 	begin
					if(e.nombre = busqueda)then 
						begin
						unoPorLinea(e);
						existe:= true;
						end;	
					end;					
			'a':	begin
					if(e.apellido = busqueda)then 
						begin
						unoPorLinea(e);
						existe:= true;
						end;
					end;		
			end;
		end;	
	close(arch);	
	if (not existe) then writeln('No se encontró lo solicitado...');
	writeln();
	writeln();
	end;
	
procedure buscarPorNum(var arch: emple; var existe: boolean; num: integer);
	var 
	e: empleado;
	
	begin
	// Asumo que el archivo está abierto con reset
	existe:= false;
	seek(arch, 0); // No sé en qué posicion estaba.
	while((not EOF(arch)) and (not existe))do
		begin
		read(arch, e);
		if (e.num = num) then existe:= true;
		end;	
	end;
	
procedure verDeAUno(var arch: emple);
	var
	e: empleado;
	
	begin
	reset(arch);
	writeln();
	writeln('-- Listado de a uno. Para ver el siguiente, presionar Enter: ');
	while not EOF(arch)do
		begin
		read(arch, e);
		unoPorLinea(e);
		readln();
		end;
	writeln();
	writeln();
	close(arch);
	end;

procedure mayoresDe70(var arch: emple);
	var
	e: empleado;
	
	begin
	reset(arch);
	writeln();
	writeln('--- Listado de Empleados Mayores de 70 años: ');
	while not EOF(arch)do
		begin
		read(arch, e);
		if(e.edad > 70) then unoPorLinea(e);
		end;
	writeln();
	writeln();
	close(arch);
	end;
	
procedure agregarEmpleado(var arch: emple);
	var
	nuevo: empleado;
	existe: boolean;
	
	begin	
	reset(arch);
	writeln('---------- Carga de nuevo empleado ----------');
	solicitaDatos(nuevo);
	buscarPorNum(arch, existe, nuevo.num);	
	if (not existe) then
		begin
		seek(arch, filesize(arch));
		write(arch, nuevo);
		writeln('Nuevo empleado cargado !!!');
		writeln();
		end
	else
		writeln('El empleado ya fue cargado previamente en el archivo.');
	close(arch);
	end;
	
procedure modificarUnaEdad(var arch: emple);
	var 
	numBuscado: integer;
	existe: boolean;
	e: empleado;
	
	begin
	reset(arch);
	writeln('---------- Modificar edad de un empleado ----------');
	write('Ingrese numero de empleado: ');
	readln(numBuscado);
	buscarPorNum(arch, existe, numBuscado);
	if(existe)then 
		begin
		// Si lo encontró, está en el registro siguiente
		seek(arch, filepos(arch) - 1);
		read(arch, e);
		write('Ingrese nueva edad: ');
		readln(e.edad);
		seek(arch, filepos(arch) - 1);
		write(arch, e);
		writeln('Edad modificada !!!');
		writeln();
		end
	else
		writeln('No existe empleado con ese número...');
	writeln();
	close(arch);
	end;
	
procedure exportarTodo(var arch: emple; var unTxt: Text);
	var
	nomFisico: string;
	e: empleado;
	
	begin
	write('Ingrese nombre del archivo de txt: '); // todos_empleados.txt
	readln(nomFisico);
	writeln('--- Se exportaran todos los empleados al archivo ', nomFisico);
	assign(unTxt, nomFisico);
	rewrite(unTxt);
	reset(arch);
	while not EOF(arch)do
		begin
		read(arch, e);
		writeln(unTxt, e.num, ' ', e.apellido, ' ', e.nombre, ' ', e.edad, ' ', e.dni);
		end;	
	writeln('Exportación exitosa !!!');
	writeln();
	close(unTxt);
	close(arch);
	end;

procedure exportarDniCero(var arch: emple; var unTxt: Text);
	var
	nomFisico: string;
	e: empleado;
	
	begin
	write('Ingrese nombre del archivo de txt: '); // faltaDNIEmpleado.txt	
	readln(nomFisico);
	writeln('--- Se exportaran todos los empleados con DNI = 0 al archivo ', nomFisico);
	assign(unTxt, nomFisico);
	rewrite(unTxt);
	reset(arch);
	while not EOF(arch)do
		begin
		read(arch, e);
		if(e.dni = 0)then writeln(unTxt, e.num, ' ', e.apellido, ' ', e.nombre, ' ', e.edad, ' ', e.dni);
		end;	
	writeln('Exportación exitosa !!!');
	writeln();
	close(unTxt);
	close(arch);
	end;

var
arch_emple: emple;
opcion: integer;
nomFisico: string;
todos: Text;
algunos: Text;

begin
write('Ingrese nombre del archivo: '); // empleadosTp1Ej4
readln(nomFisico);
assign(arch_emple, nomFisico);
opcion:= 22; //hardcodeo
while(opcion <> 99) do
	begin
	menu();
	readln(opcion);
	case opcion of
		0: carga(arch_emple);
		1: buscarPorNomApe(arch_emple);
		2: verDeAUno(arch_emple);
		3: mayoresDe70(arch_emple);
		4: agregarEmpleado(arch_emple);
		5: modificarUnaEdad(arch_emple);
		6: exportarTodo(arch_emple, todos);
		7: exportarDniCero(arch_emple, algunos);
		11: imprimirTodo(arch_emple);		
		end;
	end;
end.
