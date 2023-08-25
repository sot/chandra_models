function MeteorShowers = characteristics_MeteorShowers()

% Meteor Shower related characteristics
%

%--------------------------------------------------------------------------
% Rev#    Date       Who     Purpose
% ----  --------  ---------  ---------
%  000  06/02/11  M.Baski    Original.
%  001  08/14/12  M.Baski    Added limits for annual flux data for 
%                            DDTS 9417.
%
%--------------------------------------------------------------------------


% Meteor shower limits
%

% -10000 indicates the limit should not be shown
no_limit = -10000;

% Number of predicted body impacts (per CARD SYST-C-005, as of 6/29/11)
MeteorShowers.Num_Impacts_Body.reference_limit = no_limit;  % Units of count
MeteorShowers.Num_Impacts_Body.yellow_limit    = no_limit;  % Units of count
MeteorShowers.Num_Impacts_Body.red_limit       = 0.000098;  % Units of count

% Number of predicted solar array impacts (per CARD SYST-C-005, as of 6/29/11)
MeteorShowers.Num_Impacts_SA.reference_limit   = no_limit;  % Units of count
MeteorShowers.Num_Impacts_SA.yellow_limit      = no_limit;  % Units of count
MeteorShowers.Num_Impacts_SA.red_limit         = 0.000012;  % Units of count

% Probability of impact limits for 0.04cm objects
MeteorShowers.Prob_Impact_0_04cm.reference_limit = no_limit; % Units of %/hr
MeteorShowers.Prob_Impact_0_04cm.yellow_limit    = no_limit; % Units of %/hr
MeteorShowers.Prob_Impact_0_04cm.red_limit       = no_limit; % Units of %/hr

% Probability of impact limits for 0.10cm objects
MeteorShowers.Prob_Impact_0_1cm.reference_limit = no_limit; % Units of %/hr
MeteorShowers.Prob_Impact_0_1cm.yellow_limit    = no_limit; % Units of %/hr
MeteorShowers.Prob_Impact_0_1cm.red_limit       = no_limit; % Units of %/hr

% Probability of impact limits for 0.30cm objects
MeteorShowers.Prob_Impact_0_3cm.reference_limit = no_limit; % Units of %/hr
MeteorShowers.Prob_Impact_0_3cm.yellow_limit    = no_limit; % Units of %/hr
MeteorShowers.Prob_Impact_0_3cm.red_limit       = no_limit; % Units of %/hr

% Probability of impact limits for 1.00cm objects
MeteorShowers.Prob_Impact_1_0cm.reference_limit = no_limit; % Units of %/hr
MeteorShowers.Prob_Impact_1_0cm.yellow_limit    = no_limit; % Units of %/hr
MeteorShowers.Prob_Impact_1_0cm.red_limit       = no_limit; % Units of %/hr

% Fluence limits for 0.04cm objects
MeteorShowers.Fluence_0_04cm.reference_limit = no_limit;    % Units of #/m^2
MeteorShowers.Fluence_0_04cm.yellow_limit    = no_limit;    % Units of #/m^2
MeteorShowers.Fluence_0_04cm.red_limit       = no_limit;    % Units of #/m^2

% Flux limits for annual flux data, 0.04cm objects
MeteorShowers.Annual_Flux_0_04cm.reference_limit = no_limit;  % Units of #/m^2/hr
MeteorShowers.Annual_Flux_0_04cm.yellow_limit    = no_limit;  % Units of #/m^2/hr
MeteorShowers.Annual_Flux_0_04cm.red_limit       = no_limit;  % Units of #/m^2/hr

% Flux limits for annual flux data, 0.10cm objects
MeteorShowers.Annual_Flux_0_1cm.reference_limit = 2E-7;      % Units of #/m^2/hr
MeteorShowers.Annual_Flux_0_1cm.yellow_limit    = no_limit;  % Units of #/m^2/hr
MeteorShowers.Annual_Flux_0_1cm.red_limit       = no_limit;  % Units of #/m^2/hr

% Flux limits for annual flux data, 0.30cm objects
MeteorShowers.Annual_Flux_0_3cm.reference_limit = no_limit;  % Units of #/m^2/hr
MeteorShowers.Annual_Flux_0_3cm.yellow_limit    = no_limit;  % Units of #/m^2/hr
MeteorShowers.Annual_Flux_0_3cm.red_limit       = no_limit;  % Units of #/m^2/hr

% Flux limits for annual flux data, 1.00cm objects
MeteorShowers.Annual_Flux_1_0cm.reference_limit = no_limit;  % Units of #/m^2/hr
MeteorShowers.Annual_Flux_1_0cm.yellow_limit    = no_limit;  % Units of #/m^2/hr
MeteorShowers.Annual_Flux_1_0cm.red_limit       = no_limit;  % Units of #/m^2/hr

% Flux limits for detailed flux data
MeteorShowers.Detailed_Flux.reference_limit = no_limit;  % Units of #/m^2/hr
MeteorShowers.Detailed_Flux.yellow_limit    = no_limit;  % Units of #/m^2/hr
MeteorShowers.Detailed_Flux.red_limit       = no_limit;  % Units of #/m^2/hr

% Probability of impact limits for detailed flux data
MeteorShowers.Prob_Impact_Detailed_Flux.reference_limit = no_limit;  % Units of %/hr
MeteorShowers.Prob_Impact_Detailed_Flux.yellow_limit    = no_limit;  % Units of %/hr
MeteorShowers.Prob_Impact_Detailed_Flux.red_limit       = no_limit;  % Units of %/hr

% Default meteor shower event window size
MeteorShowers.Default_Event_Duration = 12; % Hrs
