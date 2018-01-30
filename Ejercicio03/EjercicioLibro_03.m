clear all;
close all;

imgCenter = imread('./2.JPG');
imgLeft = imread('./1.JPG');
imgRight = imread('./3.JPG');

% Points for center (a) and left (b) and right (c)
x1a = 375;
y1a = 111;
x1b = 619;
y1b = 141;
x1c = 49;
y1c = 53;

x2a = 513;
y2a = 137;
x2b = 761;
y2b = 151;
x2c = 213;
y2c = 103;

x3a = 513;
y3a = 305;
x3b = 757;
y3b = 323;
x3c = 215;
y3c = 281;

x4a = 371;
y4a = 291;
x4b = 617;
y4b = 315;
x4c = 51;
y4c = 249;

[filas, columnas, k] = size(imgCenter);

% center
m1 = [x1a y1a;
      x2a y2a;
      x3a y3a;
      x4a y4a;];
      
% left
m2 = [x1b y1b;
      x2b y2b;
      x3b y3b;
      x4b y4b;];

% right   
m3 = [x1c y1c;
      x2c y2c;
      x3c y3c;
      x4c y4c;];
      
resultImage = zeros(filas*3, columnas*3, 3);

% center
for i = [1:filas]
    for j  = [1: columnas]
      for k  = [1: 3]
        resultImage(filas+i, columnas+j, k) = imgCenter(i, j, k);
      end
    end
end

% left
MH = GenerarHomografia(m2, m1);
MH = inv(MH);

Punto1 = MH * [1, 1, 1]';
Punto1 = Punto1 / Punto1(3)
Punto2 = MH * [1, columnas, 1]';
Punto2 = Punto2 / Punto2(3)
Punto3 = MH * [filas, 1, 1]';
Punto3 = Punto3 / Punto3(3)
Punto4 = MH * [filas, columnas, 1]';
Punto4 = Punto4 / Punto4(3)

minCoord = [max(Punto1(1),Punto2(1)) max(Punto1(2), Punto3(2))] - [1 1];
maxCoord = [min(Punto4(1),Punto3(1)) min(Punto4(2), Punto2(2))] + [1 1];

relCoords = [filas columnas] ./ (maxCoord - minCoord)   ;

for i = [1:filas]
    for j  = [1: columnas]
      r = MH * [i, j, 1]';
      r = r/r(3);
      r = ((r  - [minCoord 1]').* [relCoords 1]');
      for k  = [1: 3]
        if !(round(r(1)) < 1 || round(r(1)) > filas) && ...
          !(round(r(2)) < 1 || round(r(2)) > columnas)
          resultImage(filas + i - 100, columnas + j - 300, k) = imgLeft(round(r(1)), round(r(2)), k);
        else
          r;
        endif
      end
    end
end

MH = GenerarHomografia(m1, m3);
%MH = inv(MH);

Punto1 = MH * [1, 1, 1]';
Punto1 = Punto1 / Punto1(3)
Punto2 = MH * [1, columnas, 1]';
Punto2 = Punto2 / Punto2(3)
Punto3 = MH * [filas, 1, 1]';
Punto3 = Punto3 / Punto3(3)
Punto4 = MH * [filas, columnas, 1]';
Punto4 = Punto4 / Punto4(3)

minCoord = [max(Punto1(1),Punto2(1)) max(Punto1(2), Punto3(2))] - [1 1];
maxCoord = [min(Punto4(1),Punto3(1)) min(Punto4(2), Punto2(2))] + [1 1];

relCoords = [filas columnas] ./ (maxCoord - minCoord)   ;

for i = [1:filas]
    for j  = [1: columnas]
      r = MH * [i, j, 1]';
      r = r/r(3);
      r = ((r  - [minCoord 1]').* [relCoords 1]');
      for k  = [1: 3]
        if !(round(r(1)) < 1 || round(r(1)) > filas) && ...
          !(round(r(2)) < 1 || round(r(2)) > columnas)
          resultImage(filas + i, columnas + j + 200, k) = imgRight(round(r(1)), round(r(2)), k);
        else
          r;
        endif
      end
    end
end

imwrite(uint8(resultImage), "out.jpg");
