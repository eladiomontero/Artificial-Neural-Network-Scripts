%% Two Neuron Net

T = [+1 -1; ...
      -1 +1];
  
plot(T(1,:),T(2,:),'r*')
axis([-1.1 1.1 -1.1 1.1])
title('Hopfield Network State Space')
xlabel('a(1)');
ylabel('a(2)');

net = newhop(T);
[Y,Pf,Af] = net([],[],T);

a = {rands(2,1)};
[y,Pf,Af] = net({20},{},a);
record = [cell2mat(a) cell2mat(y)];
start = cell2mat(a);
hold on
plot(start(1,1),start(2,1),'bx',record(1,:),record(2,:))

color = 'rgbmy';
for i=1:25
   a = {rands(2,1)};
   [y,Pf,Af] = net({20},{},a);
   record=[cell2mat(a) cell2mat(y)];
   start=cell2mat(a);
   plot(start(1,1),start(2,1),'kx',record(1,:),record(2,:),color(rem(i,5)+1))
end

%% Unstable Equilibria
T = [+1 -1; ...
      -1 +1];
plot(T(1,:),T(2,:),'r*')
axis([-1.1 1.1 -1.1 1.1])
title('Hopfield Network State Space')
xlabel('a(1)');
ylabel('a(2)');

net = newhop(T);
a = {rands(2,1)};
[y,Pf,Af] = net({1 50},{},a);

record = [cell2mat(a) cell2mat(y)];
start = cell2mat(a);
hold on
plot(start(1,1),start(2,1),'bx',record(1,:),record(2,:))

% Initialize five other undesired stable points 
plot(0,0,'ko');
P = [-1.0 -0.5 0.0 +0.5 +1.0;  
     -1.0 -0.5 0.0 +0.5 +1.0];
 
for i=1:5
   a = {P(:,i)};
   [y,Pf,Af] = net({1 50},{},a);
   record=[cell2mat(a) cell2mat(y)];
   start = cell2mat(a);
   plot(start(1,1),start(2,1),'kx',record(1,:),record(2,:),color(rem(i,5)+1))
   drawnow
end

%% Exercise 1 Create a Hopfield net

T = [1 1; -1 -1; 1 -1]'
plot(T(1,:),T(2,:),'r*')
plot(T(1,:),T(2,:),'r*')
axis([-1.1 1.1 -1.1 1.1])
title('Hopfield Network State Space')
xlabel('a(1)');
ylabel('a(2)');
zlabel('a(3)');

net = newhop(T);
[Y,Pf,Af] = net([],[],T);

a = {rands(2,1)};
[y,Pf,Af] = net({100},{},a);
record = [cell2mat(a) cell2mat(y)];
start = cell2mat(a);
hold on
plot(start(1,1),start(2,1),'bx',record(1,:),record(2,:))










