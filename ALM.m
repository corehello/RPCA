function [L,S] = ALM(M)
%-------------------------------------------------------------------------------%
%	l	:	low-rank matrix, principle component			%
%	S	:	spare matrix, noise or special feature			%
%	M	:	origin matrix, can decompose to L + S 			%		
%	Author	:	corehello						%
%	Email	:	corehello@gmail.com					%
%-------------------------------------------------------------------------------%
%	paer	:	Rubost principal component analysis? 2009 stanford tech 
%			report
[m,n] = size(M);
Y = zeros(m,n);
L = zeros(m,n);
S = zeros(m,n);

miu = m*n/(4*norm(M,1));
lamda = 1/sqrt(m*n);
k=0;
while norm(M-L-S,2)>10^-7*norm(M,2)
	[U, sigma, V] = svd(M-S-(1/miu)*Y);
	L = U*stao(sigma,miu)*V';
	S = stao(M-L+(1/miu)*Y,lamda*miu);
	Y = Y + miu * ( M - L - S );
    k=k+1
end


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