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

% Auxiliary file 4. This script allow us to generate plots.
% We also study the change in average rho with time.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              PLOTS              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Figure 1. Evolution of average proliferation rate in all population
% Draw all trajectories and average proliferation rate with a thicker line

figure()
hold on
% Computer modern seems to be latex font's name, but it doesn't seem to
% work
box on
ax = gca;
ax.FontSize = 18;
for ii = 2:replicates %Skip first inf column
    plot(time, rho_average(:, ii), 'Color', [193 198 200]/255)
end 
plot( time, mean_rho_average, 'Color', [93 90 89]/255, 'LineWidth', 3.5 );  
xlabel( '$t\;(days)$', 'FontSize', 18, 'Interpreter','latex' ); 
ylabel('$\textrm{Average proliferation rate} \; (\bar{\rho})$','FontSize', 18, 'Interpreter','latex');
hold off

% Figure 2. Evolution of the centroid of the distribution
% We use the average of population and centroid evolution for all
% simulations

% Customize colormap - Fogata palette 
mymap = [39 153 137
    80 166 132
    169 196 127 
    251 221 122 
    255 181 73
    255 157 110
    227 120 94 
    194 110 96 
    164 73 61 
    130 59 52]/255;

figure();
hold on
box on
ax = gca;
ax.FontSize = 18; 
pcolor(log10(mean_population+1));
shading interp;
colormap(mymap);
plot(mean_centroid,time,'w--','LineWidth',3); % We have to use the average for all simulations
axis([1 Npheno 0 simSteps]);
title('log N(Phenotype, time)', 'FontSize', 18);
xlabel('$\textrm{Phenotype index}$', 'FontSize', 18, 'Interpreter','latex' );
ylabel('$\textrm{Time (days)}$', 'FontSize', 18, 'Interpreter','latex')
colorbar;
hold off;

% Figure 3. Evolution of total population with time.

figure();
hold on
box on
ax = gca;
ax.FontSize = 18; 
for ii = 1:replicates %Skip first inf column
    plot(time, log10(Mass(:, ii)), 'Color', [193 198 200]/255)
end 
plot(time,log10(mean_mass),'Linewidth', 3, 'Color', [93 90 89]/255 );
xlabel('$\textrm{Time (days)}$', 'FontSize', 18, 'Interpreter','latex');
ylabel('$\textrm{log N (cells)}$', 'FontSize', 18, 'Interpreter','latex');
hold off

% Figure 4. Log N (total population) vs. log Activity (newborn cells)

figure();
hold on
box on
ax = gca;
ax.FontSize = 18; 
for ii = 1:replicates %Skip first inf column
    plot(log10(Mass(:, ii)), log10(Activity(:,ii)), 'Color', [250 114 104]/255)
end 
plot(log10(mean_mass),log10(mean_activity), 'Linewidth', 3, 'Color', [93 90 89]/255)
xlabel('$\textrm{log N (cells)}$', 'FontSize', 18, 'Interpreter','latex');
ylabel('$\textrm{log Activity (cells)}$', 'FontSize', 18, 'Interpreter','latex');
hold off

% Figure 5. Evolution of phenotypic distribution with time. 

pF_1 = mean_phenoFreq( 1, : );  
pF_midtime = mean_phenoFreq( size(Population,1)/2, :); 
pF_end = mean_phenoFreq( end, : );

rho_day = rho*dt;  %transform rho units to days^-1

figure();
hold on
box on 
ax = gca;
ax.FontSize = 26; 
a1 = area(rho_day, pF_1, 'Linewidth', 2, 'FaceAlpha', 0.3, 'FaceColor',[0 0.25 0.25]);
a2 = area(rho_day, pF_midtime, 'Linewidth', 2, 'FaceAlpha', 0.7, 'FaceColor', [187/255 161/255 79/255]);
a3 = area(rho_day, pF_end, 'Linewidth', 2, 'FaceAlpha', 0.6, 'FaceColor',[155/255 20/255 14/255]);
a1.EdgeColor = [0 0.25 0.25];
a2.EdgeColor = [187/255 161/255 79/255];
a3.EdgeColor = [155/255 20/255 14/255];
ylim([0 0.40])
xlabel('$\mathrm{Proliferation \; rate} \; (\mathrm{days}^{-1})$', 'FontSize', 22, 'Interpreter','latex' );
ylabel('$\mathrm{Phenotypic \; frequency}$', 'FontSize', 22, 'Interpreter','latex');
legend({'$t = 0 \; \mathrm{days}$', '$t = 15 \; \mathrm{days}$', '$t = 30 \; \mathrm{days}$' },'Interpreter','latex')
legend boxoff  
hold off 

% Find change in average rho 
averRho_beginning = mean_centroid(1)
averRho_end = mean_centroid(end)
averRho_increase = ((averRho_end / averRho_beginning)-1)*100 

