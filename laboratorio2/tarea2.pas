{ Función que calcula el total de puntos obtenidos }
function calcularTotalPuntos(estud:Estudiante) : real;

{ Función que calcula el resultado final del estudiante }
function resultadoEstudiante (estud:Estudiante) : ResultadoCurso;


{ Retorna el promedio de las calificaciones de los estudiantes en `cestudiantes` }
function promedioEstudiantes (cestudiantes: InfoEstudiantes) : real;


{ Retorna la estructura `cestudiantes' sin información de estudiantes }
 procedure borrarInfoEstudiantes (var cestudiantes: InfoEstudiantes);


{ Inserta un nodo en una lista ordenada de estudiantes }
procedure insertarOrdenado(ciestud: integer; posicion: integer; var lmodord: InfoEstudModalidad);


{ Retorna dos listas de estudiantes, de acuerdo a la modalidad en que cursaor la asignatura 
  Retorna también la cantidad de estudiantes que cursaron en modalidad PRESENCIAL y la de los 
  que cursaron en modalidad REMOTO. }
procedure estudEnModalidad(cestudiantes: InfoEstudiantes; 
                           var estudmod:EstudModalidad; 
                           var npres,nrem:integer);
                    

{ Retorna el primer estudiante que cursó en la modalidad dada y que obtuvo el resultado` indicado }
procedure buscarEstudianteCalificacion (cestudiantes:InfoEstudiantes;
                                        estudmod:EstudModalidad; 
                                        modalidad:char; resultado : ResultadoCurso; 
                                        var encontrado : boolean; var estud : Estudiante);
    