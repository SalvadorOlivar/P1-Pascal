program principal;

{ Con esta directiva queda incluido el archivo definiciones.pas }
{$INCLUDE definiciones.pas}

{ Con esta directiva queda incluido el archivo tarea1.pas }
{$INCLUDE tarea1.pas}

var 
	asistencias, puntosCuestionarios : integer;
	parcial1, parcial2, total : real;
	modalidad, laboratorio, continuar, error : char;
	aprobado : boolean;
	
begin
	writeln('¡Bienvenido a la Calculadora de Calificaciones del Estudiante!');

	repeat
		// Inicialización de variable de control de aprobación
		aprobado := true;

		repeat
			write('Ingresa modalidad de cursado (P/R): ');
			readln(modalidad);
		until (modalidad = PRESENCIAL) or (modalidad = REMOTO);

		// Si es modalidad presencial se solicitan las asistencias
		if (modalidad = PRESENCIAL) then
		begin
			repeat
				write('Ingresa porcentaje de asistencias(%): ');
				readln(asistencias);
			until (asistencias >= 0) and (asistencias <= 100);
			
			aprobado := asistencias >= 60;
		end;

		// Se ingresa al if si es modalidad remota o es modalidad presencial y cumplió con las asistencias
		if (aprobado) then
		begin
			repeat
				write('¿Has aprobado ambas tareas del laboratorio? (s/n): ');
				readln(laboratorio);
			until (laboratorio = 's') or (laboratorio = 'n');

			aprobado := laboratorio = 's';

			// Se ingresa al if si aprobó ambas tareas del laboratorio
			if (aprobado) then
			begin
				repeat 
					write('Ingresa tu puntuación del 1er parcial (sobre 40): ');
					readln(parcial1);
				until (PuntajeValidoParcial(PRIMER_PARCIAL, parcial1));

				repeat
					write('Ingresa tu puntuación del 2do parcial (sobre 60): ');
					readln(parcial2);
				until (PuntajeValidoParcial(SEGUNDO_PARCIAL, parcial2));
				
				error := NO_ERROR;

				// Se ingresa al if si es modalidad presencial para solicitar los puntos de los cuestionarios
				if modalidad = PRESENCIAL then
				begin
					repeat 
						write('Ingresa tu puntuación en cada uno de los Cuestionarios (a lo sumo 3 cuestionarios) terminando con -1: ');
						LeerPuntosCuestionarios (puntosCuestionarios, error);
						readln;

						if error = CANTIDAD_INCORRECTA_CUESTIONARIOS then
								writeln('La cantidad de notas de cuestionarios ingresadas es incorrecta (mayor a 3), intentalo de nuevo')
						else if error = RANGO_INCORRECTO_CUESTIONARIOS then
								writeln('La nota ingresada no esta dentro del rango permitido (es menor a 0 o es mayor a 4), intentalo de nuevo')
						else if error <> NO_ERROR then
							begin
								writeln('Corrija su programa, la variable error contiene un comando no reconocido, debe ser alguna de las siguientes: NO_ERROR, CANTIDAD_INCORRECTA_CUESTIONARIOS o RANGO_INCORRECTO_CUESTIONARIOS');
								error := COMANDO_NO_RECONOCIDO
							end;
					until ((error = NO_ERROR) or (error = COMANDO_NO_RECONOCIDO))
				end;

				if error = NO_ERROR then
				begin
					writeln('Calculando la calificación final...');
					total := CalcularTotalPuntos(modalidad, parcial1, parcial2, puntosCuestionarios);
					writeln('Tu puntaje final es: ', total:4:2);
					calcularCalificacion(modalidad, total)
				end
			end
			else
				writeln('Tu calificación es: Muy insuficiente'); // No aprobó el laboratorio
		end
			else
				writeln('Tu calificación es: Muy insuficiente'); // 

		write('Otra calificación?(s/n): ');
		readln(continuar);

	until (continuar <> 's');

	writeln('Hasta luego!');
end.
