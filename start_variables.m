THETA = [-0.7299, 0.393; 2.6720, 0.6102; 4.1429, 2.2085];
P = [1,1;1,2];
L = [1,2,1]';
lambdas = [1,1;1,1];
tol = 0.1;
max_iter = 1000;
Augmentet_Lagrangian(THETA,L,P,tol,max_iter)