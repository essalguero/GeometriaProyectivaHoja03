clc
clear all

%Puntos elegidos en la imagen 1
x1 = [2.538936385222061 9.664067426183657 1];
x2 = [8.658672591526601 2.851530894637108 1];
x3 = [19.916677876709482 11.684735041472887 1];
x4 = [20.78267828326201 14.97553658637249 1];
x5 = [8.139072347595084 6.200065799973547 1];
x6 = [1.2688024556116848 13.243535773267435 1];
x7 = [13.046407984726082 18.78593837520361 1];
x8 = [6.868938417984707 15.495136830304007 1];
x9 = [13.68147494953127 10.645534553609854 1];
x10 = [19.108410830593787 14.167269540256799 1];
x11 = [19.050677470156952 15.437403469867172 1];
x12 = [13.5660082286576 11.627001681036052 1];
x13 = [6.695738336674201 16.53433731816704 1];
x14 = [11.834007415552541 19.016871816950953 1];

%Puntos elegidos en la imagen 2
x1_ = [3.653930170839321 8.289940984711434 1];
x2_ = [11.854431244589355 3.587283970854776 1];
x3_ = [17.956225882403363 13.225787602560985 1];
x4_ = [18.65579469438204 15.713143378485167 1];
x5_ = [12 6 1];
x6_ = [2.6434418868701224 11.049351298627323 1];
x7_ = [10.921672828617787 18.511418626399873 1];
x8_ = [6.801989824743362 14.352870688526629 1];
x9_ = [14.691571426502874 10.816161694634431 1];
x10_ = [17.528711608416394 14.780384962513597 1];
x11_ = [17.72303627841047 15.829738180481613 1];
x12_ = [14.808166228499319 11.515730506613108 1];
x13_ = [6.685395022746916 15.246764170499382 1];
x14_ = [10.222104016639111 18.472553692401057 1];

%Pasar los puntos a matrices
x = [x1; x2; x3; x4; x5; x6; x7; x8; x9; x10; x11; x12; x13; x14];
x_ = [x1_; x2_; x3_; x4_; x5_; x6_; x7_; x8_; x9_; x10_; x11_; x12_; x13_; x14_];

% Caras que forman los puntos elegidos
faces = [1, 2, 5, 6; 8, 9, 12, 13; 2, 3, 4, 5; 9, 10, 11, 12; 6, 5, 4, 7; ...
         13, 12, 11, 14]

%Obtener F y epipolos e1 y e2
[F,e1,e2] = fundmatrix2(x', x_');

% Matriz e'[x]
ex = [0, -e2(3) e2(2); e2(3) 0 -e2(1); -e2(2) e2(1) 0];

%Obtener matrices camara P1 y P2
P1 = eye(3);
P1 = [P1, [0; 0; 0]];
P2 = ex * F;
P2 = [P2 , e2];


%Generar matriz en la que guardar los puntos
PuntosTriangulacion = zeros(14, 4);

%Calcular los puntos por triangulacion
for i = [1:14]

%Filas que formaran la matriz A
B = x(i,1)*P1(3,:) - P1(1,:);
C = x(i,2)*P1(3,:) - P1(2,:);
D = x_(i,1)*P2(3,:) - P2(1,:);
E = x_(i,2)*P2(3,:) - P2(2,:);

A = [B; C; D; E];

% Resolver sistema. Quedarse con la ultima columna de V
[U, S, V] = svd(A);

point = V(:,4);

%Homogeneizar las coordenadas de los puntos
point = point / point(4);

%Guardar todos los puntos obtenidos por triangulacion en una matriz X
PuntosTriangulacion(i,:) = point';

end


% Dibujar la figura obtenida después de la triangulación
% Tiene bastante deformación de proyección
figure
patch("Faces", faces(1:2,:), "Vertices", PuntosTriangulacion(:,1:3), "FaceColor", "r");
patch("Faces", faces(3:4,:), "Vertices", PuntosTriangulacion(:,1:3), "FaceColor", "g");
patch("Faces", faces(5:6,:), "Vertices", PuntosTriangulacion(:,1:3), "FaceColor", "b");
title("Triangulacion")

%Hacer una matriz de puntos de correspondencia
%Los valores se obtienen de los datos dados en el problema (Dimensiones de la caja)
mCor = [0, 0, 0, 1;
        27, 0, 0, 1;
        27, 38, 0, 1;
        27, 38, 11, 1;
        27, 0, 11, 1];

%Obtener la homografía para hacer la reconstruccion directa 
% Usando 5 puntos de control (mCor)
homografia = GenerarHomografiaControl(PuntosTriangulacion(1:5,:), mCor);

%Puntos de reconstrucción métrica
XE = homografia * X'

%Dibujar la reconstrucción métrica
figure
patch("Faces", faces(1:2,:), "Vertices", XE'(:,1:3), "FaceColor", "r");
patch("Faces", faces(3:4,:), "Vertices", XE'(:,1:3), "FaceColor", "g");
patch("Faces", faces(5:6,:), "Vertices", XE'(:,1:3), "FaceColor", "b");
title("Reconstruccion Directa")