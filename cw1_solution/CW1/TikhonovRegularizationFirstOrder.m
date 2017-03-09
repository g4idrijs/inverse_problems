function falpha = TikhonovRegularizationFirstOrder(Aker,g,alpha)
% TIKHONOVREGULARIZATIONL2 computes the solution of 
% || A f - g ||_2^2 + alpha || D f ||_2^2
% where D is the gradient operator
%
%  falpha = TikhonovRegularizationFirstOrder(Aker,g,alpha)
%
%  INPUT:
%   Aker - blurring kernel
%   g - an image to deblurr
%   alpha - the regularization parameter
%
%  OUTPUTS:
%   falpha - the solution
%
% Author: Felix Lucka

[Nx, Ny] = size(g);


% prepare handle for solving the augmented equation with PCG
ATAalphaId = @(f) ATAgrad(f,alpha,Aker,[Nx,Ny]);
rightHandSide = reshape(imfilter(g,Aker,'circular'),[],1);

% predefine tolerance and maximal number of iterations
tol = 10^-8;
maxIter =  max(Nx,Ny);

[falpha,flag] = pcg(ATAalphaId,rightHandSide,tol,maxIter);

falpha = reshape(falpha,Nx,Ny);
end