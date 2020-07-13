%Computes barriers and boosts based on market and sustainability scores
%Graphs them on dot plot
%Graphs the Pareto fronts for market and sustainability in both regions
%Calculates percentage of VRE in Solutions


clear

%%%%%%Separate files store the solutions from different solution methods
%%%%%%and scenarios
addpath('sust_model/Results','Costs_Solutions')
Sheet_name = "All_filtered";

%%%%%%%Import solutions based on market and sustainability criteria

%Note: need to double check range on each file before importing%
Mkt_CA_NoVRE = readmatrix('solutions_levelized_costs_CAISO_4_14_20.xlsx','Sheet', Sheet_name,'Range','A2:T915');
Mkt_CA_70VRE = readmatrix('solns_CAISO_levelized_scaled-matr_70VRE.xlsx','Sheet', Sheet_name, 'Range', 'A2:T900');
Mkt_CA_50VRE = readmatrix('solns_CAISO_levelized_scaled-matr_50VRE.xlsx','Sheet', Sheet_name, 'Range', 'A2:T901');
Mkt_CA_30VRE = readmatrix('solns_CAISO_levelized_scaled-matr_30VRE.xlsx','Sheet', Sheet_name, 'Range', 'A2:T888');
Mkt_PJM_NoVRE = readmatrix('solutions_levelized_costs_PJM_4_10_20.xlsx','Sheet', Sheet_name,'Range','A2:T380');
Mkt_PJM_70VRE = readmatrix('solns_PJM_levelized_scaled-matr_70VRE.xlsx','Sheet', Sheet_name, 'Range', 'A2:T689');
Mkt_PJM_50VRE = readmatrix('solns_PJM_levelized_scaled-matr_50VRE.xlsx','Sheet', Sheet_name, 'Range', 'A2:T688');
Mkt_PJM_30VRE = readmatrix('solns_PJM_levelized_scaled-matr_30VRE.xlsx','Sheet', Sheet_name, 'Range', 'A2:T678');

Sust_CA_NoVRE = readmatrix('Results_CAISO_noVREConstraint.xlsx','Sheet', Sheet_name,'Range','b1:u1425');
Sust_CA_70VRE = readmatrix('Results_70VRE_Best.xlsx','Sheet', 'CAISO', 'Range', 'b2:u225');
Sust_CA_50VRE = readmatrix('Results_50VRE_Best.xlsx','Sheet', 'CAISO', 'Range', 'b2:u225');
Sust_CA_30VRE = readmatrix('Results_30VRE_Best.xlsx','Sheet', 'CAISO', 'Range', 'b2:u225');
Sust_PJM_NoVRE = readmatrix('Results_PJM_noVREConstraint.xlsx','Sheet', Sheet_name,'Range','A1:T167');
Sust_PJM_70VRE = readmatrix('Results_70VRE_Best.xlsx','Sheet', 'PJM', 'Range', 'b2:u225');
Sust_PJM_50VRE = readmatrix('Results_50VRE_Best.xlsx','Sheet', 'PJM', 'Range', 'b2:u125');
Sust_PJM_30VRE = readmatrix('Results_30VRE_Best.xlsx','Sheet', 'PJM', 'Range', 'b2:u116');

%%%%Obtain tech names for figure legends
Techs_Tbl = readtable('Results_30VRE_Best.xlsx','Sheet', 'PJM', 'Range', 'b1:s116', 'PreserveVariableNames', true);
Techs = Techs_Tbl.Properties.VariableNames;

%%%%%%%%%%%% Market Solutions %%%%%%%%%%
%%%%%%%%%%%%%%CAISO%%%%%%%%%%%%%%%%
%%%%%%% No VRE Constraint %%%%%%%%%


Solns = Mkt_CA_NoVRE(:,19:20);
Solns2 = Mkt_CA_NoVRE(:,1:18);
Solns = horzcat(Solns,Solns2);
%Solns = transpose(Solns);
Pareto_Solns = New_Pareto_Front_custom(Solns);
%Solns_to_plot = transpose(Pareto_Solns);
Median_Cost_Mkt_CA_NoVRE=median(Pareto_Solns,1);
%x=Solns_to_plot(:,1);
%y=Solns_to_plot(:,2);
%scatter(x,y)
Index_length = size(Pareto_Solns,1);
risk_soln_index=1;
cost_soln_index=1;
for index = 1:Index_length
    if Pareto_Solns(index,1)<Median_Cost_Mkt_CA_NoVRE(1)
        Risk_averse_solns(risk_soln_index,:) = Pareto_Solns(index,:);
        risk_soln_index=risk_soln_index+1;
    elseif Pareto_Solns(index,2)<Median_Cost_Mkt_CA_NoVRE(2)
        Cost_sens_solns(cost_soln_index,:) = Pareto_Solns(index,:);
        cost_soln_index = cost_soln_index + 1;
    end
end
Cost_scores(1,:) = mean(Cost_sens_solns);
Risk_scores(1,:) = mean(Risk_averse_solns);
Pareto_CAISO_NoVREConst_Market = Pareto_Solns;
Scen = 100*ones(size(Pareto_CAISO_NoVREConst_Market,1),1);
Pareto_CAISO_NoVREConst_Market = horzcat(Pareto_CAISO_NoVREConst_Market,Scen);
%%%%70 VRE Scenario%%%%%%%
%Clear the variables used in prior scenarios
Solns = [];
Solns2 = [];
Pareto_Solns = [];
Risk_averse_solns = [];
Cost_sens_solns = [];


%Find Pareto Front of Solutions for current scenario
Solns = Mkt_CA_70VRE(:,19:20);
Solns2 = Mkt_CA_70VRE(:,1:18);
Solns = horzcat(Solns,Solns2);
%Solns = transpose(Solns);
Pareto_Solns = New_Pareto_Front_custom(Solns);

%Compute median and matrices for risk averse and cost sensitive solutions
Median_Cost_Mkt_CA_70VRE=median(Pareto_Solns,1);
Index_length = size(Pareto_Solns,1);
risk_soln_index=1;
cost_soln_index=1;


for index = 1:Index_length
    if Pareto_Solns(index,1)<Median_Cost_Mkt_CA_70VRE(1)
        Risk_averse_solns(risk_soln_index,:) = Pareto_Solns(index,:);
        risk_soln_index=risk_soln_index+1;
    elseif Pareto_Solns(index,2)<Median_Cost_Mkt_CA_70VRE(2)
        Cost_sens_solns(cost_soln_index,:) = Pareto_Solns(index,:);
        cost_soln_index = cost_soln_index + 1;
    end
end

%Add risk averse and cost-sensitive solutions to the matrix
Cost_scores(2,:) = mean(Cost_sens_solns);
Risk_scores(2,:) = mean(Risk_averse_solns);
Pareto_CAISO_70VREConst_Market = Pareto_Solns;
Scen = 70*ones(size(Pareto_CAISO_70VREConst_Market,1),1);
Pareto_CAISO_70VREConst_Market = horzcat(Pareto_CAISO_70VREConst_Market,Scen);

%%%%50 VRE Scenario%%%%%%%
Solns = Mkt_CA_50VRE(:,19:20);
Solns2 = Mkt_CA_50VRE(:,1:18);
Solns = horzcat(Solns,Solns2);
%Solns = transpose(Solns);
Pareto_Solns = New_Pareto_Front_custom(Solns);


Median_Cost_Mkt_CA_50VRE=median(Pareto_Solns,1);
Index_length = size(Pareto_Solns,1);
risk_soln_index=1;
cost_soln_index=1;
Risk_averse_solns = [];
Cost_sens_solns = [];

for index = 1:Index_length
    if Pareto_Solns(index,1)<Median_Cost_Mkt_CA_50VRE(1)
        Risk_averse_solns(risk_soln_index,:) = Pareto_Solns(index,:);
        risk_soln_index=risk_soln_index+1;
    elseif Pareto_Solns(index,2)<Median_Cost_Mkt_CA_50VRE(2)
        Cost_sens_solns(cost_soln_index,:) = Pareto_Solns(index,:);
        cost_soln_index = cost_soln_index + 1;
    end
end
Cost_scores(3,:) = mean(Cost_sens_solns);
Risk_scores(3,:) = mean(Risk_averse_solns);
Pareto_CAISO_50VREConst_Market = Pareto_Solns;  
Scen = 50*ones(size(Pareto_CAISO_50VREConst_Market,1),1);
Pareto_CAISO_50VREConst_Market = horzcat(Pareto_CAISO_50VREConst_Market,Scen);

%%%%30 VRE Scenario%%%%%%%
Solns = Mkt_CA_30VRE(:,19:20);
Solns2 = Mkt_CA_30VRE(:,1:18);
Solns = horzcat(Solns,Solns2);
%Solns = transpose(Solns);
Pareto_Solns = New_Pareto_Front_custom(Solns);


Median_Cost_Mkt_CA_30VRE=median(Pareto_Solns,1);
Index_length = size(Pareto_Solns,1);
risk_soln_index=1;
cost_soln_index=1;
Risk_averse_solns = [];
Cost_sens_solns = [];

for index = 1:Index_length
    if Pareto_Solns(index,1)<Median_Cost_Mkt_CA_30VRE(1)
        Risk_averse_solns(risk_soln_index,:) = Pareto_Solns(index,:);
        risk_soln_index=risk_soln_index+1;
    elseif Pareto_Solns(index,2)<Median_Cost_Mkt_CA_30VRE(2)
        Cost_sens_solns(cost_soln_index,:) = Pareto_Solns(index,:);
        cost_soln_index = cost_soln_index + 1;
    end
end
Cost_scores(4,:) = mean(Cost_sens_solns);
Risk_scores(4,:) = mean(Risk_averse_solns);
Pareto_CAISO_30VREConst_Market = Pareto_Solns;
Scen = 30*ones(size(Pareto_CAISO_30VREConst_Market,1),1);
Pareto_CAISO_30VREConst_Market = horzcat(Pareto_CAISO_30VREConst_Market,Scen);

%%%%PJM No VRE Constraint%%%%%%%
Solns = Mkt_PJM_NoVRE(:,19:20);
Solns2 = Mkt_PJM_NoVRE(:,1:18);
Solns = horzcat(Solns,Solns2);
%Solns = transpose(Solns);
Pareto_Solns = New_Pareto_Front_custom(Solns);
Median_Cost_Mkt_PJM_NoVRE=median(Pareto_Solns,1);

Index_length = size(Pareto_Solns,1);
risk_soln_index=1;
cost_soln_index=1;
for index = 1:Index_length
    if Pareto_Solns(index,1)<Median_Cost_Mkt_PJM_NoVRE(1)
        Risk_averse_solns(risk_soln_index,:) = Pareto_Solns(index,:);
        risk_soln_index=risk_soln_index+1;
    elseif Pareto_Solns(index,2)<Median_Cost_Mkt_PJM_NoVRE(2)
        Cost_sens_solns(cost_soln_index,:) = Pareto_Solns(index,:);
        cost_soln_index = cost_soln_index + 1;
    end
end
Cost_scores(5,:) = mean(Cost_sens_solns);
Risk_scores(5,:) = mean(Risk_averse_solns);
Pareto_PJM_NoVREConst_Market = Pareto_Solns;
Scen = 100*ones(size(Pareto_PJM_NoVREConst_Market,1),1);
Pareto_PJM_NoVREConst_Market = horzcat(Pareto_PJM_NoVREConst_Market,Scen);

%%%%70 VRE Scenario%%%%%%%
Solns = Mkt_PJM_70VRE(:,19:20);
Solns2 = Mkt_PJM_70VRE(:,1:18);
Solns = horzcat(Solns,Solns2);
%Solns = transpose(Solns);
Pareto_Solns = New_Pareto_Front_custom(Solns);


Median_Cost_Mkt_PJM_70VRE=median(Pareto_Solns,1);
Index_length = size(Pareto_Solns,1);
risk_soln_index=1;
cost_soln_index=1;
Risk_averse_solns = [];
Cost_sens_solns = [];

for index = 1:Index_length
    if Pareto_Solns(index,1)<Median_Cost_Mkt_PJM_70VRE(1)
        Risk_averse_solns(risk_soln_index,:) = Pareto_Solns(index,:);
        risk_soln_index=risk_soln_index+1;
    elseif Pareto_Solns(index,2)<Median_Cost_Mkt_PJM_70VRE(2)
        Cost_sens_solns(cost_soln_index,:) = Pareto_Solns(index,:);
        cost_soln_index = cost_soln_index + 1;
    end
end
Cost_scores(6,:) = mean(Cost_sens_solns);
Risk_scores(6,:) = mean(Risk_averse_solns);
Pareto_PJM_70VREConst_Market = Pareto_Solns;
Scen = 70*ones(size(Pareto_PJM_70VREConst_Market,1),1);
Pareto_PJM_70VREConst_Market = horzcat(Pareto_PJM_70VREConst_Market,Scen);

%%%%50 VRE Scenario%%%%%%%
Solns = Mkt_PJM_50VRE(:,19:20);
Solns2 = Mkt_PJM_50VRE(:,1:18);
Solns = horzcat(Solns,Solns2);
%Solns = transpose(Solns);
Pareto_Solns = New_Pareto_Front_custom(Solns);


Median_Cost_Mkt_PJM_50VRE=median(Pareto_Solns,1);
Index_length = size(Pareto_Solns,1);
risk_soln_index=1;
cost_soln_index=1;
Risk_averse_solns = [];
Cost_sens_solns = [];

for index = 1:Index_length
    if Pareto_Solns(index,1)<Median_Cost_Mkt_PJM_50VRE(1)
        Risk_averse_solns(risk_soln_index,:) = Pareto_Solns(index,:);
        risk_soln_index=risk_soln_index+1;
    elseif Pareto_Solns(index,2)<Median_Cost_Mkt_PJM_50VRE(2)
        Cost_sens_solns(cost_soln_index,:) = Pareto_Solns(index,:);
        cost_soln_index = cost_soln_index + 1;
    end
end
Cost_scores(7,:) = mean(Cost_sens_solns);
Risk_scores(7,:) = mean(Risk_averse_solns);
Pareto_PJM_50VREConst_Market = Pareto_Solns;        
Scen = 50*ones(size(Pareto_PJM_50VREConst_Market,1),1);
Pareto_PJM_50VREConst_Market = horzcat(Pareto_PJM_50VREConst_Market,Scen);

%%%%30 VRE Scenario%%%%%%%
Solns = Mkt_PJM_30VRE(:,19:20);
Solns2 = Mkt_PJM_30VRE(:,1:18);
Solns = horzcat(Solns,Solns2);
%Solns = transpose(Solns);
Pareto_Solns = New_Pareto_Front_custom(Solns);


Median_Cost_Mkt_PJM_30VRE=median(Pareto_Solns,1);
Index_length = size(Pareto_Solns,1);
risk_soln_index=1;
cost_soln_index=1;
Risk_averse_solns = [];
Cost_sens_solns = [];

for index = 1:Index_length
    if Pareto_Solns(index,1)<Median_Cost_Mkt_PJM_30VRE(1)
        Risk_averse_solns(risk_soln_index,:) = Pareto_Solns(index,:);
        risk_soln_index=risk_soln_index+1;
    elseif Pareto_Solns(index,2)<Median_Cost_Mkt_PJM_30VRE(2)
        Cost_sens_solns(cost_soln_index,:) = Pareto_Solns(index,:);
        cost_soln_index = cost_soln_index + 1;
    end
end
Cost_scores(8,:) = mean(Cost_sens_solns);
Risk_scores(8,:) = mean(Risk_averse_solns);
Pareto_PJM_30VREConst_Market = Pareto_Solns;
Scen = 30*ones(size(Pareto_PJM_30VREConst_Market,1),1);
Pareto_PJM_30VREConst_Market = horzcat(Pareto_PJM_30VREConst_Market,Scen);

%%%%%%%%%%%% Sustainability Solutions %%%%%%%%%%
%%%%%%%%%%%%%%CAISO%%%%%%%%%%%%%%%%
%%%%%%% No VRE Constraint %%%%%%%%%


Solns = [];
Solns2 = [];
Pareto_Solns = [];

%Find Pareto Front of the current scenario
Solns = Sust_CA_NoVRE(:,19:20);
Solns2 = Sust_CA_NoVRE(:,1:18);
Solns = horzcat(Solns,Solns2);
%Solns = transpose(Solns);
Pareto_Solns = New_Pareto_Front_custom(Solns);

%Find the score for each technology
Sust_scores(1,:) = mean(Pareto_Solns);
% Solns_to_plot = -Pareto_Solns;
% x=Solns_to_plot(:,1);
% y=Solns_to_plot(:,2);
% scatter(x,y)
Pareto_CAISO_NoVREConst_Sust = -Pareto_Solns;
Scen = 100*ones(size(Pareto_CAISO_NoVREConst_Sust,1),1);
Pareto_CAISO_NoVREConst_Sust = horzcat(Pareto_CAISO_NoVREConst_Sust,Scen);

%%%%70 VRE Scenario%%%%%%%
%Clear the variables used in other scenarios
Solns = [];
Solns2 = [];
Pareto_Solns = [];
Risk_averse_solns = [];
Cost_sens_solns = [];

%Find Pareto Front of the current scenario
Solns = Sust_CA_70VRE(:,19:20);
Solns2 = Sust_CA_70VRE(:,1:18);
Solns = horzcat(Solns,Solns2);
%Solns = transpose(Solns);
Pareto_Solns = New_Pareto_Front_custom(Solns);

%Find the score for each technology
Sust_scores(2,:) = mean(Pareto_Solns);
% Solns_to_plot = -Pareto_Solns;
% x=Solns_to_plot(:,1);
% y=Solns_to_plot(:,2);
% scatter(x,y)
Pareto_CAISO_70VREConst_Sust = -Pareto_Solns;
Scen = 70*ones(size(Pareto_CAISO_70VREConst_Sust,1),1);
Pareto_CAISO_70VREConst_Sust = horzcat(Pareto_CAISO_70VREConst_Sust,Scen);


% %%%%50 VRE Scenario%%%%%%%
%Clear the variables used in other scenarios
Solns = [];
Solns2 = [];
Pareto_Solns = [];
Risk_averse_solns = [];
Cost_sens_solns = [];
% 
%Find Pareto Front of the current scenario
Solns = Sust_CA_50VRE(:,19:20);
Solns2 = Sust_CA_50VRE(:,1:18);
Solns = horzcat(Solns,Solns2);
%Solns = transpose(Solns);
Pareto_Solns = New_Pareto_Front_custom(Solns);
% 
%Find the score for each technology
Sust_scores(3,:) = mean(Pareto_Solns);  
Pareto_CAISO_50VREConst_Sust = -Pareto_Solns;
Scen = 50*ones(size(Pareto_CAISO_50VREConst_Sust,1),1);
Pareto_CAISO_50VREConst_Sust = horzcat(Pareto_CAISO_50VREConst_Sust,Scen);


%%%%30 VRE Scenario%%%%%%%
%Clear the variables used in other scenarios
Solns = [];
Solns2 = [];
Pareto_Solns = [];
Risk_averse_solns = [];
Cost_sens_solns = [];
% 
%Find Pareto Front of the current scenario
Solns = Sust_CA_30VRE(:,19:20);
Solns2 = Sust_CA_30VRE(:,1:18);
Solns = horzcat(Solns,Solns2);
%Solns = transpose(Solns);
Pareto_Solns = New_Pareto_Front_custom(Solns);
% 
%Find the score for each technology
Sust_scores(4,:) = mean(Pareto_Solns);  
Pareto_CAISO_30VREConst_Sust = -Pareto_Solns;
Scen = 30*ones(size(Pareto_CAISO_30VREConst_Sust,1),1);
Pareto_CAISO_30VREConst_Sust = horzcat(Pareto_CAISO_30VREConst_Sust,Scen);

% %%%%PJM No VRE Constraint%%%%%%%
%%%%%%% No VRE Constraint %%%%%%%%%


Solns = [];
Solns2 = [];
Pareto_Solns = [];

%Find Pareto Front of the current scenario
Solns = Sust_PJM_NoVRE(:,19:20);
Solns2 = Sust_PJM_NoVRE(:,1:18);
Solns = horzcat(Solns,Solns2);
%Solns = transpose(Solns);
Pareto_Solns = New_Pareto_Front_custom(Solns);

%Find the score for each technology
Sust_scores(5,:) = mean(Pareto_Solns);
Solns_to_plot = -Pareto_Solns;
% x=Solns_to_plot(:,1);
% y=Solns_to_plot(:,2);
%scatter(x,y)
Pareto_PJM_NoVREConst_Sust = -Pareto_Solns;
Scen = 100*ones(size(Pareto_PJM_NoVREConst_Sust,1),1);
Pareto_PJM_NoVREConst_Sust = horzcat(Pareto_PJM_NoVREConst_Sust,Scen);% 

%%%%%%%%70 VRE Scenario%%%%%%%%%%%%%%%%%%%
%Clear the variables used in other scenarios
Solns = [];
Solns2 = [];
Pareto_Solns = [];
Risk_averse_solns = [];
Cost_sens_solns = [];

%Find Pareto Front of the current scenario
Solns = Sust_PJM_70VRE(:,19:20);
Solns2 = Sust_PJM_70VRE(:,1:18);
Solns = horzcat(Solns,Solns2);
%Solns = transpose(Solns);
Pareto_Solns = New_Pareto_Front_custom(Solns);

%Find the score for each technology
Sust_scores(6,:) = mean(Pareto_Solns);
% Solns_to_plot = -Pareto_Solns;
% x=Solns_to_plot(:,1);
% y=Solns_to_plot(:,2);
% scatter(x,y)
Pareto_PJM_70VREConst_Sust = -Pareto_Solns;
Scen = 70*ones(size(Pareto_PJM_70VREConst_Sust,1),1);
Pareto_PJM_70VREConst_Sust = horzcat(Pareto_PJM_70VREConst_Sust,Scen);% 

% %%%%50 VRE Scenario%%%%%%%
%Clear the variables used in other scenarios
Solns = [];
Solns2 = [];
Pareto_Solns = [];
Risk_averse_solns = [];
Cost_sens_solns = [];
% 
%Find Pareto Front of the current scenario
Solns = Sust_PJM_50VRE(:,19:20);
Solns2 = Sust_PJM_50VRE(:,1:18);
Solns = horzcat(Solns,Solns2);
%Solns = transpose(Solns);
Pareto_Solns = New_Pareto_Front_custom(Solns);
% 
%Find the score for each technology
Sust_scores(7,:) = mean(Pareto_Solns);  
Pareto_PJM_50VREConst_Sust = -Pareto_Solns;
Scen = 50*ones(size(Pareto_PJM_50VREConst_Sust,1),1);
Pareto_PJM_50VREConst_Sust = horzcat(Pareto_PJM_50VREConst_Sust,Scen);% 

%%%%30 VRE Scenario%%%%%%%
%Clear the variables used in other scenarios
Solns = [];
Solns2 = [];
Pareto_Solns = [];
Risk_averse_solns = [];
Cost_sens_solns = [];
% 
%Find Pareto Front of the current scenario
Solns = Sust_PJM_30VRE(:,19:20);
Solns2 = Sust_PJM_30VRE(:,1:18);
Solns = horzcat(Solns,Solns2);
%Solns = transpose(Solns);
Pareto_Solns = New_Pareto_Front_custom(Solns);
% 
%Find the score for each technology
Sust_scores(8,:) = mean(Pareto_Solns);  
Pareto_PJM_30VREConst_Sust = -Pareto_Solns;
Scen = 30*ones(size(Pareto_PJM_30VREConst_Sust,1),1);
Pareto_PJM_30VREConst_Sust = horzcat(Pareto_PJM_30VREConst_Sust,Scen);% 

%%%%%%%Market Barrier Calculations%%%%%%%%%%%%
Risk_averse_barriers = Risk_scores - Sust_scores;
Cost_sens_barriers = Cost_scores - Sust_scores;

%scatter(Risk_averse_barriers)
%Scores add, so first two columns are meaningless
Labels = {'CAISO no VRE Const', 'CAISO 70 VRE Const', 'CAISO 50 VRE Const',...
    'CAISO 30 VRE Const', 'PJM no VRE Const', 'PJM 70 VRE Const', 'PJM 50 VRE Const',...
    'PJM 30 VRE Const'};
X = categorical(Techs);
for i = 1:size(Risk_averse_barriers,1)
    Y = Risk_averse_barriers(i, 3:20);
    scatter(X, Y)
    hold on
end
legend(Labels, 'Location', 'southwest')
hold off
saveas(gcf,'Risk_averse_barriers.png');

for i = 1:size(Cost_sens_barriers,1)
    Y = Cost_sens_barriers(i, 3:20);
    scatter(X, Y)
    hold on
end
legend(Labels, 'Location', 'southwest')
hold off
saveas(gcf,'Cost_sens_barriers.png');
%%%%%%%%%%  Plots %%%%%%%%%%%%%%%%
%%%%Plot Pareto Fronts for CAISO Market Solutions%%%%%%
%First get scores into format that will be good for gscatter function


CAISO_Market = vertcat(Pareto_CAISO_NoVREConst_Market, Pareto_CAISO_70VREConst_Market,...
    Pareto_CAISO_50VREConst_Market, Pareto_CAISO_30VREConst_Market);

PJM_Market = vertcat(Pareto_PJM_NoVREConst_Market, Pareto_PJM_70VREConst_Market,...
    Pareto_PJM_50VREConst_Market, Pareto_PJM_30VREConst_Market);

CAISO_Sust = vertcat(Pareto_CAISO_NoVREConst_Sust, Pareto_CAISO_70VREConst_Sust,...
    Pareto_CAISO_50VREConst_Sust, Pareto_CAISO_30VREConst_Sust);

PJM_Sust = vertcat(Pareto_PJM_NoVREConst_Sust, Pareto_PJM_70VREConst_Sust,...
    Pareto_PJM_50VREConst_Sust, Pareto_PJM_30VREConst_Sust);


%%%%%%Use gscatter function to plot each set of Pareto Fronts

gscatter(CAISO_Market(:,1),CAISO_Market(:,2), CAISO_Market(:,21),'','xod*')
%saveas(gcf,'CAISO_Market_Solns.png');
gscatter(PJM_Market(:,1),PJM_Market(:,2), PJM_Market(:,21),'','xod*')
%saveas(gcf,'PJM_Market_Solns.png');

% Sustainable solutions
tiledlayout(1,2)
nexttile
gscatter(CAISO_Sust(:,1),CAISO_Sust(:,2), CAISO_Sust(:,21),'','xod*')
title('CAISO')
%saveas(gcf,'CAISO_Sust_Solns.png');
nexttile
gscatter(PJM_Sust(:,1),PJM_Sust(:,2), PJM_Sust(:,21),'','xod*')
title('PJM')
%saveas(gcf,'PJM_Sust_Solns.png');
%saveas(gcf,'All_Sust_Solns.png');

%%%%%%Calculate percentage of VRE in Solutions%%%%%%%%
VRE_Pct_Risk = sum(Risk_scores(:,[3 4 6 12 13 14 15 16 17 18]),2);
VRE_Pct_Cost = sum(Cost_scores(:,[3 4 6 12 13 14 15 16 17 18]),2);
VRE_Pct_Sust = sum(Sust_scores(:,[3 4 6 12 13 14 15 16 17 18]),2);