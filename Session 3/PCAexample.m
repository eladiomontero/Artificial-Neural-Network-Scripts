m = randn(50,500);
% transposed so it is 500 observations with 50 features
covm = cov(m');
[v,d] = eig(covm);
%[v,d] = eigs(covm,12);
%Construct the matrix with the new dimensions
z =  v' * m;

%Reconstruct the matrix qnd check how similar they are
mhat = z' * v';

%Calculate the error
rms = sqrt(mean(mean((m - mhat').^2)));

%% Choles
load choles_all

covm = cov(p');

[v,d] = eigs(covm,4);
%Construct the matrix with the new dimensions
z =  v' * p;

%Reconstruct the matrix qnd check how similar they are
phat = z' * v';

%Calculate the error
rms = sqrt(mean(mean((p - phat').^2)));

%% Built in functions
mapstd(p); % Process matrices by mapping each row's means to 0 and deviations to 1
[z, PS] = processpca(mapstd(p),0.001);
phat = processpca('reverse',z,PS);

rms = sqrt(mean(mean((p - phat).^2)));

%% PCA on Handwriten digits
load threes -ascii
i = 67;
colormap('gray');
imagesc(reshape(threes(i,:),16,16),[0,1]); % show the ith picture

imagesc(reshape(mean(threes),16,16),[0,1]); % this is the mean 3

%Compute the cov matrix of the whole dataset of 3
covm = cov(threes);
[v,d] = eig(covm);
plot(diag(d));

% compute the 1,2,3,4 principal component and reconstruct the image
c=256;
[v,d] = eigs(covm,c);
z =  v' * threes';
phat = z' * v';
rms = sqrt(mean(mean((threes - phat).^2)));
imagesc(reshape(phat(i,:),16,16),[0,1]);

% Loop to test the error and the components
errors = [];
for k = 1:50
    covm = cov(threes);
    [v,d] = eigs(covm,k);
    z =  v' * threes';
    phat = z' * v';
    rms = sqrt(mean(mean((threes - phat).^2)));
    errors = [errors, rms];
end

plot(errors);
xlabel('Number of principal components');
ylabel('RMSE');

[v,d] = eig(covm);
for i = 1:50
    cumsum(d, i)
end








