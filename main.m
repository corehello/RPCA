clear all
clc

filename = "CroppedYale/yaleB01/yaleB01_P00A+000E+00.pgm"
M = readpgm(filename);

[L,S] = ALM(M);

writepgm(L,filename);
writepgm(S,filename);

