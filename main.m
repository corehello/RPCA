clear all
clc

filename = 'CroppedYale/yaleB01/yaleB01_P00A+000E+90.pgm';
M = readpgm(filename);

% [L,S] = ALM(M);
[L,S] = AGP(M,2);

writepgm(L,filename);
% sleep(10);
% writepgm(S,filename);

