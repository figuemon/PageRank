%% Instituto Tecnologico de Costa Rica
%% Maestria en Computacion
%% Bases de Datos Avanzadas - Profesor: Jose Castro
%% @author Manuel Figueroa Montero
%% Page Rank - Erlang


-module(pagerank).

-compile(export_all).

%%Output folder
-define(FOLDER, "output/").

%% > multMatriz(Nodos, Trabajadores, Reductores, Matrix, Vector).
%% Donde:
%% 1. Nodos es la lista de nombres de los nodos donde va a ejecutar los trabajadores.
%% 2. Trabajadores es la cantidad total de trabajadores que debe distribuirse equitativamente entre los
%% nodos.
%% 3. Reductores es la cantidad total de reduce tasks, igual debe distribuirla equitativamente entre los
%% nodos.
%% 4. Matrix es el nombre del archivo donde se encuentra la matriz.
%% 5. Vector es el nombre del archivo donde se encuentra el vector a multiplicar.
multMatriz(Nodos, Trabajadores, Reductores, Matrix, Vector)->
	%TODO Create outputFolder
	blocks = readMatrixFile(Matrix).

%%================================================
%% Procesamiento del archivo de Matriz
%%================================================

readMatrixFile(File) ->
    {ok, Device} = file:open(File,[read]),   
    readMatrixLines(Device, 1, sets:new()).

readMatrixLines(Device, S, Workers) ->
    case io:get_line(Device, "") of
        eof  -> file:close(Device), sets:to_list(Workers);
		Line -> io:format("Dato: ~s ", [Line]),
        readMatrixLines(Device, S + 1, Workers)
	end.
		



%%================================================
%% Funcion Map
%%================================================
map_function({Min, Max, List}, Reduce_PID) ->
	link(Reduce_PID), % If the reduce process exits early, extra map processes will also end.
	Result = [A * B * C || 	A <- List,
				B <- List,
				C <- lists:seq(Min, Max),
				A*A + B*B == C*C andalso A + B + C == 1000],
	Reduce_PID ! Result.
