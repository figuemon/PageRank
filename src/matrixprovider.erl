%% @author Manuel
%% @doc @todo Add description to matrixprovider.


-module(matrixprovider).

-compile(export_all).

%%================================================
%% Procesamiento del archivo de Matriz
%%================================================

%Create matrix chunks to be used for the map reduce algorithm
createMatrixBlocks(File, Nodes, BlockSize) ->
    {ok, Device} = file:open(File,[read]), 
    readInputFile(Device, 1, Nodes, BlockSize, sets:new()).

readInputFile(Device, S, Nodes, BlockSize, GeneratedBlocks) ->
    case io:get_line(Device, "") of
        eof  -> file:close(Device);
		Line -> 
			if S == 1 ->
				   io:format("MatrixSize: ~s~n",[Line]);
			true->		
				io:format("~s~n",[Line])
			end,
        readInputFile(Device, S + 1, Nodes, BlockSize, GeneratedBlocks)
	end.
		

parseSequence(Sequence) -> 
	{ok,Tokens,_EndLine} = erl_scan:string(Sequence),
	{ok,AbsForm} = erl_parse:parse_exprs(Tokens),
	{value,Value,_Bs} = erl_eval:exprs(AbsForm, erl_eval:new_bindings()),
	Value.
