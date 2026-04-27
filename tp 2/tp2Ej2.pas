


{$CODEPAGE UTF8}
program tp2Ej2;

const valorAlto = 32767;
type

	producto= record
		codigo: integer;
		nombre: string[50];
		precio: real;
		stockActual: integer;
		stockMinimo: integer;
		end;
		
	venta= record
		codigo: integer;
		cantidadVendida: integer;
		end;
		
	productos = file of producto;
	
	ventas = file of venta;

procedure leer(var det: ventas; var reg: venta);
	begin
	if (not EOF(det)) then read(det, reg)
					  else reg.codigo:= valorAlto;
	end;

procedure actualizarMaestro(var det: ventas; var mae: productos);
	var
	regDet: venta;
	regMae: producto;
	auxCod: integer;
	total: integer;
	
	begin
	reset(det);
	reset(mae);
	leer(det, regDet);
	read(mae, regMae);
	while(regDet.codigo <> valorAlto)do
		begin
		auxCod:= regDet.codigo;
		total:= 0;		
		while(regDet.codigo = auxCod)do
			begin
			total:= total + regDet.cantidadVendida;
			leer(det, regDet);
			end;
		while(auxCod <> regMae.codigo)do 
			read(mae, regMae);
		regMae.stockActual:= regMae.stockActual - total;
		seek(mae, filepos(mae) - 1);
		write(mae, regMae);
		end;
	close(det);
	close(mae);
	end;

procedure importarTxts(var det: ventas; var mae: productos);
	var
	rd: venta;
	rm: producto;
	txtDet,	txtMae: Text;
	
	begin
	assign(txtDet, 'tp2Ej2Detalle.txt');
	reset(txtDet);
	assign(txtMae, 'tp2Ej2Maestro.txt');
	reset(txtMae);
	rewrite(det);
	rewrite(mae);
	writeln('... Importación de archivo detalle...');
	while(not EOF(txtDet))do
		begin
		readln(txtDet, rd.codigo, rd.cantidadVendida);
		write(det, rd);
		end;
	writeln('... detalle importado !!');
	writeln('... Importación de archivo maestro...');
	while(not EOF(txtMae))do
		begin
		readln(txtMae, rm.codigo, rm.precio, rm.stockActual);
		readln(txtMae, rm.stockMinimo);
		readln(txtMae, rm.nombre);
		write(mae, rm);
		end;
	writeln('... detalle importado !!');
	
	close(txtDet);
	close(txtMae);
	close(det);
	close(mae);
	end;

procedure imprimirUnProducto(p: producto);
	begin
	writeln(p.codigo, ' | ', p.nombre, ' | $ ', p.precio:0:2, ' | ', p.stockActual, ' | ', p.stockMinimo);
	end;

procedure imprimirMaestro(var mae: productos);
	var
	rm: producto;
	
	begin
	reset(mae);
	//writeln('Archivo Maestro:');
	writeln('CODIGO | NOMBRE | PRECIO | STOCK ACTUAL | STOCK MINIMO');
	while(not EOF(mae))do
		begin
		read(mae, rm);
		imprimirUnProducto(rm);
		end;
	close(mae);
	end;

procedure exportarPocoStock(var mae: productos);
	var
	rm: producto;
	unTxt: Text;
	
	begin
	assign(unTxt, 'stock_minimo.txt');
	rewrite(unTxt);
	reset(mae);
	while(not EOF(mae))do
		begin
		read(mae, rm);
		if(rm.stockActual < rm.stockMinimo)then
			begin
			writeln(unTxt, rm.codigo, ' ', rm.nombre, ' ', rm.precio:0:2, ' ', rm.stockActual, ' ', rm.stockMinimo);
			end;
		end;
	writeln('Txt con stocks minimos creado...');
	close(mae);
	close(unTxt);
	end;
var
arch_det: ventas;
arch_mae: productos;


begin
assign(arch_det, 'tp2Ej2 - detalle');
assign(arch_mae, 'tp2Ej2 - maestro');
importarTxts(arch_det, arch_mae);
writeln('Archivo Maestro ANTES de la actualización:');
imprimirMaestro(arch_mae);
actualizarMaestro(arch_det, arch_mae);
writeln();
writeln('Archivo Maestro DESPUES de la actualiación:');
imprimirMaestro(arch_mae);
writeln('... exportando productos con stock menor al minimo...');
exportarPocoStock(arch_mae);
end.
