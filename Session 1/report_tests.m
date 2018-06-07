clear
clc
close all

x=0:0.05:3*pi; y=sin(x.^2);
y = y + rand(size(y));
%p=con2seq(x); t=con2seq(y);
p = x; 
t = y;

noNeurons = 50;
noEpochs = 10000;
algorithms = {'traingd', 'traingda', 'traincgf', 'traincgp', 'trainbfg', 'trainlm'};
algo = 'traincgf';


%Creation

netcgf=feedforwardnet(noNeurons,'traincgf'); 
netcgf.trainParam.epochs=noEpochs;
[netcgf, tr]=train(netcgf,p,t);
acgf=sim(netcgf,p);

netgd=feedforwardnet(noNeurons,'traingd'); 
netgd.trainParam.epochs=noEpochs;
[netgd, tr]=train(netgd,p,t);
agd=sim(netgd,p);

netgda=feedforwardnet(noNeurons,'traingda'); 
netgda.trainParam.epochs=noEpochs;
[netgda, tr]=train(netgda,p,t);
agda=sim(netgda,p);

netcgp=feedforwardnet(noNeurons,'traincgp'); 
netcgp.trainParam.epochs=noEpochs;
[netcgp, tr]=train(netcgp,p,t);
acgp=sim(netcgp,p);

netbfg=feedforwardnet(noNeurons,'trainbfg'); 
netbfg.trainParam.epochs=noEpochs;
[netbfg, tr]=train(netbfg,p,t);
abfg=sim(netbfg,p);

netlm=feedforwardnet(noNeurons,'trainlm'); 
netlm.trainParam.epochs=noEpochs;
[netlm, tr]=train(netlm,p,t);
alm=sim(netlm,p);

netbr=feedforwardnet(noNeurons,'trainbr'); 
netbr.trainParam.epochs=noEpochs;
[netbr, tr]=train(netbr,p,t);
abr=sim(netbr,p);

figure
subplot(2,1,1);
plot(x,y,'bx',x,acgf,x, abfg, x, acgf, x, acgp); % plot the sine function and the output of the networks
title(strcat('Number of Epochs:',num2str(noEpochs)));
legend('target','CGF', 'BFG', 'CGP','Location','north');
subplot(2,1,2);
plot(x,y,'bx', x, alm, x, agd, x, agda, x, abr );
title(strcat('Number of Epochs:',num2str(noEpochs)));
legend('target','LM', 'GD', 'GDA','BR', 'Location','north');

testError = [];
errorArray = [];
timeArray = [];
algorithms = {'traingd', 'traingda', 'traincgf', 'traincgp', 'trainbfg', 'trainlm', 'trainbr'};

for a = algorithms
    tic;
    for i = 1:20
        netcgp=feedforwardnet(50,a{1}); 
        netcgp.trainParam.epochs=100;
        [netcgp, tr]=train(netcgp,p,t);
        acgp=sim(netcgp,p);
        testError = [testError, tr.best_tperf];
    end
    errorArray = [errorArray, median(testError)];
    time = toc;
    timeArray = [timeArray, time];
    disp(a)
    disp(['Error: ', num2str(median(testError))]);
    toc;
    testError = [];
end

figure
subplot(2,1,1);
bar(categorical(algorithms),errorArray);
title('Median Test Error');
subplot(2,1,2);
bar(categorical(algorithms),timeArray);
title('Elapsed Time');




