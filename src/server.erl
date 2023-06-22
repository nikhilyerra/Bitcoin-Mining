-module(server).

-define(SERVER_COINS,2).
-define(CLIENT_COINS,700).
-define(MAX_COINS,2).
-define(UFID,"57914323:").

-export([init/2, extract/3, calculate/3,listen_coins/3, start/1,match/2]).

% extract method is used to mine the coins
extract(S,Zeroes,N) -> 
    C = binary_to_list(base64:encode(crypto:strong_rand_bytes(9))),
    X = lists:append(S,C),
    B= [ element(C+1, {$0,$1,$2,$3,$4,$5,$6,$7,$8,$9,$a,$b,$c,$d,$e,$f}) || <<C:4>> <= crypto:hash(sha256,X)],
    A=match(B,Zeroes),
    if 
       A == nomatch -> extract(S,Zeroes,N+1);
        true -> 
            server ! {coin,X,B},
            exit(normal)
    end.

% match method is used to verify whether the required number of zeros are present
%  at the starting of hash value
match([Head | Rest], 0) ->
    matching;

match([Head | Rest], Zeroes) ->
    case Head == $0 of
        true ->
            match(Rest,Zeroes-1);
        false ->
            nomatch
    end.


calculate(S,Zeroes,C) ->
    if C>0 ->   
            spawn(server, extract, [S,Zeroes,0]),
            calculate(S,Zeroes,C-1);
        true -> ok
    end.

init(Zeroes,ID) ->
    {_,_} = statistics(runtime),
    {_,_} = statistics(wall_clock),
    calculate(ID,Zeroes,?SERVER_COINS),
    io:format("Started mining ~p coins~n",[?MAX_COINS]),
    listen_coins(ID,Zeroes,?MAX_COINS).

start(Zeroes) ->
    register(server, spawn(server,init, [Zeroes,?UFID])).

cpu_real_time() ->
    {_,Cpu} = statistics(runtime),
    {_,Real} =statistics(wall_clock),
    io:format("CPU time: ~p, Real time: ~p, CPU/Real: ~p ~n",[Cpu,Real, Cpu / Real]).

% Method to listen for coins from server and client
listen_coins(S,Zeroes,N) ->
    receive 
        {From,ready} -> 
            io:format("Client has been connected~n"),
            From ! {server, start, S, Zeroes,?CLIENT_COINS},
            listen_coins(S,Zeroes,N);
        {coin, X, B} -> 
            if N>0 ->
                io:format("~p   ~p~n", [X,B]),
                if N-1 == 0 ->
                    cpu_real_time(),
                    io:format("Completed mining ~p coins~n",[?MAX_COINS]),
                    listen_coins(S,Zeroes,N-1);
                    true ->
                    listen_coins(S,Zeroes,N-1)
                end;    
                true ->
                    listen_coins(S,Zeroes,N)
        end
end.