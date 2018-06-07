clear
clc
close all

%%%%%%%%%%%
%algorlm.m
% A script comparing performance of 'traingd' and 'traingda'
% traingd -  gradient descent 
% traingda - gradient descent with adaptive learning rate
%%%%%%%%%%%

%generation of examples and targets
x=0:0.05:3*pi; y=sin(x.^2);
y = y + rand(size(y));
p=con2seq(x); t=con2seq(y); % convert the data to a useful format


%creation of networks
net1=feedforwardnet(50,'traingd');
net2=feedforwardnet(50,'traingda');
net2.iw{1,1}=net1.iw{1,1};  %set the same weights and biases for the networks 
net2.lw{2,1}=net1.lw{2,1};
net2.b{1}=net1.b{1}; %this is the bias, to initialize
net2.b{2}=net1.b{2};
%feedforward doesnt use regularization
%test with different methods

%training and simulation
%traing with different epochs
net1.trainParam.epochs=1;  % set the number of epochs for the training 
net2.trainParam.epochs=1;
net1=train(net1,p,t);   % train the networks
net2=train(net2,p,t);
a11=sim(net1,p); a21=sim(net2,p);  % simulate the networks with the input vector p

net1.trainParam.epochs=14;
net2.trainParam.epochs=14;
net1=train(net1,p,t);
net2=train(net2,p,t);
a12=sim(net1,p); a22=sim(net2,p);

net1.trainParam.epochs=985;
net2.trainParam.epochs=985;
net1=train(net1,p,t);
net2=train(net2,p,t);
a13=sim(net1,p); a23=sim(net2,p);

%plots
figure
subplot(3,3,1);
plot(x,y,'bx',x,cell2mat(a11),'r',x,cell2mat(a21),'g'); % plot the sine function and the output of the networks
title('1 epoch');
legend('target','traingd','traingda','Location','north');
subplot(3,3,2);
postregm(cell2mat(a11),y); % perform a linear regression analysis and plot the result
subplot(3,3,3);
postregm(cell2mat(a21),y);
%
subplot(3,3,4);
plot(x,y,'bx',x,cell2mat(a12),'r',x,cell2mat(a22),'g');
title('15 epochs');
legend('target','traingd','traingda','Location','north');
subplot(3,3,5);
postregm(cell2mat(a12),y);
subplot(3,3,6);
postregm(cell2mat(a22),y);
%
subplot(3,3,7);
plot(x,y,'bx',x,cell2mat(a13),'r',x,cell2mat(a23),'g');
title('1000 epochs');
legend('target','traingd','traingda','Location','north');
subplot(3,3,8);
postregm(cell2mat(a13),y);
subplot(3,3,9);
postregm(cell2mat(a23),y);
