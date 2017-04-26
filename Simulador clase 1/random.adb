--  Autor : Javier Miranda
--  Fecha : 22/Diciembre/2000
--  Descripcion: Paquete para calculo de numeros aleatorios.

with Ada.Numerics.Float_Random;
with Ada.Calendar;
package body Random is
   Generador : Ada.Numerics.Float_Random.Generator;

   function Float_Random return Float is
   begin
      return Ada.Numerics.Float_Random.Random (Generador);
   end Float_Random;

   function Positive_Random (Maximo : in Natural) return Positive is
   begin
      return Natural (Float (Maximo-1) * Float_Random) + 1;
   end Positive_Random;

   Hora_Actual : Ada.Calendar.Time := Ada.Calendar.Clock;
begin
   --  Inicializo la funcion de numeros aleatorios a partir de los
   --  segundos de la hora actual.
   Ada.Numerics.Float_Random.Reset
     (Generador, Integer (Ada.Calendar.Seconds (Hora_Actual)));
end Random;

