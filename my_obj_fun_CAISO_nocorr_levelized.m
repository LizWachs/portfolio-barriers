function z = my_obj_fun_CAISO_nocorr_levelized(x)   %x is an nx1 vector of weights
%rho is the CAISO correlation matrix derived from first stages of model
%in this function it is the correlation matrix derived by V * C * V^T
% x will be a row vector of size specified in main function call 
Rho = eye(18);

%sigma is the CAISO risk vector derived from first stages (from
%Tech_Risk_PJM_CAISO.xlsx
Sigma = [0.065198843; 0.057412585;0.071802991;0.057859418;0.138441046;...
    0.12201202;0.07579699;0.085478896;0.08409905;0.031337238;0.080286856;...
    0.10017006;0.098763559;0.050301672;0.06999326;0.07083148;0.049281566;...
    0.045612461];

%cost is the CAISO levelized cost per MWh derived from 2019 ATB
cost = [36.71; 97.7; 66.99; 23.62; 37.69; 60.1; 145.74; 93.17; 107.7;... 
111.9; 113.95; 108.24; 189.68; 56.34; 76.3; 111.25; 77.66; 89.33];


z = zeros(2,1); % output of objective function is a vector with two entries
A = (transpose(x)* x).*Rho.*(Sigma*transpose(Sigma));
A1 = sum(A, 'all');
z(1) = sqrt(A1);
z(2) = x * cost;