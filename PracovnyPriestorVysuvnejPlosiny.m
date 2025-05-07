clc; clear all; close all;

%tu môžete meniť hodnoty pre vykreslenie mechanizmu:
L1=10;
L2=1;
L3=1;
L4=1;
L5=30;
L6=1;
phi1=deg2rad(20);
phi2=deg2rad(45);
phi3=deg2rad(-170);

%definujem matice (z cvicenia):
Tx0 = [1 0 0 -L1;0 1 0 0;0 0 1 0;0 0 0 1];
Tz1 = [1 0 0 0;0 1 0 0;0 0 1 L3;0 0 0 1];
Rz2 = [cos(phi1) -sin(phi1) 0 0;sin(phi1) cos(phi1)  0 0;0 0 1 0;0 0 0 1];
Tx3 = [1 0 0 L2;0 1 0 0;0 0 1 0;0 0 0 1];
Tz4 = [1 0 0 0;0 1 0 0;0 0 1 L4;0 0 0 1];
Ry5 = [cos(phi2)  0 sin(phi2) 0;0 1 0 0;-sin(phi2) 0 cos(phi2) 0;0 0 0 1];
Tz6 = [1 0 0 0;0 1 0 0;0 0 1 L5;0 0 0 1];
Ry7 = [cos(phi3) 0 sin(phi3) 0;0 1 0 0;-sin(phi3) 0 cos(phi3) 0;0 0 0 1];

T08 = Tx0 * Tz1 * Rz2 * Tx3 * Tz4 * Ry5 * Tz6 * Ry7;
disp('Výsledná matica T08:');
disp(T08);

p7 = [L6;0;0;1]; %poloha bodu P v jeho suradnicovom systeme
%Bod P v svetovych suradniciach:
disp('poloha bodu P vo svetových súradniciach:');
p = T08 * p7

%idem vykreslovat

%definujem si kazdu maticu poriadne, vynasobenu vsetkymi pred nou
T00 = eye(4);   %matica 4x4 s jednotkami v diagonale
T01 = Tx0 * T00;
T02 = T01 * Tz1;
T03 = T02 * Rz2;
T04 = T03 * Tx3;
T05 = T04 * Tz4;
T06 = T05 * Ry5;
T07 = T06 * Tz6;
T08 = T07 * Ry7;

% suradnice jednotlivych bodov kde je rotacia alebo translacia
b0 = T00(1:3,4); %ale to su iba ich polohy, aby som ich mohol vykreslit
b1 = T01(1:3,4);
b2 = T02(1:3,4);
b3 = T03(1:3,4);
b4 = T04(1:3,4);
b5 = T05(1:3,4);
b6 = T06(1:3,4);
b7 = T07(1:3,4);
P  = p(1:3);

%PRVY OBRAZOK
% vykreslenie hasicskeho auta - pospajanie tych bodov
figure;
plot3([b0(1) b1(1) b2(1) b3(1) b4(1) b5(1) b6(1) b7(1) P(1)],...
      [b0(2) b1(2) b2(2) b3(2) b4(2) b5(2) b6(2) b7(2) P(2)],...
      [b0(3) b1(3) b2(3) b3(3) b4(3) b5(3) b6(3) b7(3) P(3)],...
      'ko-','LineWidth',2,'MarkerFaceColor','k');
hold on;
grid on; axis equal;
title('Zjednodušené hasičské auto s plošinou');
xlabel('X');
ylabel('Y');
zlabel('Z');
%vykreslenie pomocnych osí:
nakresli_os(T00);
nakresli_os(T01);
nakresli_os(T02);
nakresli_os(T03);
nakresli_os(T04);
nakresli_os(T05);
nakresli_os(T06);
nakresli_os(T07);
nakresli_os_hrubym(T08);
hold off;


%DRUHY OBRAZOK
figure;
plot3([b0(1) b1(1) b2(1) b3(1) b4(1) b5(1) b6(1) b7(1) P(1)],...
      [b0(2) b1(2) b2(2) b3(2) b4(2) b5(2) b6(2) b7(2) P(2)],...
      [b0(3) b1(3) b2(3) b3(3) b4(3) b5(3) b6(3) b7(3) P(3)],...
      'ko-','LineWidth',1,'MarkerFaceColor','k');
hold on;
grid on; axis equal;
title('Pracovný priestor');
xlabel('X');
ylabel('Y');
zlabel('Z');

% kreslim pomocne suradnicove systemy (funkcie su definovane naspodku kodu):
nakresli_os(T00);
nakresli_os(T01);
nakresli_os(T02);
nakresli_os(T03);
nakresli_os(T04);
nakresli_os(T05);
nakresli_os(T06);
nakresli_os(T07);
nakresli_os_hrubym(T08);

%ROVINA X0Z0 (modra):
bodyXZ = [];

%velky obluk
L5=40;
phi3=deg2rad(-90);
phi2_velkyObluk = deg2rad(0:0.25:90);
for phi1=[0,pi]
    for phi2 = phi2_velkyObluk
        p = pocitajp(phi1, phi2, phi3, L1, L2, L3, L4, L5, L6);
        bodyXZ = [bodyXZ p(1:3)];
    end
end

%spodok velkeho obluka
L5=40;
phi2=deg2rad(90);
phi3_spodok=deg2rad(-90:1:0);
for phi1=[0,pi]
    for phi3 = phi3_spodok
        p = pocitajp(phi1, phi2, phi3, L1, L2, L3, L4, L5, L6);
        bodyXZ = [bodyXZ p(1:3)];
    end
end

%horny vyrez
L5=40;
phi2=0;
phi3_hornyVyrez=deg2rad(-180:10:-90);
for phi1=[0,pi]
    for phi3=phi3_hornyVyrez
        p = pocitajp(phi1, phi2, phi3, L1, L2, L3, L4, L5, L6);
        bodyXZ = [bodyXZ p(1:3)];
    end
end

%maly obluk (treba pre phi3=0 aj phi=180)
L5=10;
phi3=deg2rad(-180);
phi2_malyObluk = deg2rad(0:0.25:90);
for phi1=[0,pi]
    for phi3=[0,-pi]
        for phi2 = phi2_malyObluk
            p = pocitajp(phi1, phi2, phi3, L1, L2, L3, L4, L5, L6);
            bodyXZ = [bodyXZ p(1:3)];
        end
    end
end

%ciara
L5_ciara=10:0.2:40;
phi3=deg2rad(0);
phi2=deg2rad(90);
for phi1=[0,pi]
    for L5=L5_ciara
        p = pocitajp(phi1, phi2, phi3, L1, L2, L3, L4, L5, L6);
        bodyXZ = [bodyXZ p(1:3)];
    end
end

%ROVINA X0Y0 (oranzova):
bodyXY = [];
phi2=deg2rad(90);
phi3=deg2rad(-90);
L5=40;
phi1_modra=deg2rad(0:0.5:360);
for phi1=phi1_modra
    p = pocitajp(phi1, phi2, phi3, L1, L2, L3, L4, L5, L6);
    p(3) = 0; %nech sa to zobrazi pekne v osi xy
    bodyXY = [bodyXY p(1:3)];
end

plot3(bodyXY(1,:), bodyXY(2,:), bodyXY(3,:), '.', 'Color', [1, 0.5, 0]); % orange
plot3(bodyXZ(1,:), bodyXZ(2,:), bodyXZ(3,:), '.', 'Color', [0, 0, 1]);   % blue


%vykreslenie osi otacania
z = linspace(0, 50, 20);
x = -10 * ones(1, 20); 
y = zeros(1, 20);
bodyVertical = [x; y; z];
plot3(bodyVertical(1,:), bodyVertical(2,:), bodyVertical(3,:), 'k.');

%---------------------------------------------
%funkcia na pocitanie matic
function p = pocitajp(phi1, phi2, phi3, L1, L2, L3, L4, L5, L6)
    Tx0 = [1 0 0 -L1; 0 1 0 0; 0 0 1 0; 0 0 0 1];
    Tz1 = [1 0 0 0; 0 1 0 0; 0 0 1 L3; 0 0 0 1];
    Rz2 = [cos(phi1) -sin(phi1) 0 0; sin(phi1) cos(phi1) 0 0; 0 0 1 0; 0 0 0 1];
    Tx3 = [1 0 0 L2; 0 1 0 0; 0 0 1 0; 0 0 0 1];
    Tz4 = [1 0 0 0; 0 1 0 0; 0 0 1 L4; 0 0 0 1];
    Ry5 = [cos(phi2) 0 sin(phi2) 0; 0 1 0 0; -sin(phi2) 0 cos(phi2) 0; 0 0 0 1];
    Tz6 = [1 0 0 0; 0 1 0 0; 0 0 1 L5; 0 0 0 1];
    Ry7 = [cos(phi3) 0 sin(phi3) 0; 0 1 0 0; -sin(phi3) 0 cos(phi3) 0; 0 0 0 1];
    T07 = Tx0*Tz1*Rz2*Tx3*Tz4*Ry5*Tz6*Ry7;
    p8 = [L6;0;0;1];
    p = T07 * p8;
end

% funkcie co kreslia osi:
function nakresli_os(T)
    bod = T(1:3,4);
    os_x = bod + 2*T(1:3,1);
    os_y = bod + 2*T(1:3,2);
    os_z = bod + 2*T(1:3,3);
    plot3([bod(1),os_x(1)],[bod(2),os_x(2)],[bod(3),os_x(3)],'r','LineWidth',1);
    plot3([bod(1),os_y(1)],[bod(2),os_y(2)],[bod(3),os_y(3)],'g','LineWidth',1);
    plot3([bod(1),os_z(1)],[bod(2),os_z(2)],[bod(3),os_z(3)],'b','LineWidth',1);
end

function nakresli_os_hrubym(T)
    bod = T(1:3,4);
    os_x = bod + 2*T(1:3,1);
    os_y = bod + 2*T(1:3,2);
    os_z = bod + 2*T(1:3,3);
    plot3([bod(1),os_x(1)],[bod(2),os_x(2)],[bod(3),os_x(3)],'r','LineWidth',2);
    plot3([bod(1),os_y(1)],[bod(2),os_y(2)],[bod(3),os_y(3)],'g','LineWidth',2);
    plot3([bod(1),os_z(1)],[bod(2),os_z(2)],[bod(3),os_z(3)],'b','LineWidth',2);
end
