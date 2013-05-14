function [L,S] = AGP(M,lamda)
%-------------------------------------------------------------------------------%
%	l	:	low-rank matrix, principle component			%
%	S	:	spare matrix, noise or special feature			%
%	M	:	origin matrix, can decompose to L + S 			%		
%	Author	:	corehello						%
%	Email	:	corehello@gmail.com					%
%-------------------------------------------------------------------------------%
%	paer	:	Rubost principal component analysis? 2009 stanford tech 
%			reporit

%	data init
[m,n] = size(M);
L = zeros(m,n,3);
S = zeros(m,n,3);
t = ones(1,3);
miu = 0.1;
yita = 0.5;


for k = 0:500
	YL = L(:,:,mod(k+1,3)+1)+((t(mod(k,3)+1)-1)/t(mod(k+1,3)+1))*(L(:,:,mod(k+1,3)+1)-L(:,:,mod(k,3)+1));
	YS = S(:,:,mod(k+1,3)+1)+((t(mod(k,3)+1)-1)/t(mod(k+1,3)+1))*(S(:,:,mod(k+1,3)+1)-S(:,:,mod(k,3)+1));
	GL = YL - (1/2)*(YL+YS-M);
	[U,X,V] = svd(GL);
	L(:,:,mod(k+2,3)+1) = U*stao(X,miu*k/2)*V';
	GS = YS - (1/2)*(YL+YS-M);
	S(:,:,mod(k+2,3)+1) = stao(GS,lamda*miu/2);
	t(mod(k+2,3)+1) = (1+sqrt(4*t(mod(k+1,2)+1)^2+1))/2;
	miu  = max(yita*miu,miu);
end

L = L(:,:,mod(k,3)+1);
S = S(:,:,mod(k,3)+1);


function MA = stao(X,tao)

[m,n] = size(X);
MA = zeros(m,n);

for i=1:m
	for j=1:n
		MA(i,j)=sgn(X(i,j))*max(abs(X(i,j))-tao, 0);
	end
end

function s = sgn(x)
if (x-0)>=0
    s=1;
else
    s=-1;
end