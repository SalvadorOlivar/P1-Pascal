program principal(input,output);

{ Con esta directiva queda incluido el archivo definiciones.pas }
{$INCLUDE definiciones.pas}

{ Con esta directiva queda incluido el archivo tarea2.pas }
{$INCLUDE tarea2.pas}

{ Programa principal }
var
  cestudiantes: InfoEstudiantes;
  estudmod: EstudModalidad;
  opcion, npres, nrem, i: integer;
  nombreArch : ansistring;
  prom, total : real;
  modalidad, resu : char; 
  resultado: ResultadoCurso;
  encontrado : boolean;
  estu : Estudiante;
begin

  repeat
      writeLn;
      writeln('----- MENÚ TAREA2 -----');
      writeln('1. Cargar información de estudiantes ');
      writeln('2. Imprimir la información de todos los estudiantes  ');
      writeln('3. Calcular el promedio de los estudiantes ');
      writeln('4. Separar estudiantes según modalidad ');
      writeln('5. Obtener resultado del estudiante ');
      writeln('6. Calcular el total de puntos del primer estudiante del conjunto de estudiantes ');
      writeln('7. Obtener resultado del primer estudiante del conjunto de estudiantes ');
      writeln('8. Borrar a los estudiantes ');

      writeln('0. Salir');
      writeln('------------------------');
      write('Seleccione una opción: ');
      readln(opcion);
      writeln;

      case opcion of
          1 : begin { Leer datos desde el archivo }
            write('Ingrese el nombre del archivo con los datos de los estudiantes: ');
            readln(nombreArch);
            LeerDatosDesdeArchivo(cestudiantes, nombreArch);
          end;

          2 : begin  { imprimir información de los estudiantes }
            for i:= 1 to cestudiantes.tope do
              imprimirEstudiante(cestudiantes.estudiantes[i]);
          end;

          3 : begin { Calcular el promedio de los estudiantes }
            prom := promedioEstudiantes(cestudiantes);
            writeln('El promedio de nota de los estudiantes es: ',prom:2:2);
          end;

          4 : begin { separar estudiantes según modalidad }
            EstudEnModalidad(cestudiantes,estudmod,npres,nrem);
            writeln('Cursaron ',npres:1, ' estudiantes en modalidad presencial: ');
            writeln('Cursaron ',nrem:1, ' estudiantes en modalidad remota: ');
            imprimirConjModalidad(estudmod);
          end;

          5 : begin { Obtener resultado del estudiante }
            EstudEnModalidad(cestudiantes,estudmod,npres,nrem);
            write('Ingrese la modalidad a buscar (P/R) ');
            readln(modalidad);
            write('Ingrese el resultado a buscar (E/A/R) ');
            readln(resu);

            case resu of
              'E': resultado := Exonera;
              'R': resultado := Reprueba;
              'A': resultado := Aprueba;
            end;

            buscarEstudianteCalificacion(cestudiantes, estudmod, modalidad, resultado, encontrado, estu);

            if encontrado then
            begin
              writeln('Se encontró el estudiante con CI: ', estu.CI:7);
              total := calcularTotalPuntos(estu);
              writeln('El puntaje total del estudiante es: ',total:2:2);
            end
            else
              writeLn('No se encontró el estudiante con Modalidad: ', modalidad, ' y resultado: ', resu);
          end;
          6 : begin
            if (cestudiantes.tope >= 1) then
              begin
                total := calcularTotalPuntos(cestudiantes.estudiantes[1]);
                writeln('El total de puntos del primer estudiante es: ', total:0:3);
              end 
            else
              writeln('No se dispone de ningun estudiante para calcular el total de puntos. Primero cargue una lista de estudiantes');
          end;
          7 : begin
            if (cestudiantes.tope >= 1) then
              begin
                resultado := resultadoEstudiante(cestudiantes.estudiantes[1]);
            
                case resultado of
                  Exonera: resu := 'E';
                  Reprueba: resu := 'R';
                  Aprueba: resu := 'A';
                end;
                
                writeln('El resultado final del primer estudiante es: ', resu);
              end
            else
              writeln('No se dispone de ningun estudiante para calcular el resultado final. Primero cargue una lista de estudiantes');
          end;
          8 : begin
            borrarInfoEstudiantes(cestudiantes);
            if cestudiantes.tope > 0 then
            begin
              writeln('Se intento eliminar a los estudiantes, pero aun quedan ',cestudiantes.tope,' estudiantes en la lista: ');
              for i:= 1 to cestudiantes.tope do
                imprimirEstudiante(cestudiantes.estudiantes[i]);
            end else
              writeln('Los estudiantes fueron eliminados correctamente de la lista.');
          end;
      end;
  until opcion = 0;


end.


