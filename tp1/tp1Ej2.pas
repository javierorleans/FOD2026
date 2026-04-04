



program tp1Ej2;
type 
	archivo = file of integer;
	
procedure cargar(var arch: archivo);
	 var
	 num: integer;
	 
	 begin
	 rewrite(arch);
	 write('Ingrese un numero (no mayor que 32767) : 30000 para salir. ');
	 readln(num);
	 while(num <> 30000) do
		begin
		write(arch, num);		
		write('Ingrese otro numero (no mayor que 32767): 30000 para salir. ');
		readln(num);
		end;
	close(arch);
	end;
	
procedure mostrar (var arch: archivo);
	var
	num: integer;
	
	begin
	writeln('Numeros ingresados: ');
	reset(arch);
	while not EOF(arch) do
		begin
		read(arch, num);
		writeln(num);
		end;
	close(arch);
	end;

	
var
arch: archivo;
nomFisico: string[25];

begin
write('Ingrese un nombre de archivo: ');
readln(nomFisico);
assign(arch, nomFisico);
cargar(arch);
mostrar(arch);
end.
