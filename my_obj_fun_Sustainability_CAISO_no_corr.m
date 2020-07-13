function z = my_obj_fun_Sustainability_CAISO_no_corr(x)   %x is an nx1 vector of weights
%rho is the PJM correlation matrix derived from first stages of model
%in this function it is the identity matrix (no correlation between
%technologies)
% x will be a row vector of size specified in main function call 


Rho = eye(18);

%sigma is the CAISO Sustainability risk vector derived from first stages
Sigma = [0.739; 0.679; 0.449; 0.842; 0.490; 0.544; 0.465; 0.440; 0.440;...
 0.655; 0.842; 0.842; 0.842; 0.816; 0.723; 0.637; 0.218; 0.312]; 

%cost is the CAISO current sustainability score derived from first modeling stages
%nx1 vector
cost = [0.962; 0.860; 0.709; 0.899; 0.696; 0.726; 0.581; ...
0.363; 0.317; 0.694; 0.657; 0.652; 0.627; 0.645; 0.756; 0.696; 0.356; 0.342; ...
];


z = zeros(2,1); % output of objective function is a vector with two entries
A = (transpose(x)* x).*Rho.*(Sigma*transpose(Sigma));
A1 = sum(sum(A));
%A1 = round(A1,9);
z(1) = -sqrt(A1);
z(2) = -x * cost;