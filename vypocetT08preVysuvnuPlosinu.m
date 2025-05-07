clc; clear all; close all;

syms L1 L2 L3 L4 L5 L6 phi1 phi2 phi3 real %pouzivam symbolic math toolbox

%definujem transformacne matice
Tx0 = [1 0 0 -L1;0 1 0 0;0 0 1 0;0 0 0 1];
Tz1 = [1 0 0 0;0 1 0 0;0 0 1 L3;0 0 0 1];
Rz2 = [cos(phi1) -sin(phi1) 0 0;sin(phi1) cos(phi1)  0 0;0 0 1 0;0 0 0 1];
Tx3 = [1 0 0 L2;0 1 0 0;0 0 1 0;0 0 0 1];
Tz4 = [1 0 0 0;0 1 0 0;0 0 1 L4;0 0 0 1];
Ry5 = [cos(phi2)  0 sin(phi2) 0;0 1 0 0;-sin(phi2) 0 cos(phi2) 0;0 0 0 1];
Tz6 = [1 0 0 0;0 1 0 0;0 0 1 L5;0 0 0 1];
Ry7 = [cos(phi3) 0 sin(phi3) 0;0 1 0 0;-sin(phi3) 0 cos(phi3) 0;0 0 0 1];

%vypocet a vypisanie vyslednej matice
T08 = simplify(Tx0 * Tz1 * Rz2 * Tx3 * Tz4 * Ry5 * Tz6 * Ry7);
disp('Výsledná matica T08 =')
disp(T08)

%vypocet a vypisanie vektoru p
p8 = [L6; 0; 0; 1];
p = simplify(T08 * p8);
disp('Výsledný vektor p =')
disp(p)

syms L1 L2 L3 L4 L5 L6 phi1 phi2 phi3 real %pouzivam symbolic math toolbox
%definujem transformacne matice
%....
%vypocet a vypisanie vyslednej matice
T08 = simplify(Tx0 * Tz1 * Rz2 * Tx3 * Tz4 * Ry5 * Tz6 * Ry7);
disp('Výsledná matica T08 =')
disp(T08)
%vypocet a vypisanie vektoru p
p8 = [L6; 0; 0; 1];
p = simplify(T08 * p8);
disp('Výsledný vektor p =')
disp(p)
