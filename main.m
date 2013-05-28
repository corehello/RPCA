
clear all
clc

filename = 'CroppedYale/yaleB02/yaleB02_P00A-035E+65.pgm';
M = readpgm(filename);
[m,n]=size(M);
miu = 1/sqrt(max(m,n));
% [L,S] = ALM(M);
 [L,S] = AGP(M,miu);
[r,c] = find(L>255);
for i=1:length(r)
    L(r(i),c(i)) = 255;
end
[r,c] = find(L<0);
for i=1:length(r)
    L(r(i),c(i)) = 0;
end
% if max(max(L-255))>0

[r,c] = find(S<0);
for i=1:length(r)
    S(r(i),c(i)) = 0;
end
for i=1:3
    LL(:,:,i) = L;
end
for i=1:3
    SS(:,:,i) = S;
end
for i=1:3
    MM(:,:,i) = M;
end




image(MM/255)
pause
clear gcf
image(LL/255)
pause
clear gcf
image(SS/255)
% sleep(10);
% writepgm(S,filename);

