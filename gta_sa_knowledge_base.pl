% Knowledge Base for GTA San Andreas

% Facts: Characters in GTA San Andreas
character(cj).                          
character(big_smoke).                   
character(ryder).                       
character(sweet).                       
character(kendl).                       
character(cesar_vialpando).
character(woozie).
character(jizzy_b).                     
character(madd_dogg).                   
character(t_bone_mendez).               
character(mike_toreno).                 
character(ken_rosenberg).
character(freddy).
character(salvatore_leone).

% Facts: Gangs
gang(grove_street_families).
gang(ballas).
gang(vagos).
gang(aztecas).
gang(triads).
gang(san_fierro_rifa).
gang(sindacco_family).
gang(leone_family).
gang(forelli_family).

% Facts: Locations in GTA San Andreas
location(los_santos).
location(san_fierro).
location(las_venturas).

% Facts: Gang membership of characters
gang_member(cj, grove_street_families).
gang_member(sweet, grove_street_families).
gang_member(ryder, grove_street_families).
gang_member(big_smoke, grove_street_families).
gang_member(cesar_vialpando, aztecas).
gang_member(woozie, triads).
gang_member(t_bone_mendez, san_fierro_rifa).
gang_member(jizzy_b, san_fierro_rifa).
gang_member(mike_toreno, san_fierro_rifa).
gang_member(ken_rosenberg, leone_family).
gang_member(salvatore_leone, leone_family).
gang_member(freddy, ballas).

% Facts: Betrayal
betrays(ryder, grove_street_families).
betrays(big_smoke, grove_street_families).

% Facts: Enemy relationships between gangs
enemy_of(grove_street_families, ballas).
enemy_of(grove_street_families, vagos).
enemy_of(aztecas, vagos).
enemy_of(triads, san_fierro_rifa).
enemy_of(leone_family, forelli_family).

% Facts: Locations of characters
located_in(cj, los_santos).
located_in(big_smoke, los_santos).
located_in(ryder, los_santos).
located_in(sweet, los_santos).
located_in(kendl, los_santos).
located_in(cesar_vialpando, los_santos).
located_in(woozie, san_fierro).
located_in(jizzy_b, san_fierro).
located_in(t_bone_mendez, san_fierro).
located_in(ken_rosenberg, las_venturas).
located_in(mike_toreno, las_venturas).
located_in(salvatore_leone, las_venturas).

% Facts: Vehicles owned by characters
vehicle(cj, bike).
vehicle(big_smoke, car).
vehicle(ryder, truck).
vehicle(cesar_vialpando, lowrider).
vehicle(madd_dogg, plush_infernus).
vehicle(woozie, elegy).

% Facts: Friendships between characters
friend_of(cj, sweet).
friend_of(cj, cesar_vialpando).
friend_of(cj, woozie).
friend_of(cj, madd_dogg).
friend_of(kendl, cesar_vialpando).
friend_of(sweet, cesar_vialpando).
friend_of(sweet, ryder).
friend_of(sweet, big_smoke).
friend_of(big_smoke, ryder).
friend_of(mike_toreno, t_bone_mendez).
friend_of(t_bone_mendez, jizzy_b).
friend_of(mike_toreno, jizzy_b).

% Rule: Characters are enemies if their gangs are enemies
is_enemy(X, Y) :-
    gang_member(X, Gang1),
    gang_member(Y, Gang2),
    (enemy_of(Gang1, Gang2); enemy_of(Gang2, Gang1)),
    X \= Y.

% Rule: Characters are in the same city
in_same_city(X, Y) :-
    located_in(X, City),
    located_in(Y, City),
    X \= Y.

% Rule: Friendships are mutual
are_friends(X, Y) :- friend_of(X, Y); friend_of(Y, X).

% Rule: Characters are allies if they are in the same gang or are friends
are_allies(X, Y) :-
    are_friends(X, Y),
    X \= Y;
    (gang_member(X, Gang),
    gang_member(Y, Gang),
    X \= Y).

% Rule: Characters need a vehicle to travel between cities
needs_vehicle_to_travel(X) :-
    character(X),
    \+ vehicle(X, _).

% Rule: A character is a traitor if they are a gang member but betray the gang
is_traitor(X) :-
    gang_member(X, Gang),
    betrays(X, Gang).


% Queries examples:

% - Find all gangs.
% gang(X).

% - Who are the gang members of Grove Street Families?
% gang_member(X, grove_street_families).

% - Who are Woozie's enemies?
% is_enemy(woozie, X).

% - Who is located in the same city as CJ?
% in_same_city(cj, X).

% - Does CJ need a vehicle to travel?
% needs_vehicle_to_travel(cj).

% - Are CJ and Cesar Vialpando allies?
% are_allies(cj, cesar_vialpando).

% - Find all characters who are gang members and located in Los Santos.
% gang_member(X, _), located_in(X, los_santos).

% - Find all characters who can meet in San Fierro.
% located_in(X, san_fierro), located_in(Y, san_fierro), X \= Y.

% - Who are the traitors of Grove Street Families?
% is_traitor(X), gang_member(X, grove_street_families).

% - Are CJ and Ryder friends?
% friends(cj, ryder).
