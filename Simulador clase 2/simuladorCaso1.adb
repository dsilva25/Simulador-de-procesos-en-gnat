with Ada.Text_Io, Ada.Integer_Text_IO, Ada.Float_Text_IO;
use Ada.Text_Io, Ada.Integer_Text_IO, Ada.Float_Text_IO;
with TipoSemaforos;
WITH Random;

procedure simuladorCaso1 is 
-- declarar semaforos
	package Paquete_Semaforos is new TipoSemaforos;
	use Paquete_Semaforos;
	materiaPrima : TSemaforo; 
	piezacortada : TSemaforo; 
	piezatorno : TSemaforo; 
	piezamolino : TSemaforo;
	piezainspeccion : TSemaforo;
	piezahorno : TSemaforo; 
	piezasalida : TSemaforo; 
-- declarar semaforos

-- declarar variables
	contadorInspeccion : Integer := 0; 
	entero : Integer;
	inventario_procesos : Integer; 
	piezas_rechazadas : Integer;
	piezas_terminadas : Integer; 

-- declarar variables

	-- entreda a bodega
	task type maquinaentrada(pid: natural);
	task body maquinaentrada is
	begin
		for i in 1..200 loop
			delay(5.0);
			entero := Random.Positive_Random(100); 
			if (entero <= 17) then
				put_line("Entrando materia prima");
				signal(materiaPrima); 
				delay(0.0);
			end if;  
		end loop; 
	end maquinaentrada; 

	type Tipomaquinaentrada is access maquinaentrada;
	unamaquinaentrada : Tipomaquinaentrada;

	-- maquina cortadora
	task type maquinacortadora(pid: natural);
	task body maquinacortadora is
	begin
		for i in 1..200 loop
			put_line("Esperando materia prima"); 
			for j in 1..1 loop
				wait(materiaPrima); 
				delay(0.1); 
			end loop;

			for k in 1..1 loop
				put_line("Cortando pieza"); 
				delay(4.0);
				for a in 1..5 loop 
					signal(piezacortada); 
				end loop;
			end loop;
		end loop; 
	end maquinacortadora;

	type Tipomaquinacortadora is access maquinacortadora;
	unamaquinacortadora : Tipomaquinacortadora;

	-- maquina torno 

	task type maquinatorno(pid: natural);
	task body maquinatorno is
	begin
		for i in 1..200 loop
			put_line("Esperando pieza cortada");
			wait(piezacortada); 
			delay(0.1); 
			put_line("Procesando pieza en torno");
			delay(3.0); 
			signal(piezatorno);
		end loop; 
	end maquinatorno;


	type Tipomaquinatorno is access maquinatorno;
	unamaquinaetorno : Tipomaquinatorno;

	--maquina molino

	task type maquinamolino(pid: natural);
	task body maquinamolino is
	begin
		for i in 1..200 loop
			put_line("esperando pieza torno"); 
			wait(piezatorno);
			delay(0.1);
			put_line("Procesando pieza en molino");
			delay(2.0); 
			signal(piezamolino); 
		end loop;
	end maquinamolino; 

	type Tipomaquinamolino is access maquinamolino;
	unamaquinamolino : Tipomaquinamolino;

	-- maquina inspeccion 

	task type maquinainspeccion(pid: natural);
	task body maquinainspeccion is
	begin
		for i in 1..200 loop
			put_line("esperando pieza molino"); 
			wait(piezamolino);
			delay(0.1);

			contadorInspeccion := contadorInspeccion + 1;
			delay(2.0);
			if ( contadorInspeccion = 10 ) then 
				contadorInspeccion := 0;

			else 
				put_line("inspeccionando pieza");
				signal(piezainspeccion);

				end if;  
			
			
		end loop;
	end maquinainspeccion; 
	type Tipomaquinainspeccion is access maquinainspeccion;
	unamaquinainspeccion : Tipomaquinainspeccion;

	--maquina horno
	task type maquinahorno(pid: natural);
	task body maquinahorno is
	begin
		for i in 1..200 loop
			put_line("Esperando piezas inspeccion");
			for j in 1..10 loop
				wait(piezainspeccion); 
				delay(0.1); 
			end loop; 
			put_line("Horneando"); 
			delay(10.0);
			for k in 1..10 loop
				signal(piezahorno);
			end loop; 
		end loop; 
	end maquinahorno; 

	type Tipomaquinahorno is access maquinahorno;
	unamaquinahorno : Tipomaquinahorno;

	-- maquina salida
	task type maquinasalida(pid: natural);
	task body maquinasalida is
	begin
		for i in 1..200 loop
			put_line("Esperando el lote");
			for j in 1..5 loop
				wait(piezahorno); 
				delay(0.05); 
			end loop; 
			for k in 1..1 loop
				put_line("Producto terminado"); 
				signal(piezasalida); 
				delay(0.5); 
			end loop;
		end loop;  
	end maquinasalida; 

	type Tipomaquinasalida is access maquinasalida;
	unamaquinasalida : Tipomaquinasalida;



	-- main principal

	begin

		wait(materiaPrima);
		wait(piezacortada);
		wait(piezatorno);
		wait(piezamolino); 
		wait(piezainspeccion);
		wait(piezahorno);
		wait(piezasalida);
		
		

		for i in 1..1 loop
				unamaquinaentrada := new maquinaentrada(i);
		end loop;

		for i in 1..1 loop
				unamaquinacortadora := new maquinacortadora(i);
		end loop;

		for i in 1..1 loop
				unamaquinaetorno := new maquinatorno(i);
		end loop;

		for i in 1..1 loop
				unamaquinamolino := new maquinamolino(i);
		end loop;

		for i in 1..1 loop
				unamaquinainspeccion := new maquinainspeccion(i);
		end loop;

		for i in 1..1 loop
				unamaquinahorno := new maquinahorno(i);
		end loop;

		for i in 1..1 loop
				unamaquinasalida := new maquinasalida(i);
		end loop;



end simuladorCaso1; 