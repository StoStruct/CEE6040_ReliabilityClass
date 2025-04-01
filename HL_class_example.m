%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CEE 6040: Reliability Analysis
% Dr. Mohsen Zaker Esteghamati
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This is a simple implementation of HL algorithm for class example
clear
clc

M=[10;20];

D=[2 0
   0 5];

R=[1 0.5
   0.5 1];

L=chol(R)';
eps=0.001;

%initial guess
X(:,1)=M;
U(:,1)=inv(L)*inv(D)*(X(:,1)-M);

%set conditions as true to move forward with iterations
cond1=1;
cond2=1;
k=1;

% Set an initial value for beta to make convergence test 1 be executed on
% iteration 1. There are more sophisticaed ways to do this than this [ Can
% you think of any other way?] 
beta(1) = -3;

% Here we go! 
while cond1 && cond2

    %calculating g(x)
    grad_g(:,k) = [2*X(1,k); -3];

    grad_h(:,k) = (D*L)'*grad_g(:,k);

    norm_grad_h(k) = norm(grad_h(:,k));

    %calculating alpha and beta

    alpha(:,k) = -grad_h(:,k)./norm_grad_h(k);

    beta(k+1) = alpha(:,k)'*U(:,k);

    h_u(k) = X(1,k)^2-3*X(2,k);

    %calculating conditions for beta and h(u)

    cond1=abs(beta(k+1)-beta(k))>eps;

    cond2=abs(h_u(k))>eps;  

    %calculating u and x for the next iterations

    U(:,k+1)=alpha(:,k)*(beta(k+1)+h_u(k)/norm_grad_h(k));

    X(:,k+1)=D*L*U(:,k+1)+M;

    k=k+1;
   
end

%% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using the same example and improved the code with chatGPT
%can you find the improvements? 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% HL Iterations with symbolic gradient calculation

clear;
clc;
syms x1 x2  % Define symbolic variables

% Define the limit-state function g(X)
g_x = x1^2 - 3*x2; 

% Compute the gradient of g symbolically
grad_g_sym = gradient(g_x, [x1, x2]);  

% Convert symbolic gradient to a numerical function handle
grad_g_func = matlabFunction(grad_g_sym, 'Vars', {[x1; x2]});

% Define mean and dispersion parameters
M = [10; 20];
D = [2 0; 0 5];

% Define correlation matrix and its Cholesky decomposition
R = [1 0.5; 0.5 1];
L = chol(R, 'lower');

% Convergence tolerance
eps = 1e-3;

% Initial guess for X and U
X(:,1) = M;
U(:,1) = (L' \ D) \ (X(:,1) - M);  

% Iteration counter
k = 1;

% Start iterative process
while true
    % Compute gradient of g(X) using symbolic function
    grad_g = grad_g_func(X(:,k));

    % Compute transformed gradient
    grad_h = (D * L)' * grad_g;
    norm_grad_h = norm(grad_h);

    % Compute search direction
    alpha = -grad_h / norm_grad_h;

    % Compute reliability index beta
    beta_k = alpha' * U(:,k);  

    % Evaluate limit-state function h(U)
    h_u = X(1,k)^2 - 3 * X(2,k);

    % Check convergence criteria
    if k > 1 && abs(beta_k - beta_prev) < eps && abs(h_u) < eps
        break;  % Exit loop if both conditions are met
    end

    % Update values for next iteration
    U(:,k+1) = alpha * (beta_k + h_u / norm_grad_h);
    X(:,k+1) = D * L * U(:,k+1) + M;
    
    % Store previous beta value for comparison
    beta_prev = beta_k;

    % Increment iteration counter
    k = k + 1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%