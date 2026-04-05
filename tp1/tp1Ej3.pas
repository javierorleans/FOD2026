

{$CODEPAGE UTF8}
program tp1Ej3;


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
	writeln('11 - Imprimir todos los empleados.');
	write('Elija una opción. 99 para salir: ');
	end;

procedure carga(var arch: emple);
	var
	unEmple: empleado;
	
	begin
	writeln('-----------------------------');
	writeln('Creacion de archivo de empleados: ');	
	rewrite(arch);
	write('Ingresar apellido (o la palabra "fin" para terminar): ');
	readln(unEmple.apellido);
	while(unEmple.apellido <> 'fin')do
		begin
		write('Ingresar nombre: ');
		readln(unEmple.nombre);
		write('Ingresar edad: ');
		readln(unEmple.edad);
		write('Ingresar DNI: ');
		readln(unEmple.dni);
		write('Ingresar Número de Empleado: ');
		readln(unEmple.num);
		write(arch, unEmple);
		writeln('-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.');		
		write('Ingresar otro apellido (o la palabra "fin" para terminar): ');
		readln(unEmple.apellido);		
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
	end;
	

var
arch_emple: emple;
opcion: integer;
nomFisico: string;

begin
write('Ingrese nombre del archivo: '); //empleadosTp1Ej3
readln(nomFisico);
assign(arch_emple, nomFisico);
opcion:= 22; //hardcodeo
while(opcion <> 99) do
	begin
	menu();
	readln(opcion);
	case opcion of
		0: carga(arch_emple);
		11: imprimirTodo(arch_emple);		
		end;
	end;
end.
