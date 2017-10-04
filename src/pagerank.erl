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
%% Map
%%================================================
map_function(Proc) ->
  receive
    {_From, {Row, Col, Val}, Vj} ->
      Result = Val * Vj,
      Proc ! {self(), {Row, Col, Result}},
      map_function(Proc)
  end.

%%==================================
%% Reduce
%%==================================

reduce_proc(From) ->
  receive
    {reduce, Dict} ->
      io:format("Reduce ~n"),
      Dict_Keys = lists:sort(dict:fetch_keys(Dict)),
      Fun = fun(I) ->
        L = dict:fetch(I, Dict),
        {I, lists:sum(L)}
      end,
      R = lists:map(Fun, lists:seq(1, length(Dict_Keys))),
      io:format("R = ~w~n",[R])
  end.


