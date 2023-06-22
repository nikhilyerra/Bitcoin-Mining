-module(client).
-export([start_client/1,extract/4,init/1,match/2]).

init(Node) ->
    spawn(client,start_client, [Node]).

start_client(Node) ->
    {server,Node} ! {self(), ready},
    receive
        {server, start, String, Zeroes,Client_coins} -> 
            calculate(String, Zeroes,Client_coins, Node)
    end.

extract(S,Zeroes,N, Node) -> 
    %X = lists:append(S,integer_to_list(N)),
    C = binary_to_list(base64:encode(crypto:strong_rand_bytes(9))),
    X = lists:append(S,C),
    B= [ element(C+1, {$0,$1,$2,$3,$4,$5,$6,$7,$8,$9,$a,$b,$c,$d,$e,$f}) || <<C:4>> <= crypto:hash(sha256,X)],
    A = match(B,Zeroes),
    if
        A == nomatch -> extract(S,Zeroes,N+1,Node);
        true -> 
            {server, Node} ! {coin, X, B},
            exit(normal)

    end.

match([Head | Rest], 0) ->
    matching;

match([Head | Rest], Z) ->
    case Head == $0 of
        true ->
            match(Rest,Z-1);
        false ->
            nomatch
    end.

calculate(S,Zeroes,C,Node) ->

    if C>0 ->   
            spawn(client, extract, [S,Zeroes,0, Node]),
            calculate(S,Zeroes,C-1,Node);
        true -> ok
    end.