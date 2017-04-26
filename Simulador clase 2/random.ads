--  Autor : Javier Miranda
--  Fecha : 22/Diciembre/2000
--  Descripcion: Paquete para calculo de numeros aleatorios.

package Random is

   function Float_Random return Float;

   function Positive_Random (Maximo : in Natural) return Positive;
   --  El parametro Maximo se utiliza para decir el valor maximo
   --  que se desea obtener. El resultado será un numero aleatorio
   --  en el rango 1 .. Maximo

end Random;

