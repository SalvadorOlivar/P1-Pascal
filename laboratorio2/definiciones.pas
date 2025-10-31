const
   PRESENCIAL = 'P';   { modalidad presencial }
   REMOTO = 'R';       { modalidad remota }
   MAX_ESTUDIANTES = 100;  { Máximo número de estudiantes }

type
   ResultadoCurso = (Exonera, Aprueba, Reprueba); { enumerado con las opciones de resultado de curso}

  { Definición del tipo estudiante }
   Estudiante = record
    CI : integer; { CI del estudiante }
    labAprobado: boolean; { si aprobó o no el laboratorio}
    parcial1, parcial2: real; { notas de los parciales }
    case modalidad: char of  { modalidad en la cual cursó }
      PRESENCIAL: 
        (cuestionarios: integer; { puntos en cuestionarios }
        asistencias: real);  { porcentaje de asistencias }
      REMOTO: ();
  end;

  { Definición de conjunto de estudiantes }
  InfoEstudiantes = record 
        estudiantes : array[1..MAX_ESTUDIANTES] of Estudiante;
        tope : 0 .. MAX_ESTUDIANTES
	end;
  
  InfoEstudModalidad = ^InfoEstud;
  InfoEstud = record
	ciest : integer;
	indice : 1 .. MAX_ESTUDIANTES;
	sig : InfoEstudModalidad
  end;

  EstudModalidad = record
	presencial : InfoEstudModalidad;
	remoto : InfoEstudModalidad
  end;


{ Despliega un estudiante en la salida estándar }
	procedure imprimirEstudiante (estudiante : Estudiante);
	begin
    	with estudiante do 
    	begin
        	writeln;
        	writeln('Estudiante :', CI:7);
        	If labAprobado then writeln('Aprobó Lab') else writeln('No aprobó Lab');
        	writeln('Puntaje en parcial 1 :', parcial1:4:2);
        	writeln('Puntaje en parcial 2 :', parcial2:4:2);
        	case modalidad of 
            	PRESENCIAL : writeln('Cursó en modalidad presencial, Puntaje en cuestionarios: ', cuestionarios:1);
            	REMOTO : writeln('Cursó en modalidad remota')
        	end;
        	writeln
    	end
	end;

	{ Despliega las cédulas de los estudiantes de una modalidad }
	procedure imprimirEstudModalidad (cestudiantes : InfoEstudModalidad);
	begin	
		if cestudiantes <> nil
		then
		begin	
			write('-> ');
			while cestudiantes^.sig <> nil do 
			begin	
				write(cestudiantes^.ciest:1,' : ');
				cestudiantes := cestudiantes^.sig
			end;
			writeln(cestudiantes^.ciest:1,' | ')
		end
		else writeln('No hay estudiantes en esta modalidad')
	end;

	{ Despliega las cédulas de los estudiantes de cada modalidad }
	procedure imprimirConjModalidad (estudmod : EstudModalidad);
	begin	
		write('Modalidad Presencial: ');
		imprimirEstudModalidad(estudmod.presencial);
		write('Modalidad Remota: ');
		imprimirEstudModalidad(estudmod.remoto)
	end;

	{ Procedimiento para leer datos de estudiantes desde un archivo }
	procedure LeerDatosDesdeArchivo(var cestudiantes: InfoEstudiantes; nombreArchivo: ansistring);
	var
  		archivo: text;
  		asistencias, parcial1, parcial2: real;
  		ci, modalidad, lab, cuestionarios: integer;
	begin
  	{ Abrir el archivo en modo lectura }
  	assign(archivo, nombreArchivo);
  	reset(archivo);
  
  	with cestudiantes do
  	begin
    	tope := 0;  
  	{ Leer datos del archivo hasta que se acabe }
    	while not eof(archivo) do
    	begin
    	{ Leer los datos del estudiante } 
     		read(archivo,ci);
    	    read(archivo,modalidad);
        	read(archivo,lab);
        	read(archivo, parcial1);
        	read(archivo, parcial2);
    
    	{ Se incrementa el tope }
        	tope := tope + 1;  
    
   	 	{ Se almacenan los datos en el registro según la modalidad }
      		estudiantes[tope].CI := ci;
      		estudiantes[tope].labAprobado := (lab = 1);
      		estudiantes[tope].parcial1 := parcial1;
      		estudiantes[tope].parcial2 := parcial2;

      		if modalidad = 1 then
      		begin
        		read(archivo, cuestionarios);
        		read(archivo, asistencias);
        		estudiantes[tope].modalidad := PRESENCIAL;
        		estudiantes[tope].cuestionarios := cuestionarios;
        		estudiantes[tope].asistencias := asistencias;
      		end
      		else estudiantes[tope].modalidad := REMOTO;

      		{ Leer el resto de la línea }
      		readln(archivo);
    		end;
  		end;
  
  		{ Cerrar el archivo }
  		close(archivo);

	end;

