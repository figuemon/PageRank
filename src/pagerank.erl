%% Instituto Tecnologico de Costa Rica
%% Maestria en Computacion
%% Bases de Datos Avanzadas - Profesor: Jose Castro
%% @author Manuel Figueroa Montero
%% Page Rank - Erlang


-module(pagerank).

%% > multMatriz(Nodos, Trabajadores, Reductores, Matrix, Vector).
%% Donde:
%% 1. Nodos es la lista de nombres de los nodos donde va a ejecutar los trabajadores.
%% 2. Trabajadores es la cantidad total de trabajadores que debe distribuirse equitativamente entre los
%% nodos.
%% 3. Reductores es la cantidad total de reduce tasks, igual debe distribuirla equitativamente entre los
%% nodos.
%% 4. Matrix es el nombre del archivo donde se encuentra la matriz.
%% 5. Vector es el nombre del archivo donde se encuentra el vector a multiplicar.


