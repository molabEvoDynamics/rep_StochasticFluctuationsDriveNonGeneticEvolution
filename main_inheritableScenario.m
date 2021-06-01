%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          Evolutionary dynamics on a phenotypic landscape       %
% 
%   Authors
%
%       Carmen Ortega Sabater - PhD Student
%           carmen.ortegasabater@uclm.es
%
%       Víctor M. Pérez García  - PI   victor.perezgarcia@uclm.es             
%       Gabriel Fernández Calvo - PI   gabriel.fernandez@uclm.es           
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Auxiliary file 2. This file contains the core of the model to perform
% the simulations. 

% Initialize counters and memory
clear all; close all;
tic;

% Load parameters and data structures
run( 'parameters.m' );
    
for m = 1:replicates
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %          Initial condition          %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        n = zeros(1,Npheno);
        TotalCells = 10000;
        
        % Initial cells are distributed across phenotypes with a
        % Gaussian of width InitialWidth
        InitialWidth = 1;
        InitialDistr = round(HalfLatt + randn(TotalCells,InitialWidth));
        
        PhInimin = min(InitialDistr);
        PhIniMax = max(InitialDistr);
        PhInitial = zeros(size(n));
        for PhjIni = PhInimin:PhIniMax
            % This only determines which phenotypes we are going to initially
            % fill with some cells
            n(PhjIni) = sum(InitialDistr==PhjIni);
        end;
        
        
        for s=1:up_simSteps % Number of time steps
            
            % Proliferation stage
             %   Newborn cells
             newborn = binormal( n, rho);
                % Dead cells 
             dead = binormal( n, ProbDeath ); 
            
            % Proliferation stage: considering logistic growth
            % UNCOMMENT the lines below for LOGISTIC GROWTH scenario
                % Newborn cells
%             rho_modified = (1-(Mass(s)/K))*rho;
%             newborn = binormal( n, rho_modified);
%                 % Dead cells
%             ProbDeath_modified = (Mass(s)/K)*ProbDeath;
%             dead = binormal( n, ProbDeath_modified ); 
            
            % Compute those going back to the original phenotype
            PhenoBack = binormal( n, ProbBack);
            
            % Newborn cells can switch their phenotypes (diffusion in rho space)
            ChangePhenoUp   = binormal(n, PhenoSwitch/2);
            ChangePhenoDown = binormal(n, PhenoSwitch/2);
            
            % Update population - IRREVERSIBLE changes
            nb = newborn - ChangePhenoUp - ChangePhenoDown;
            
            % Computation of those changing phenotypes
            CPUp   = [0 ChangePhenoUp(1:Npheno-1)];
            CPDown = [ChangePhenoDown(2:Npheno) 0];
            
            % Destination of those loosing their random-modifications
            Nlost = sum(PhenoBack);   % How many cells are recovering their
                                      % phenotypic basal state                 
            PhenoBackX = round(HalfLatt + randn(Nlost,1)); 
            
            PhMin = min(PhenoBackX);
            PhMax = max(PhenoBackX);
            PhBack = zeros(size(n));
            for Phj = PhMin:PhMax
                PhBack(Phj) = sum(PhenoBackX==Phj);
            end;
            
            % IRREVERSIBLE changes + DEATH
            n = n + CPUp + CPDown + nb - dead ;
            
            % Save results
            rho_average(s,m) = sum(rho.*n)/Mass(s);
            Population(s,:, m) = n; % Se guarda la población
            Mass(s, m) = sum(n);     % Calcula la población total
            Centroid(s, m) = sum((1:Npheno).*n)/Mass(s);
            %[Valor MaxDensity(s)] = max(n);
            t(s) = s;
            Activity(s,m) = sum(newborn);
            % Find frequency for each phenotype
            totalPheno = Population( s, :, m);
            phenoFreq = totalPheno/Mass(s,m);
            history_phenoFreq(s, :, m) = phenoFreq; 
        end
        
%       % Linear fitting to find slope of Log Act vs Log N
        Mass_temp = Mass(:,m);
        Activity_temp = Activity( :, m);
        lm = fitlm( log10(Mass_temp), log10( Activity_temp));
        % Extracting slope from linear fitting
        beta = lm.Coefficients.Estimate(2);
        beta_coefficient(m) = beta;
        
    end

% load chirp
% sound(y,Fs)

% Process the resulting files 
run( 'dataProc.m' )

% Plot the results 
run( 'plots.m'  )


toc;





