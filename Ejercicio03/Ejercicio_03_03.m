clear all;
close all;
clc;

AnchoImagen = 10;
AltoImagen = 7.56;

PuntoD_X = 8.276038406570354;
PuntoD_Y = 1.357851066730977;

PuntoE_X = 8.94200878349143;
PuntoE_Y = 2.136524122823312;

PuntoF_X = 8.24530131225092;
PuntoF_Y = 6.931510836655059;

PuntoG_X = 6.298618672020083;
PuntoG_Y = 7.310601666594749;

img = CargarImagen('./ImagenIzq_GrayScale_Resized.JPG');
figure;
imshow(img);

filas = rows(img);
columnas = columns(img);

relacionEjeX = columnas / AnchoImagen;
relacionEjeY = filas / AltoImagen;



resultImage = zeros(filas, columnas);

ColumnaPuntoD = relacionEjeX * PuntoD_X;
FilaPuntoD = filas - (relacionEjeY  * PuntoD_Y);

ColumnaPuntoE = relacionEjeX * PuntoE_X;
FilaPuntoE = filas - (relacionEjeY  * PuntoE_Y);

ColumnaPuntoF = relacionEjeX * PuntoF_X;
FilaPuntoF = filas - (relacionEjeY  * PuntoF_Y);

ColumnaPuntoG = relacionEjeX * PuntoG_X;
FilaPuntoG = filas - (relacionEjeY  * PuntoG_Y);

MatrizOriginal = [FilaPuntoD,ColumnaPuntoD;
FilaPuntoE,ColumnaPuntoE;FilaPuntoF,ColumnaPuntoF;FilaPuntoG,ColumnaPuntoG];




AnchoImagen_2 = 10;
AltoImagen_2 = 7.56;

PuntoD_X_2 = 3.3796289056830053;
PuntoD_Y_2 = 1.306151157064555;

PuntoE_X_2 = 3.9705435871729042;
PuntoE_Y_2 = 2.106745241663773;

PuntoF_X_2 = 3.274789204128346;
PuntoF_Y_2 = 6.54813623479753;

PuntoG_X_2 = 1.3114275204683599;
PuntoG_Y_2 = 7.272483263720632;

img_2 = CargarImagen('./ImagenCen_GrayScale_Resized.JPG');
figure;
imshow(img_2)

filas_2 = rows(img_2);
columnas_2 = columns(img_2);

relacionEjeX_2 = columnas_2 / AnchoImagen_2;
relacionEjeY_2 = filas_2 / AltoImagen_2;



resultImage_2 = zeros(filas_2, columnas_2);

ColumnaPuntoD_2 = relacionEjeX_2 * PuntoD_X_2;
FilaPuntoD_2 = filas_2 - (relacionEjeY_2  * PuntoD_Y_2);

ColumnaPuntoE_2 = relacionEjeX_2 * PuntoE_X_2;
FilaPuntoE_2 = filas_2 - (relacionEjeY_2  * PuntoE_Y_2);

ColumnaPuntoF_2 = relacionEjeX_2 * PuntoF_X_2;
FilaPuntoF_2 = filas_2 - (relacionEjeY_2  * PuntoF_Y_2);

ColumnaPuntoG_2 = relacionEjeX_2 * PuntoG_X_2;
FilaPuntoG_2 = filas_2 - (relacionEjeY_2  * PuntoG_Y_2);


AjustePuntoE_Fila_2 = FilaPuntoD_2;
AjustePuntoE_Columna_2 = ColumnaPuntoE_2;

AjustePuntoF_Fila_2 = FilaPuntoG_2;
AjustePuntoF_Columna_2 = ColumnaPuntoF_2;



MatrizReferencias = [FilaPuntoD_2,ColumnaPuntoD_2;
FilaPuntoE_2,ColumnaPuntoE_2;FilaPuntoF_2,ColumnaPuntoF_2;FilaPuntoG_2,ColumnaPuntoG_2];


MHomografia = GenerarHomografia(MatrizOriginal, MatrizReferencias);

MHomografia = inv(MHomografia);

Punto1 = MHomografia * [1, 1, 1]';
Punto1 = Punto1 / Punto1(3);
Punto2 = MHomografia * [1, columnas, 1]';
Punto2 = Punto2 / Punto2(3);
Punto3 = MHomografia * [filas, 1, 1]';
Punto3 = Punto3 / Punto3(3);
Punto4 = MHomografia * [filas, columnas, 1]';
Punto4 = Punto4 / Punto4(3);

minCoord = [max(Punto1(1),Punto2(1)) max(Punto1(2), Punto3(2))];% - [1 1];
maxCoord = [min(Punto4(1),Punto3(1)) min(Punto4(2), Punto2(2))];% + [1 1];

relCoords = [filas columnas] ./ (maxCoord - minCoord)   ;

for i = [1:filas]
  for j = [1:columnas]

    result = MHomografia * [i, j, 1]';
    result = result / result(3);
    result = ((result  - [minCoord 1]').* [relCoords 1]');
    %result = ((result - [minCoord 1]') .* [relCoords 1]') + [1, 1, 0];
    %resultImage(floor(result(1)), floor(result(2))) = img(i, j);
%    xImg = max(min(floor(result(1)), filas), 1);
%    yImg = max(min(floor(result(2)), columnas), 1);
    
    %resultImage(i,j) = img(xImg, yImg);
    
    if !(round(result(1)) < 1 || round(result(1)) > filas) && ...
      !(round(result(2)) < 1 || round(result(2)) > columnas)
      resultImage(i,j) = img(round(result(1)), round(result(2)));
    else
      result;
    endif
  end
end

figure;
imshow(uint8(resultImage));


















































AnchoImagen_3 = 10;
AltoImagen_3 = 7.56;

PuntoD_X_3 = 5.886758317774585;
PuntoD_Y_3 = 6.294396955907192;

PuntoE_X_3 = 6.767936009341497;
PuntoE_Y_3 = 8.282419796637424;

PuntoF_X_3 = 4.532753572196157;
PuntoF_Y_3 = 6.219174470041724;

PuntoG_X_3 = 6.73569780111344;
PuntoG_Y_3 = 5.069345043240996;

img_3 = CargarImagen('./ImagenDer_GrayScale_Resized.JPG');
figure
imshow(img_3)

filas_3 = rows(img_3);
columnas_3 = columns(img_3);

relacionEjeX_3 = columnas_3 / AnchoImagen_3;
relacionEjeY_3 = filas_3 / AltoImagen_3;

resultImage_3 = zeros(filas_3, columnas_3);

ColumnaPuntoD_3 = relacionEjeX_3 * PuntoD_X_3;
FilaPuntoD_3 = filas_3 - (relacionEjeY_3  * PuntoD_Y_3);

ColumnaPuntoE_3 = relacionEjeX_3 * PuntoE_X_3;
FilaPuntoE_3 = filas_3 - (relacionEjeY_3  * PuntoE_Y_3);

ColumnaPuntoF_3 = relacionEjeX_3 * PuntoF_X_3;
FilaPuntoF_3 = filas_3 - (relacionEjeY_3  * PuntoF_Y_3);

ColumnaPuntoG_3 = relacionEjeX_3 * PuntoG_X_3;
FilaPuntoG_3 = filas_3 - (relacionEjeY_3  * PuntoG_Y_3);

MatrizOriginal = [FilaPuntoD_3,ColumnaPuntoD_3;
FilaPuntoE_3,ColumnaPuntoE_3;FilaPuntoF_3,ColumnaPuntoF_3;FilaPuntoG_3,ColumnaPuntoG_3];




AnchoImagen_4 = 10;
AltoImagen_4 = 7.56;

PuntoD_X_4 = 8.755046330849181;
PuntoD_Y_4 = 5.280528934182102;

PuntoE_X_4 = 9.64141835308403;
PuntoE_Y_4 = 7.215297971963546;

PuntoF_X_4 = 7.449315502395696;
PuntoF_Y_4 = 5.118503940870355;

PuntoG_X_4 = 9.670010998962573;
PuntoG_Y_4 = 4.194008390797449;


img_4 = CargarImagen('./ImagenCen_GrayScale_Resized.JPG');
figure;
imshow(img_4);

filas_4 = rows(img_4);
columnas_4 = columns(img_4);

relacionEjeX_4 = columnas_4 / AnchoImagen_4;
relacionEjeY_4 = filas_4 / AltoImagen_4;



resultImage_4 = zeros(filas_4, columnas_4);

ColumnaPuntoD_4 = relacionEjeX_4 * PuntoD_X_4;
FilaPuntoD_4 = filas_4 - (relacionEjeY_4  * PuntoD_Y_4);

ColumnaPuntoE_4 = relacionEjeX_4 * PuntoE_X_4;
FilaPuntoE_4 = filas_4 - (relacionEjeY_4  * PuntoE_Y_4);

ColumnaPuntoF_4 = relacionEjeX_4 * PuntoF_X_4;
FilaPuntoF_4 = filas_4 - (relacionEjeY_4  * PuntoF_Y_4);

ColumnaPuntoG_4 = relacionEjeX_4 * PuntoG_X_4;
FilaPuntoG_4 = filas_4 - (relacionEjeY_4  * PuntoG_Y_4);


AjustePuntoE_Fila_4 = FilaPuntoD_4;
AjustePuntoE_Columna_4 = ColumnaPuntoE_4;

AjustePuntoF_Fila_4 = FilaPuntoG_4;
AjustePuntoF_Columna_4 = ColumnaPuntoF_4;



MatrizReferencias = [FilaPuntoD_4,ColumnaPuntoD_4;
FilaPuntoE_4,ColumnaPuntoE_4;FilaPuntoF_4,ColumnaPuntoF_4;FilaPuntoG_4,ColumnaPuntoG_4];


MHomografia = GenerarHomografia(MatrizOriginal, MatrizReferencias);

MHomografia = inv(MHomografia);

Punto1 = MHomografia * [1, 1, 1]';
Punto1 = Punto1 / Punto1(3);
Punto2 = MHomografia * [1, columnas, 1]';
Punto2 = Punto2 / Punto2(3);
Punto3 = MHomografia * [filas, 1, 1]';
Punto3 = Punto3 / Punto3(3);
Punto4 = MHomografia * [filas, columnas, 1]';
Punto4 = Punto4 / Punto4(3);

minCoord = [max(Punto1(1),Punto2(1)) max(Punto1(2), Punto3(2))];% - [1 1];
maxCoord = [min(Punto4(1),Punto3(1)) min(Punto4(2), Punto2(2))];% + [1 1];

relCoords = [filas columnas] ./ (maxCoord - minCoord)   ;

for i = [1:filas]
  for j = [1:columnas]

    result = MHomografia * [i, j, 1]';
    result = result / result(3);
    result = ((result  - [minCoord 1]').* [relCoords 1]');
    %result = ((result - [minCoord 1]') .* [relCoords 1]') + [1, 1, 0];
    %resultImage(floor(result(1)), floor(result(2))) = img(i, j);
%    xImg = max(min(floor(result(1)), filas), 1);
%    yImg = max(min(floor(result(2)), columnas), 1);
    
    %resultImage(i,j) = img(xImg, yImg);
    
    if !(round(result(1)) < 1 || round(result(1)) > filas) && ...
      !(round(result(2)) < 1 || round(result(2)) > columnas)
      resultImage_4(i,j) = img_3(round(result(1)), round(result(2)));
    else
      result;
    endif
  end
end

imshow(uint8(resultImage_4));