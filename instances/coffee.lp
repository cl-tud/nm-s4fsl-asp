% example: the coffee example
% intended semantics: single minimal model, where the global "hot" overrides the local vietnamese iced - because a precisification with "hot" is accessible from the global standpoint.

    % known(box(all,coffee)) 
    % known(box(all,hot)) 

    % known(box(ita,espresso)) 
    % known(box(usa,lcaffeine)) 

    % known(box(ita,coffee)) 
    % known(box(usa,coffee)) 
    % known(box(vnm,coffee)) 

    % known(box(vnm,neg(iced)))


%%%%% Example start    

% Only for debugging. 
% patom(coffee;hot;espresso;lcaffeine;iced).
% pstand(all;ita;usa;vnm).

% Box_all[coffee:hot/hot]
normaldefault(all, coffee, hot).

% Box_ita[coffee:espresso/espresso]
normaldefault(ita, coffee, espresso).

% Box_usa[coffee:lcaffeine/lcaffeine]
normaldefault(usa, coffee, lcaffeine).

% Box_vnm[coffee:iced/iced]
normaldefault(vnm, coffee, iced).

% knowledge base
form(box(all,coffee)).
form(box(all,neg(and(espresso,lcaffeine)))).
form(box(all,neg(and(iced,hot)))).

succ(coffee,hot).
succ(hot,espresso).
succ(espresso,lcaffeine).
succ(lcaffeine,iced).

