function z = my_obj_fun_CAISO_deLlano_Paz_levelized(x)   %x is an nx1 vector of weights
%rho is the PJM correlation matrix derived from first stages of model
%in this function it is the correlation matrix derived by the determinant
%method
% x will be a row vector of size specified in main function call 

%% define parameters
Number_Techs = 18;
OM_Risk = 0.041;
Rho1 = eye(Number_Techs);

% Sigma_Fuel_Mat is the vector multiplication of the Fuel risk vector with itself
%Fuel Risk is from Tech_Risk.xlsx
Fuel_Risk = [0;0;0.070;0;0.270;0.270;0.270;0.070;0.070;0.070;0;0;0;0;0;0;0.070;0.070];
Sigma_Fuel_Mat = Fuel_Risk * transpose(Fuel_Risk);
%Rho_Fuel is the fuel correlation matrix from Fuel_Correlations.xlsx
%rounded to 6 digits
Rho_Fuel = [1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;...
0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;...
0	0	1	0	-0.207842	-0.207842	-0.207842	0.903944	0.903944	0	0	0	0	0	0	0	0.903944	0.903944;...
0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0;...
0	0	-0.207842	0	1	1	1	-0.428724	-0.428724	0	0	0	0	0	0	0	-0.428724	-0.428724;...
0	0	-0.207842	0	1	1	1	-0.428724	-0.428724	0	0	0	0	0	0	0	-0.428724	-0.428724;...
0	0	-0.207842	0	1	1	1	-0.428724	-0.428724	0	0	0	0	0	0	0	-0.428724	-0.428724;...
0	0	0.903944	0	-0.428724	-0.428724	-0.428724	1	1	0	0	0	0	0	0	0	1	1;...
0	0	0.903944	0	-0.428724	-0.428724	-0.428724	1	1	0	0	0	0	0	0	0	1	1;...
0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0;...
0	0	0	0	0	0	0	0	0	0	1	1	1	0	0	0	0	0;...
0	0	0	0	0	0	0	0	0	0	1	1	1	0	0	0	0	0;...
0	0	0	0	0	0	0	0	0	0	1	1	1	0	0	0	0	0;...
0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0;...
0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0;...
0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0;...
0	0	0.903944	0	-0.428724	-0.428724	-0.428724	1	1	0	0	0	0	0	0	0	1	1;...
0	0	0.903944	0	-0.428724	-0.428724	-0.428724	1	1	0	0	0	0	0	0	0	1	1;...
];

%Rho_OM is the OM correlations from OM_Correlations.xlsx
Rho_OM = [1	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6;...
0.6	1	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6;...
0.6	0.6	1	0.5	0.55	0.55	-0.56	0.55	0.55	0.6	0.6	0.6	0.6	0.64	0.6	0.6	0.55	0.55;...
0.6	0.6	0.6	1	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6;...
0.6	0.6	0.55	0.6	1	0.9	-0.76	0.9	0.9	0.6	0.6	0.6	0.6	0.75	0.6	0.6	1	1;...
0.6	0.6	0.55	0.6	0.9	1	-0.76	1	1	0.6	0.6	0.6	0.6	0.75	0.6	0.6	0.9	0.9;...
0.6	0.6	-0.56	0.6	-0.76	-0.76	1	-0.76	-0.76	0.6	0.6	0.6	0.6	-0.59	0.6	0.6	-0.76	-0.76;...
0.6	0.6	0.55	0.6	0.9	1	-0.76	1	1	0.6	0.6	0.6	0.6	0.75	0.6	0.6	0.9	0.9;...
0.6	0.6	0.55	0.6	0.9	1	-0.76	1	1	0.6	0.6	0.6	0.6	0.75	0.6	0.6	0.9	0.9;...
0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	1	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6;...
0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	1	1	1	0.6	0.6	0.6	0.6	0.6;...
0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	1	1	1	0.6	0.6	0.6	0.6	0.6;...
0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	1	1	1	0.6	0.6	0.6	0.6	0.6;...
0.6	0.6	0.64	0.6	0.75	0.75	-0.59	0.75	0.75	0.6	0.6	0.6	0.6	1	0.6	0.6	0.75	0.75;...
0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	1	1	0.6	0.6;...
0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	1	1	0.6	0.6;...
0.6	0.6	0.55	0.6	1	0.9	-0.76	0.9	0.9	0.6	0.6	0.6	0.6	0.75	0.6	0.6	1	1;...
0.6	0.6	0.55	0.6	1	0.9	-0.76	0.9	0.9	0.6	0.6	0.6	0.6	0.75	0.6	0.6	1	1];

%sigma is the CAISO risk vector derived from first stages (from
%Tech_Risk_PJM_CAISO.xlsx
Sigma = [0.065198843; 0.057412585;0.071802991;0.057859418;0.138441046;...
    0.12201202;0.07579699;0.085478896;0.08409905;0.031337238;0.080286856;...
    0.10017006;0.098763559;0.050301672;0.06999326;0.07083148;0.049281566;...
    0.045612461]; 

%cost is the CAISO total cost per kW derived from first modeling stages
%from CAISO_NPV_06_21_19_with_Rev_Cost_portions_30_years.xlsx
cost = [36.71; 97.7; 66.99; 23.62; 37.69; 60.1; 145.74; 93.17; 107.7;... 
111.9; 113.95; 108.24; 189.68; 56.34; 76.3; 111.25; 77.66; 89.33];

%% initialize the vector
z = zeros(2,1); % output of objective function is a vector with two entries

%% calculate the three arguments in the de Llano-Paz calculation
%%%%first argument: square of the technologies with their risk factors (all
%%%%diagonal entries only)
%%%create the matrix of X because want to subtract diagonal for other
%%%arguments
X = transpose(x) * x;
A1 = X .* Rho1 .* (Sigma*transpose(Sigma));
%%%%%second argument: fuel part for correlation
X2 = X - diag(diag(X));
A2 = X2 .* Rho_Fuel .* Sigma_Fuel_Mat;

%%%%%third argument: OM part for correlation
A3 = X2 .* OM_Risk^2 .* Rho_OM;

%% Sum the three arguments
A = A1 + A2 + A3;
%% Take sum of all elements in the matrix
A = sum(A, 'all');
A = max(A,0);
%% The objectives are the square root of the sum of all elements in the matrix and the total cost
z(1) = sqrt(A);
z(2) = x * cost;