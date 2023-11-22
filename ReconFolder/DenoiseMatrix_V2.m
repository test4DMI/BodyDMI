function OutMatrix=DenoiseMatrix_V2(InpMatrix)
%% Debug
% InpMatrix=noisepatch;
% InpMatrix=signalpatch;
%
n=size(InpMatrix,1);
m=size(InpMatrix,2);
r=min(m,n);
[U,S,V] = svd(InpMatrix,'econ');
% [U,S,V] = svdecon(InpMatrix); % This function works way faster then build in matlab svd. But in some cases generated eigenvalues are slightly different from matlab svd results. This may cause computed treshold to be one or two step off.
eigv = flip((diag(S)).^2);
lam_r = eigv(1) / n;
clam = 0;
sigma2 = NaN;
tolerance=1;
for p=1:r % Grid search
    lam = eigv(p) / n;
    clam = clam+lam;
    gam = (m-p)/n;
    sigsq1 = (clam/(p));
    sigsq2 = (lam-lam_r)/(4*sqrt(gam));
    if(sigsq2 < sigsq1)
        sigma2 = sqrt(sigsq1+sigsq2)/2;% In case if you want to generate a noise map
        cutoff_p = p-tolerance;
    end
end
cutoff_p = r-cutoff_p;
eigv = flip(eigv);
if(cutoff_p > 1)
    Snew = zeros(size(S));
    Sd = diag(sqrt(eigv(1:cutoff_p)));
    Snew(1:cutoff_p,1:cutoff_p) = Sd;
    rebuilt_data = reshape(U*Snew*V',size(InpMatrix));%+mean_data;  
else % Modified to avoid patches without denoising
    cutoff_p=1;
    Snew = zeros(size(S));
    Sd = diag(sqrt(eigv(1:cutoff_p)));
    Snew(1:cutoff_p,1:cutoff_p) = Sd;
    rebuilt_data = reshape(U*Snew*V',size(InpMatrix));%+mean_data;
end

OutMatrix=rebuilt_data;

function [U,S,V] = svdecon(X) % Faster SVD
[m,n] = size(X);
if  m <= n
    C = X*X';
    [U,D] = eig(C);
    clear C;
    
    [d,ix] = sort(abs(diag(D)),'descend');
    U = U(:,ix);    
    
    if nargout > 2
        V = X'*U;
        s = sqrt(d);
        V = bsxfun(@(x,c)x./c, V, s');
        S = diag(s);
    end
else
    C = X'*X; 
    [V,D] = eig(C);
    clear C;
    
    [d,ix] = sort(abs(diag(D)),'descend');
    V = V(:,ix);    
    
    U = X*V; % convert evecs from X'*X to X*X'. the evals are the same.
    %s = sqrt(sum(U.^2,1))';
    s = sqrt(d);
    U = bsxfun(@(x,c)x./c, U, s');
    S = diag(s);
end