function z = my_obj_fun_Sustainability_PJM_no_corr(x)   %x is an nx1 vector of weights
%rho is the PJM correlation matrix derived from first stages of model
%in this function it is the identity matrix (no correlation between
%technologies)
% x will be a row vector of size specified in main function call 


Rho = eye(18);

%sigma is the PJM Sustainability risk vector derived from first stages
Sigma = [0.740; 0.680; 0.419; 0.787; 0.316; 0.369; 0.473; 0.267; 0.267; ...
    0.625; 0.787; 0.787; 0.787; 0.759; 0.700; 0.614; 0.045; 0.139]; 

%cost is the PJM current sustainability score derived from first modeling stages
%nx1 vector
cost = [0.903; 0.757; 0.662; 0.816; 0.713; 0.710; 0.512; 0.277;...
0.247; 0.675; 0.656; 0.635; 0.632; 0.550; 0.700; 0.661;...
0.308; 0.278;...
];


z = zeros(2,1); % output of objective function is a vector with two entries
A = (transpose(x)* x).*Rho.*(Sigma*transpose(Sigma));
A1 = sum(sum(A));
%A1 = round(A1,9);
z(1) = -sqrt(A1);
z(2) = -x * cost;