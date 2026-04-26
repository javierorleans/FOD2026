


{$CODEPAGE UTF8}
program tp2Ej2;

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
		
