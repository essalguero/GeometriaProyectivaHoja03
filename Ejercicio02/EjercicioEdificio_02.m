%V = [15.38 87.22]
%H = [1 0; 1 -87.22]
%
%t1 = [7.34 4.51]
%t1_ = [1.06 4.26]
%t2 = [1.96 9.49]
%
%d1 = 1.1851
%
%valor = d1 * ((t2(2) * (t1_(2) - V(2))))
%
%d2 = valor / (t1_(2) * (t2(2) - V(2)))

clear all
clc

V = [15.77 99.97]
H = [1 0; 1 -V(1)]
t1 = [7.32 4.55]
t2 = [7.33 12.62]

b1 = [7.21, 3.3]
b2 = [6.43 3.37]

d1 = 1.75

t1_ = [6.55 4.6]



valor = d1 * (((t2(2) - b2(2)) * ((t1_(2) - b1(2)) - V(2))))
d2 = valor / (((t1_(2) - b1(2)) * ((t2(2) - b2(2)) - V(2))))

