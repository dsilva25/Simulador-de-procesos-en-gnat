with Ada.Text_Io, Ada.Integer_Text_IO, Ada.Float_Text_IO;
use Ada.Text_Io, Ada.Integer_Text_IO, Ada.Float_Text_IO;
with TipoSemaforos;
WITH Random;

procedure simuladorCaso2 is 
	
	package Paquete_Semaforos is new TipoSemaforos;
	use Paquete_Semaforos;
	--declarar semaforos
	clienteLento  : TSemaforo;
	clienteRapido : TSemaforo;

	atenderRapido : TSemaforo;
	atenderLento  : TSemaforo;
	--declarar semaforos

-- declarar variables
	entero : Integer;
	contadorClientesRapidos : Integer := 0;
	contadorClientesLentos : Integer := 0;
-- declarar variables

	--caja 1 

	task type maquinacaja1(pid: natural);
	task body maquinacaja1 is
	begin
		for i in 1..200 loop
			wait(atenderRapido);
			put_line("Esperando cliente rapido.");

			wait(clienteRapido);
			put_line("Atendiendo cliente rapido.");
			delay(2.0);
			put_line("Atencion finalizada cliente rapido.");

			contadorClientesRapidos := contadorClientesRapidos + 1;
			if ( contadorClientesRapidos = 5 ) then
				for j in 1..5 loop
					signal(atenderLento);
				end loop;

				contadorClientesRapidos := 0;
			end if;

		end loop; 
	end maquinacaja1; 

	type Tipomaquinacaja1 is access maquinacaja1;
	unamaquinacaja1 : Tipomaquinacaja1;

	--caja 2

	task type maquinacaja2(pid: natural);
	task body maquinacaja2 is
	begin
		for i in 1..200 loop
			wait(atenderLento);
			put_line("Esperando cliente lento.");
			wait(clienteLento);
			put_line("Atendiendo cliente lento.");
			delay(2.4);
			put_line("Atencion finalizada cliente lento.");

			contadorClientesLentos := contadorClientesLentos + 1;

			if ( contadorClientesLentos = 5 ) then
				for j in 1..5 loop
					signal(atenderRapido);
				end loop;

				contadorClientesLentos := 0;
			end if;
		end loop; 
	end maquinacaja2; 

	type Tipomaquinacaja2 is access maquinacaja2;
	unamaquinacaja2 : Tipomaquinacaja2;


	-- main principal

	begin 

		wait(clienteRapido);
		wait(clienteLento);

		wait(atenderRapido);
		wait(atenderLento);

		for l in 1..5 loop
			signal(atenderRapido);
		end loop;

		for k in 1..800 loop
			-- evaluar para clientes rapidos
			entero := Random.Positive_Random(100);
			if (entero <= 11) then
				signal(clienteRapido);
				--delay(5.0);
			end if;

			
		end loop;

		for j in 1..800 loop
			-- evaluar para clientes lentos
			entero := Random.Positive_Random(100);
			if (entero <= 4) then
				signal(clienteLento);
				--delay(5.0);
			end if;
			
		end loop;

		for i in 1..1 loop
			-- caja 1
			unamaquinacaja1 := new maquinacaja1(i);
		end loop;

		for i in 1..1 loop
			-- caja 2
			unamaquinacaja2 := new maquinacaja2(i);
		end loop;




end simuladorCaso2; 