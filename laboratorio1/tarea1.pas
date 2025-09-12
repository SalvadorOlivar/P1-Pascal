{ Validación de puntos obtenidos en actividad }
function PuntajeValidoParcial(actividad: char; puntajeObtenido: real): boolean;
begin
if actividad = 'p' then
    begin
      if (puntajeObtenido >= 0) and (puntajeObtenido <= 40) then
        PuntajeValidoParcial := True
      else
        PuntajeValidoParcial := False
    end;

if actividad = 's' then
    begin
      if (puntajeObtenido >= 0) and (puntajeObtenido <= 60) then
        PuntajeValidoParcial := True
      else
        PuntajeValidoParcial := False
    end;
end;

{Calculo total de puntos }
function CalcularTotalPuntos(modalidad : char; parcial1, parcial2: real; cuestionarios: integer): real;
begin
if modalidad = PRESENCIAL then
  begin
  CalcularTotalPuntos := parcial1 + parcial2 + cuestionarios
  end;

if modalidad = REMOTO then
  begin
  CalcularTotalPuntos := parcial1 + parcial2
  end;
end;

{ Puntos obtenidos en cuestionarios }
procedure LeerPuntosCuestionarios(var puntosCuestionarios: integer; var error: char);
var puntos, cont: integer;
begin
    puntosCuestionarios := 0;
    cont := 0;
    error := NO_ERROR;

    read(puntos);
    while puntos >= 0 do
    begin
        if puntos > 4 then
            error := RANGO_INCORRECTO_CUESTIONARIOS
        else
            puntosCuestionarios := puntosCuestionarios + puntos;
            cont := cont + 1;
        read(puntos);
    end;

    if cont > 3 then
        error := CANTIDAD_INCORRECTA_CUESTIONARIOS;
end;
