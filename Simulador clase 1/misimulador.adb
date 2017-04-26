with Ada.Text_Io, Ada.Integer_Text_IO, Ada.Float_Text_IO;
use Ada.Text_Io, Ada.Integer_Text_IO, Ada.Float_Text_IO;
with TipoSemaforos;
WITH Random;

procedure misimulador is

	package Paquete_Semaforos is new TipoSemaforos;
	use Paquete_Semaforos;
	sillinlisto: TSemaforo;
	marcolistosinpintar : TSemaforo;
	marcospintados : TSemaforo;
	rayolisto : TSemaforo; 
	ruedalista : TSemaforo; 

	--maquina emsambladora 


	task type maquinaensambladora(pid: natural);
	task body maquinaensambladora is
	begin
			for i in 1..200 loop -- 200 bicicletas
					put_line("esperando marco");
					for j in 1..1 loop 
						wait(marcospintados);
					end loop;
					put_line("esperando sillin");
					for j in 1..1 loop
						wait(sillinlisto);
					end loop; 
					put_line("esperando ruedas");
					for j in 1..2 loop
						wait(ruedalista); 
					end loop; 
					put_line("Bicicleta lista"); 
			end loop; 
	end maquinaensambladora; 

	type Tipomaquinaensambladora is access maquinaensambladora;
	unamaquinaensambladora : Tipomaquinaensambladora;

					

	--maquina ruedas

	task type maquinaruedas(pid: natural);
	task body maquinaruedas is
	begin
			for i in 1..200 loop -- crear 200 ruedas
					put_line("esperando rayos");

					for j in 1..40 loop
						wait(rayolisto);
					end loop;

					put_line("Haciendo Ruedas");
					delay(4.0);
					put_line("Rueda lista"); 
					signal(ruedalista); 
			end loop;
	end maquinaruedas; 

	type Tipomaquinaruedas is access maquinaruedas;
	unamaquinaruedas : Tipomaquinaruedas;
	

	--maquina de rayos
	task type maquinarayos(pid: natural);
	task body maquinarayos is
	begin
			for i in 1..200 loop -- crear 200 rayos
					put_line("haciendo un rayo");
					delay(1.0);
					put_line("rayo listo");
					signal(rayolisto);
			end loop;
	end maquinarayos;

	type Tipomaquinarayos is access maquinarayos;
	unamaquinarayos : Tipomaquinarayos;



	--Contruccion de marcos

	task type maquinamarcos(pid: natural);
	task body maquinamarcos is
	begin
			for i in 1..200 loop -- crear 200 marcos
				put_line("Haciendo un marco");
				delay(2.0); 
				put_line("Marco listo");
				signal(marcolistosinpintar);
			end loop; 
	end maquinamarcos; 
	type Tipomaquinamarcos is access maquinamarcos;
	unamaquinamarcos : Tipomaquinamarcos;

	

	--maquina Pintora

	task type maquinapintora(pid: natural);
	task body maquinapintora is
	begin
			for i in 1..200 loop -- pintar 200 veces
					put_line("esperando marcos");

					for j in 1..40 loop
						wait (marcolistosinpintar);
					end loop;

					put_line("pintando");
					delay(8.0);
					put_line ("ya pintados");

					for j in 1..40 loop
						signal(marcospintados);
					end loop;

			end loop; 
	end maquinapintora; 

	type Tipomaquinapintora is access maquinapintora;
	unamaquinapintora : Tipomaquinapintora; 

	--Maquina Sillines

	task type maquinasillines(pid: natural);
	task body maquinasillines is
	begin
			for i in 1..200 loop
					put_line("haciendo un sillin");
					delay(3.0); --3 segundos;
					put_line("sillin listo");
					signal(sillinlisto);
			end loop; --end del for
	end maquinasillines;

	type Tipomaquinasillines is access maquinasillines;
	unaMaquinasillines : Tipomaquinasillines;





begin -- del programa principal

		wait(sillinlisto);
		wait(marcolistosinpintar);
		wait(marcospintados);
		wait(rayolisto);
		wait(ruedalista);
		

		for i in 1..1 loop
				unaMaquinasillines := new maquinasillines(i);
		end loop;

		for i in 1..1 loop
				unamaquinapintora := new maquinapintora(i);
		end loop;

		for i in 1..1 loop
				unamaquinamarcos := new maquinamarcos(i);
		end loop; 

		for i in 1..1 loop
				unamaquinarayos := new maquinarayos(i);
		end loop; 

		for i in 1..1 loop
				unamaquinaruedas :=new maquinaruedas(i);
		end loop; 

		for i in 1..1 loop
				unamaquinaensambladora := new maquinaensambladora(i);
		end loop; 

end misimulador;
