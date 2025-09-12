const
   FINALIZADOR = -1;   { determina el fin de los puntos del cuestionario }
   PRIMER_PARCIAL = 'p';  { identificador de la actividad primer parcial }
   SEGUNDO_PARCIAL = 's';   { identificador de la actividad segundo parcial }
   CUESTIONARIOS = 'c';   { identificador de la actividad cuestionarios }
   PRESENCIAL = 'P';   { modalidad presencial }
   REMOTO = 'R';       { modalidad remota }

{ dentro del procedure LeerPuntosCuestionarios }
   NO_ERROR = 'n';     { constante que indica que esta todo OK}
   CANTIDAD_INCORRECTA_CUESTIONARIOS = 'c';    { constante que indica que se ingresaron mas cuestionarios de los posibles }
   RANGO_INCORRECTO_CUESTIONARIOS = 'r';       { constante que indica que se ingresó una nota de un cuesitonario fuera de rango }
   COMANDO_NO_RECONOCIDO = 'x';           { NO USAR, solo se usa en el programa principal }

procedure calcularCalificacion(modalidad : char; total : real);
var nota_factorizada : real;
begin
	nota_factorizada := total;

   if (modalidad = PRESENCIAL) and (total > 60) then
      nota_factorizada := round(((total - 60) * 40) / 52 ) + 60;

	write('Tu calificación es: ');
	if (nota_factorizada < 0) or (nota_factorizada > 100) then 
		writeln ('Fuera de rango'); 

	if (nota_factorizada < 25) then
		writeln ('Muy insuficiente')
	else if (nota_factorizada < 60) then
		writeln ('Sin concepto')
	else if (nota_factorizada < 70) then
		writeln ('Aceptable')
	else if (nota_factorizada < 80) then
		writeln ('Bueno')
	else if (nota_factorizada < 90) then
		writeln ('Muy bueno')
	else
		writeln ('Excelente');
end;