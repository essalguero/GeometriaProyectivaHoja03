clear all;
close all;

AnchoImagen = 10;
AltoImagen = 7.5;

PuntoD_X = 4.59;
PuntoD_Y = 3.1;

PuntoE_X = 5.97;
PuntoE_Y = 2.93;

PuntoF_X = 5.99;
PuntoF_Y = 4.35;

PuntoG_X = 4.58;
PuntoG_Y = 4.26;

img = CargarImagen("./FachadaLQ.jpg");
imshow(img)

filas = rows(img);
columnas = columns(img);

relacionEjeX = columnas / AnchoImagen;
relacionEjeY = filas / AltoImagen;



resultImage = zeros(filas, columnas);

ColumnaPuntoD = relacionEjeX * PuntoD_X
FilaPuntoD = filas - (relacionEjeY  * PuntoD_Y)

ColumnaPuntoE = relacionEjeX * PuntoE_X
FilaPuntoE = filas - (relacionEjeY  * PuntoE_Y)

ColumnaPuntoF = relacionEjeX * PuntoF_X
FilaPuntoF = filas - (relacionEjeY  * PuntoF_Y)

ColumnaPuntoG = relacionEjeX * PuntoG_X
FilaPuntoG = filas - (relacionEjeY  * PuntoG_Y)



AjustePuntoE_Fila = FilaPuntoD
AjustePuntoE_Columna = ColumnaPuntoE

AjustePuntoF_Fila = FilaPuntoG
AjustePuntoF_Columna = ColumnaPuntoF



MatrizOriginal = [FilaPuntoD,ColumnaPuntoD;
FilaPuntoE,ColumnaPuntoE;FilaPuntoF,ColumnaPuntoF;FilaPuntoG,ColumnaPuntoG]


MatrizReferencias = [FilaPuntoD,ColumnaPuntoD;
AjustePuntoE_Fila,AjustePuntoE_Columna;
AjustePuntoF_Fila,AjustePuntoF_Columna;
FilaPuntoG,ColumnaPuntoG]


MHomografia = GenerarHomografia(MatrizOriginal, MatrizReferencias)

MHomografia = inv(MHomografia);

Punto1 = MHomografia * [1, 1, 1]';
Punto1 = Punto1 / Punto1(3);
Punto2 = MHomografia * [1, columnas, 1]';
Punto2 = Punto2 / Punto2(3);
Punto3 = MHomografia * [filas, 1, 1]';
Punto3 = Punto3 / Punto3(3);
Punto4 = MHomografia * [filas, columnas, 1]';
Punto4 = Punto4 / Punto4(3);

minCoord = [min(Punto1(1),Punto2(1)) min(Punto1(2), Punto3(2))];
maxCoord = [max(Punto4(1),Punto3(1)) max(Punto4(2), Punto2(2))];

relCoords = (maxCoord - minCoord) ./ [filas columnas] ;

for i = [1:filas]
  for j = [1:columnas]

    result = MHomografia * [i, j, 1]';
    result = result / result(3);
    
    %result = ((result - [minCoord 1]') .* [relCoords 1]') + [1, 1, 0];
    %resultImage(floor(result(1)), floor(result(2))) = img(i, j);
%    xImg = max(min(floor(result(1)), filas), 1);
%    yImg = max(min(floor(result(2)), columnas), 1);
    
    %resultImage(i,j) = img(xImg, yImg);
    
    if !(round(result(1)) < 1 || round(result(1)) > filas) && ...
      !(round(result(2)) < 1 || round(result(2)) > columnas)
      resultImage(i,j) = img(round(result(1)), round(result(2)));
      %resultImage(round(result(1)), round(result(2))) = img(i, j);
    else
      result;
    endif
  end
end

imshow(uint8(resultImage));


