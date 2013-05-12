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
k=0;

while not converged do 
	YL = L(:,:,mod(k,3)+2)+((t(mod(k,3)+1)-1)/t(mod(k,3)+2))*(L(:,:,mod(k,3)+2)-L(:,:,mod(k,3)+1));
	YS = S(:,:,mod(k,3)+2)+((t(mod(k,3)+1)-1)/t(mod(k,3)+2))*(S(:,:,mod(k,3)+2)-S(:,:,mod(k,3)+1));
	GL = YL - (1/2)*(YL+YS-M);
	(U,X,V) = svd(GL);
	L(:,:,mod(k,3)+3) = U*stao(X,miu*k/2)*V';
	GS = YS - (1/2)*(YL+YS-M);
	S(:,:,mod(k,3)+3) = stao(GS,lamda*miu/2);
	t(mod(k,3)+3) = (1+sqrt(4*t(mod(k,3)+2)^2+1))/2;
	miu  = max(yita*miu,miu);
	k = k+1;
end
