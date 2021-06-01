%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          Evolutionary dynamics on a phenotypic landscape       %
% 
%   Authors
%
%       Carmen Ortega Sabater - Predoctoral researcher
%           carmen.ortegasabater@uclm.es
%
%       V�ctor M. P�rez Garc�a  - PI   victor.perezgarcia@uclm.es             
%       Gabriel Fern�ndez Calvo - PI   gabriel.fernandez@uclm.es           
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Normal approximation to binormal distribution
function Number = binormal(N,p)
%
%
li = length(N);
Number = zeros(size(N));

for j=1:li
if N(j) == 0
    Number(j) = 0;
elseif N(j)<1000
    Number(j) = sum(rand(N(j),1) < p(j));
else
    Number(j) = floor(normrnd(N(j)*p(j),sqrt(N(j)*p(j)*(1-p(j)))));
end
end;
