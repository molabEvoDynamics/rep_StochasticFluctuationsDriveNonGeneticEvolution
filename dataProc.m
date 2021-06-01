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


% Auxiliary file 3.   dataProc.m -- 
% Process the data from the replicates (independent
% simulations). Find average for all relevant variables.

% 'sd' accounts for standard deviation
% 'sem' accounts for standard error of the mean

% 1. Evolution of average rho in time
mean_rho_average = mean( rho_average(:, 2:end), 2 );
sd_rho_average = std( rho_average(:, 2:end), [], 2);
sem_rho_average = sd_rho_average/sqrt(replicates); 

% 2. Centroid deviation 
mean_centroid = mean( Centroid, 2 ); % mean by rows
sd_centroid = std( Centroid,[],2); %standard deviation by rows
sem_centroid = sd_centroid/sqrt(replicates); %

% 3. N average (phenotypic distribution)
mean_population = mean( Population, 3 );
sd_population = std( Population, [], 2 );
sem_population = sd_population/sqrt(replicates);

% 4. N average (total population)
mean_mass = mean( Mass, 2 );
sd_mass = std( Mass, [], 2 );
sem_mass = sd_mass/sqrt(replicates);

% 5. Activity
mean_activity = mean( Activity, 2 ); 
sd_activity = std( Activity, [], 2); 
sem_activity = sd_activity/sqrt(replicates); 

% 6. Phenotypic frequencies
mean_phenoFreq = mean( history_phenoFreq, 3 );
sd_phenoFreq = std(history_phenoFreq,[],3);
sem_phenoFreq = sd_phenoFreq/sqrt(replicates);

