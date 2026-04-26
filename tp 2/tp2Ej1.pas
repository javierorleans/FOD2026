


{$CODEPAGE UTF8}
program tp2Ej1;

const valorAlto = 9999;

type 

	empleado = record
		codigo: integer;
		nombre: string[50];
		monto: integer;
		end;

	empleados = file of empleado;
	
procedure cargarTxt(var unTxt: Text; var det: empleados);
	var
	e: empleado;
	
	begin
	reset(unTxt);
	rewrite(det);
	while(not EOF(unTxt))do
		begin
		readln(unTxt, e.codigo, e.nombre);
		readln(unTxt, e.monto);
		write(det, e);		
		end;
	close(unTxt);
	close(det);
	end;

procedure leer(var arch: empleados; var e: empleado);
	begin
	if(not EOF(arch))then read(arch, e)
					else e.codigo:= valorAlto;		
	end;
	
procedure unificar(var mae: empleados; var det: empleados);
	var
	e, aux: empleado; 
	
	begin
	writeln('... Se Inicia la unificación... ');
	reset(det);
	rewrite(mae);
	leer(det, e);
	while(e.codigo <> valorAlto)do
		begin
		aux:= e;
		aux.monto:= 0;
		while(e.codigo <> valorAlto) and (e.codigo = aux.codigo) do
			begin
			aux.monto:= aux.monto + e.monto;
			leer(det, e);
			end;
		write(mae, aux);
		end;
	close(det);
	close(mae);
	writeln('... ... ...');
	writeln('... Archivo unificado ... ');
	end;

procedure imprimirEmpleado(e: empleado);
	begin
	writeln(e.codigo, ' | ', e.nombre, ' | $ ', e.monto);
	end;
	
procedure imprimirArchivo(var arch: empleados);
	var
	e: empleado;
	
	begin
	reset(arch);
	writeln('   CODIGO   |   NOMBRE   |   MONTO');
	while(not EOF(arch))do
		begin
		read(arch, e);
		imprimirEmpleado(e);
		end;
	close(arch);
	end;
var
archDetalle, archMaestro: empleados;
unTxt: Text;
 
begin
writeln('... Inicio...');
writeln('... Se asignan los nombres fisicos tp2Ej1Detalle y tp2Ej1Maestro...');
assign(archDetalle, 'tp2Ej1Detalle');
assign(archMaestro, 'tp2Ej1Maestro');
assign(unTxt, 'tp2Ej1-unTxt.txt');
writeln('... Se importan datos desde tp2Ej1-unTxt.txt...');
cargarTxt(unTxt, archDetalle);
writeln('... Datos originales del detalle...');
imprimirArchivo(archDetalle);
unificar(archMaestro, archDetalle);
writeln('... Datos Finales de la unificacion...');
imprimirArchivo(archMaestro);
end.
