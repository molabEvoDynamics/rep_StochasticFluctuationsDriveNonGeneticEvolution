%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          Evolutionary dynamics on a phenotypic landscape       %
% 
%   Authors
%
%       Carmen Ortega Sabater - Predoctoral researcher
%           carmen.ortegasabater@uclm.es
%
%       Víctor M. Pérez García  - PI   victor.perezgarcia@uclm.es             
%       Gabriel Fernández Calvo - PI   gabriel.fernandez@uclm.es           
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Auxiliary file 1. In this script we predefine
% all parameters and data structures

%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Parameters       %
%%%%%%%%%%%%%%%%%%%%%%%%%%

    simSteps = 30;             % Measured in days (total simulation time)
    deltat = [1 2 4 8 16 32];   % 24h 12h 6h 3h 1.5h 0.75h respectively
    dt = 24;
    up_simSteps = dt*simSteps;  % Adjust number of outputs to have the same 
                                % total simulation time   
    time = 0+(1/dt):1/dt:simSteps % Time vector (for plots)                            
    replicates = 50;            % number of replicates 

    HalfLatt = 21;              % Starting phenotype [rho_* = 0.2]
    
    K = 5*10^9                  % Carrying capacity (K) 
    
%%%%%%%%%%%%%%%
%    RATES    %
%%%%%%%%%%%%%%%

% Growth rates 
    rhomin     = 0;             % Minimum proliferation probability [day^-1]
    rhomax     = 1;           % Maximum proliferation probability [day^-1]
    Npheno     = 101;           % Number of different phenotypes [M]
    rho(1:Npheno) = rhomin:(rhomax-rhomin)/(Npheno-1):rhomax; %Vector of phenotypes
    rho = (1/dt)*rho;           % \Delta \rho = 0.005 [day^-1]             

% Probability to change phenotype in any direction
    ProbChange  = 6;   % Gamma [days^-1]. 1 phenotypic change every 4 hours                   
    PhenoSwitch = ProbChange*(1/dt)*ones(size(rho)); 
    
    D = ProbChange*(((rhomax-rhomin)/(Npheno-1))^2)/2 % Difussion coefficient (D) [days^-2] 
    
% Probability of losing these epigenetic modifications
% (reversible changes scenario)
% In our case we are considering this lost after around 6 cell divisions
    %ProbBack = rho;
    ProbBack    = 1*ones(size(rho)) %[days^-1]; 
    
% Death probability. All cells die with the same death rate
% 1/4*rho from initiating phenotype (HalfLatt)
     ProbDeath = 0.01*ones(size(rho))*(1/dt); %[days^-1]
     % ProbDeath = ones(size(rho))*rho(HalfLatt)*(1/4); 
                             

%%%%%%%%%%%%%%%%%%%%%%%%%
%    STORING RESULTS    %
%%%%%%%%%%%%%%%%%%%%%%%%%

% Tracking population from each phenotype
    Population = zeros(up_simSteps, Npheno, replicates);
% Tracking total population
    Mass = zeros(up_simSteps, replicates); 
% Tracking average growth rate (whole population)    
    rho_average = zeros( up_simSteps, replicates);
% Tracking the centroid of phenotypic distribution    
    Centroid = zeros( up_simSteps, replicates);
% Tracking cell activity (in terms of newborn cells)    
    Activity = zeros( up_simSteps, replicates);
% Tracking the slope from the lineal fitting of log N vs. log activity    
    beta_coefficient = zeros(1, replicates);
% Tracking phenotypic frequencies over time  
    history_phenoFreq = zeros(up_simSteps, Npheno, replicates);