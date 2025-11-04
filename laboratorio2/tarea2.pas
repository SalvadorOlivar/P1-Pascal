{ Función que calcula el total de puntos obtenidos }
function calcularTotalPuntos(estud:Estudiante) : real;
 begin
   if estud.modalidad = PRESENCIAL then
    calcularTotalPuntos := estud.parcial1 + estud.parcial2 + estud.cuestionarios
   else
    calcularTotalPuntos := estud.parcial1 + estud.parcial2;
 end;

{ Función que calcula el resultado final del estudiante }
function resultadoEstudiante (estud:Estudiante) : ResultadoCurso;
  begin
    if estud.modalidad = PRESENCIAL then
      begin
        if (estud.labAprobado) and (estud.asistencias >= 60) and (calcularTotalPuntos(estud) >= 60) then
                  resultadoEstudiante := Exonera
        else if (estud.labAprobado) and (estud.asistencias >= 60) and (calcularTotalPuntos(estud) >= 25) then
          resultadoEstudiante := Aprueba
        else
          resultadoEstudiante := Reprueba;
      end
    else
      begin
        if (estud.labAprobado) and (estud.parcial1 >= 10 ) and (estud.parcial2 >= 15 ) and (calcularTotalPuntos(estud) >= 60) then
                  resultadoEstudiante := Exonera
        else if (estud.labAprobado) and (calcularTotalPuntos(estud) >= 25) then
          resultadoEstudiante := Aprueba
        else
          resultadoEstudiante := Reprueba;
      end;
  end;


{ Retorna el promedio de las calificaciones de los estudiantes en `cestudiantes` }
function promedioEstudiantes (cestudiantes: InfoEstudiantes) : real;
 var total: real;
     i: integer;
 begin
  if cestudiantes.tope > 0 then
    begin
      total := 0;
      for i := 1 to cestudiantes.tope do
        total := total + calcularTotalPuntos(cestudiantes.estudiantes[i]);
        
      promedioEstudiantes := total / cestudiantes.tope
    end
  else
    promedioEstudiantes := 0;
 end;


{ Retorna la estructura `cestudiantes' sin información de estudiantes }
 procedure borrarInfoEstudiantes (var cestudiantes: InfoEstudiantes);
 begin
  cestudiantes.tope := 0;
 end;


{ Inserta un nodo en una lista ordenada de estudiantes }
procedure insertarOrdenado(ciestud: integer; posicion: integer; var lmodord: InfoEstudModalidad);
 begin
   writeln('Hola');
 end;

{ Retorna dos listas de estudiantes, de acuerdo a la modalidad en que cursaor la asignatura 
  Retorna también la cantidad de estudiantes que cursaron en modalidad PRESENCIAL y la de los 
  que cursaron en modalidad REMOTO. }
procedure estudEnModalidad(cestudiantes: InfoEstudiantes; 
                           var estudmod:EstudModalidad; 
                           var npres,nrem:integer);
var
  i: integer;
  nuevo, actual, anterior: InfoEstudModalidad;
begin
  estudmod.presencial := nil;
  estudmod.remoto := nil;
  npres := 0;
  nrem := 0;
  if cestudiantes.tope > 0 then
    for i := 1 to cestudiantes.tope do
    begin
      new(nuevo);
      nuevo^.ciest := cestudiantes.estudiantes[i].CI;
      nuevo^.indice := i;
      nuevo^.sig := nil;
      if cestudiantes.estudiantes[i].modalidad = PRESENCIAL then
      begin
        npres := npres + 1;
        anterior := nil;
        actual := estudmod.presencial;
        while (actual <> nil) and (actual^.ciest < nuevo^.ciest) do
        begin
          anterior := actual;
          actual := actual^.sig;
        end;
        if anterior = nil then
          estudmod.presencial := nuevo
        else
          anterior^.sig := nuevo;
        nuevo^.sig := actual;
      end
      else
      begin
        nrem := nrem + 1;
        anterior := nil;
        actual := estudmod.remoto;
        while (actual <> nil) and (actual^.ciest < nuevo^.ciest) do
        begin
          anterior := actual;
          actual := actual^.sig;
        end;
        if anterior = nil then
          estudmod.remoto := nuevo
        else
          anterior^.sig := nuevo;
        nuevo^.sig := actual;
      end;
    end;
end;
                    

{ Retorna el primer estudiante que cursó en la modalidad dada y que obtuvo el resultado` indicado }
procedure buscarEstudianteCalificacion (cestudiantes:InfoEstudiantes;
                                        estudmod:EstudModalidad; 
                                        modalidad:char; resultado : ResultadoCurso; 
                                        var encontrado : boolean; var estud : Estudiante);
 var p : InfoEstudModalidad;
 begin
  if modalidad = 'P' then
    begin
    p := estudmod.presencial;
    while (p <> nil) and (resultadoEstudiante(cestudiantes.estudiantes[p^.indice]) <> resultado) do
      p := p^.sig;
    if p <> nil then
      begin
        encontrado := true;
        estud := cestudiantes.estudiantes[p^.indice];
      end
    else
      encontrado := false;
    end;
 end;
    