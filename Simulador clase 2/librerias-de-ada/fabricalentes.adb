with Ada.Text_Io, Ada.Integer_Text_IO, Ada.Float_Text_IO;
use Ada.Text_Io, Ada.Integer_Text_IO, Ada.Float_Text_IO;
with TipoSemaforos;
WITH Random;

procedure fabricalentes is


  package Paquete_Semaforos is new TipoSemaforos;
  use Paquete_Semaforos;
  tornillolisto : TSemaforo;
  cristallisto : TSemaforo;
  
  -- inicio tornillos
  task type MaquinaTornillera(p: natural);
  task body MaquinaTornillera is
    unRealAzar5 : Float; 
  begin
     loop
		delay(5.0);
		put_line("produje un tornillo");
		signal(tornillolisto);
     end loop;
  end MaquinaTornillera;

   type TipoMaquinaTornillera is access MaquinaTornillera ;
   UnaMaquinaTornillera : TipoMaquinaTornillera ;
   -- fin tornillos
   
   -- inicio cristales
  task type MaquinaCristalera(p: natural);
  task body MaquinaCristalera is
     
  begin
     loop
		delay(7.0);
		put_line("produje un cristal");
		signal(cristallisto);
     end loop;
  end MaquinaCristalera;

   type TipoMaquinaCristalera is access MaquinaCristalera ;
   UnaMaquinaCristalera : TipoMaquinaCristalera ;
   -- fin cristales
   

   -- inicio ensamblar
  task type MaquinaEnsambladora(p: natural);
  task body MaquinaEnsambladora is
     unEnteroAlAzar1 : Integer; 
  begin
     loop
		put_line("esperando");
		wait(tornillolisto);
		wait(cristallisto);
		wait(tornillolisto);
		wait(cristallisto);
		put_line("llego el primer trabajo");
		unEnteroAlAzar1 := Random.Positive_Random(100);
		if (unEnteroAlAzar1>50) then
			put_line("tinyendo");
			delay(3.0);
		end if;
			put_line("ensamblando");
			delay(2.0);
		put_line("salio el primer trabajo");
     end loop;
  end MaquinaEnsambladora;

   type TipoMaquinaEnsambladora is access MaquinaEnsambladora ;
   UnaMaquinaEnsambladora : TipoMaquinaEnsambladora ;
   -- fin ensamblar

   
   
   
   begin
   wait(tornillolisto); -- el semaforo parte en 1 por eso hay que bajarlo a cero
   wait(cristallisto);
   
   UnaMaquinaTornillera := new MaquinaTornillera(1);
   UnaMaquinaCristalera := new MaquinaCristalera(1);
   UnaMaquinaEnsambladora := new MaquinaEnsambladora(1);
   
end fabricalentes;


