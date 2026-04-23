



program tp2Ej1;

type 

	empleado = record
		codigo: integer;
		nombre: string[50];
		monto: integer;
		end;

	empleados = file of empleado;
	
var
archDetalle, archMaestro: empleados;
 
begin
assign(archDetalle, 'tp2Ej1Detalle');

end.
