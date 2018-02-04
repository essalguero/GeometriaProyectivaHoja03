clear all;
close all;
clc;

AnchoImagen = 10;
AltoImagen = 7.56;
imgDch = imread('./IMG_4908.JPG');
imgIzq = imread('./IMG_4906.JPG');
imgCent = imread('./IMG_4907.JPG');
[filas columnas color] = size(imgIzq);

relacionEjeX = columnas / AnchoImagen;
relacionEjeY = filas / AltoImagen;

resultImage = zeros(filas, columnas*3, color);

% Dibujar imagen central
resultImage(:, columnas : columnas*2-1, :) = imgCent(:,:,:);

% Lado Izquierdo
% Puntos foto izquierda
PuntoD_X = 8.276038406570354;
PuntoD_Y = 1.357851066730977;

PuntoE_X = 8.94200878349143;
PuntoE_Y = 2.136524122823312;

PuntoF_X = 8.24530131225092;
PuntoF_Y = 6.931510836655059;

PuntoG_X = 6.298618672020083;
PuntoG_Y = 7.310601666594749;

ColumnaPuntoD = relacionEjeX * PuntoD_X;
FilaPuntoD = filas - (relacionEjeY  * PuntoD_Y);

ColumnaPuntoE = relacionEjeX * PuntoE_X;
FilaPuntoE = filas - (relacionEjeY  * PuntoE_Y);

ColumnaPuntoF = relacionEjeX * PuntoF_X;
FilaPuntoF = filas - (relacionEjeY  * PuntoF_Y);

ColumnaPuntoG = relacionEjeX * PuntoG_X;
FilaPuntoG = filas - (relacionEjeY  * PuntoG_Y);

MatrizOriginal = [FilaPuntoD, ColumnaPuntoD;
                  FilaPuntoE, ColumnaPuntoE;
                  FilaPuntoF, ColumnaPuntoF;
                  FilaPuntoG, ColumnaPuntoG];
                  
% Puntos foto central
PuntoD_X_2 = 3.3796289056830053;
PuntoD_Y_2 = 1.306151157064555;

PuntoE_X_2 = 3.9705435871729042;
PuntoE_Y_2 = 2.106745241663773;

PuntoF_X_2 = 3.274789204128346;
PuntoF_Y_2 = 6.54813623479753;

PuntoG_X_2 = 1.3114275204683599;
PuntoG_Y_2 = 7.272483263720632;

ColumnaPuntoD_2 = relacionEjeX * PuntoD_X_2;
FilaPuntoD_2 = filas - (relacionEjeY  * PuntoD_Y_2);

ColumnaPuntoE_2 = relacionEjeX * PuntoE_X_2;
FilaPuntoE_2 = filas - (relacionEjeY  * PuntoE_Y_2);

ColumnaPuntoF_2 = relacionEjeX * PuntoF_X_2;
FilaPuntoF_2 = filas - (relacionEjeY  * PuntoF_Y_2);

ColumnaPuntoG_2 = relacionEjeX * PuntoG_X_2;
FilaPuntoG_2 = filas - (relacionEjeY  * PuntoG_Y_2);

MatrizReferencias = [FilaPuntoD_2, ColumnaPuntoD_2;
                     FilaPuntoE_2, ColumnaPuntoE_2;
                     FilaPuntoF_2, ColumnaPuntoF_2;
                     FilaPuntoG_2, ColumnaPuntoG_2];

MHomografia = GenerarHomografia(MatrizOriginal, MatrizReferencias);
MHomografia = inv(MHomografia);

for i = [1:filas]
  for j = [1:columnas*3]
    result = MHomografia * [i, j, 1]';
    result = result / result(3);
    
    if !(round(result(1)) < 1 || round(result(1)) > filas) && ...
      !(round(result(2)) < 1 || round(result(2)) > columnas)
      for k = [1:color]
        resultImage(i, j + columnas, k) = imgIzq(round(result(1)), round(result(2)), k);
      end
    endif
    
  end
end

% Lado Derecho
% Puntos foto derecha
PuntoD_X_3 = 0.63;
PuntoD_Y_3 = 7.46;

PuntoE_X_3 = 2.17;
PuntoE_Y_3 = 1.44;

PuntoF_X_3 = 3.82;
PuntoF_Y_3 = 5.32;

PuntoG_X_3 = 5.49;
PuntoG_Y_3 = 1.79;

ColumnaPuntoD_3 = relacionEjeX * PuntoD_X_3;
FilaPuntoD_3 = filas - (relacionEjeY  * PuntoD_Y_3);

ColumnaPuntoE_3 = relacionEjeX * PuntoE_X_3;
FilaPuntoE_3 = filas - (relacionEjeY  * PuntoE_Y_3);

ColumnaPuntoF_3 = relacionEjeX * PuntoF_X_3;
FilaPuntoF_3 = filas - (relacionEjeY  * PuntoF_Y_3);

ColumnaPuntoG_3 = relacionEjeX * PuntoG_X_3;
FilaPuntoG_3 = filas - (relacionEjeY  * PuntoG_Y_3);

MatrizOriginal = [FilaPuntoD_3, ColumnaPuntoD_3;
                  FilaPuntoE_3, ColumnaPuntoE_3;
                  FilaPuntoF_3, ColumnaPuntoF_3;
                  FilaPuntoG_3, ColumnaPuntoG_3];
                  
% Puntos foto central
PuntoD_X_4 = 4.58;
PuntoD_Y_4 = 6.98;

PuntoE_X_4 = 5.94;
PuntoE_Y_4 = 1.43;

PuntoF_X_4 = 7.5;
PuntoF_Y_4 = 5.3;

PuntoG_X_4 = 9.55;
PuntoG_Y_4 = 1.43;

ColumnaPuntoD_4 = relacionEjeX * PuntoD_X_4;
FilaPuntoD_4 = filas - (relacionEjeY  * PuntoD_Y_4);

ColumnaPuntoE_4 = relacionEjeX * PuntoE_X_4;
FilaPuntoE_4 = filas - (relacionEjeY  * PuntoE_Y_4);

ColumnaPuntoF_4 = relacionEjeX * PuntoF_X_4;
FilaPuntoF_4 = filas - (relacionEjeY  * PuntoF_Y_4);

ColumnaPuntoG_4 = relacionEjeX * PuntoG_X_4;
FilaPuntoG_4 = filas - (relacionEjeY  * PuntoG_Y_4);

MatrizReferencias = [FilaPuntoD_4, ColumnaPuntoD_4;
                     FilaPuntoE_4, ColumnaPuntoE_4;
                     FilaPuntoF_4, ColumnaPuntoF_4;
                     FilaPuntoG_4, ColumnaPuntoG_4];

MHomografia = GenerarHomografia(MatrizOriginal, MatrizReferencias);
MHomografia = inv(MHomografia);

for i = [1:filas]
  for j = [1:columnas*3]

    result = MHomografia * [i, j, 1]';
    result = result / result(3);

    if !(round(result(1)) < 1 || round(result(1)) > filas) && ...
      !(round(result(2)) < 1 || round(result(2)) > columnas)
      for k = [1:color]
        resultImage(i, j + columnas, k) = imgDch(round(result(1)), round(result(2)), k);
      end
    endif
  end
end

figure;
imshow(uint8(resultImage));
imwrite(uint8(resultImage), "out.jpg");