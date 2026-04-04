


{$CODEPAGE UTF8}
program tp1Ej2;
type 
	archivo = file of integer;
	
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

procedure analisis(var arch: archivo; var cantMenor: integer; var prom: real);
	var
	suma: longint; // Uso longint porque la suma se pasa del limite del integer que es 32.767
	elem: integer;
	contador: integer;
	
	begin
	suma:= 0;
	contador:= 0;
	cantMenor:= 0;
	reset(arch);
	while not EOF(arch) do
		begin		
		read(arch, elem);
		suma:= suma + elem;
		contador:= contador + 1;
		if(elem < 15000)then
			begin
			cantMenor:= cantMenor + 1;
			end;
		end;
	close(arch);
	prom:= suma / contador;	
	end;
	
var
arch: archivo;
nomFisico: string[25];
cantMenor: integer;
prom: real;

begin
write('Ingrese un nombre de archivo: '); //tp1ej1NumAleat
readln(nomFisico);
assign(arch, nomFisico);
mostrar(arch);
analisis(arch, cantMenor, prom);
writeln(' ---------------- ');
writeln('Info de numeros ingresados:');
writeln('* Cantidad de números menores a 15.000: ', cantMenor);
writeln('* Promedio de todos los números del archivo: ', prom:0:2); // debe ser 6909.66
end.
