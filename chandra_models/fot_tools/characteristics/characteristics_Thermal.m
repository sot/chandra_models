function Thermal = characteristics_Thermal

%  characteristics_Thermal:     Parameters for thermal predictive models
%      used by MCC

%--------------------------------------
% Rev#    Date       Who      Purpose
% ----  --------  ---------------------
%  000  04/02/03  Tan Trinh   Original
%  001  10/14/03  Tan Trinh   Update equations for upcoming perihelion
%  002  07/01/04  Tan Trinh   Updated equations to matrix form (means bins
%                             can be of arbitrary size and begin and end
%                             points can be arbitrary; also updated settle
%                             temp calculator to accommodate
%  003  08/30/04  Tan Trinh   Added sine-exponent
%                             fitting for offsets, and removed settle temp
%                             calcs which will be done in drawPlot now.
%                             Also, updated new coeffs for TEPHIN
%  004  10/21/04  Tan Trinh   Added forw sun characteristics for TEPHIN
%  005  12/10/04  Tan Trinh   Added eclipse slope for TEPHIN
%  006  02/28/05  Tan Trinh   Added PLINE characteristics
%  007  03/24/05  Tan Trinh   Updated new coeffs for PM1THV1T & PM2THV1T
%                             Decreased TEPHIN reference limit from 97 to 96
%  008  04/11/05  Tan Trinh   Added time-thresholds for PLINE constraints
%                             Lowered 156-163 region for PLINES to 155-163
%  009  06/16/05  Tan Trinh   Added new gridded PLINE constraints
%  010  11/29/05  Tan Trinh   Updated new coefficients for TEPHIN; with
%                             previous model, telemetry ran hotter than
%                             predictions for hot attitudes
%  011  12/23/05  Tan Trinh   Updated TEPHIN yellow 105->115, ref 96->110
%                             Added TEPHIN benchmark temperatures for TEPHIN
%                             dwell time matrix
%  012  05/07/06  Tan Trinh   Added 1PIN1AT & 3TSCPOS characteristics
%  013  02/20/07  Tan Trinh   Updated TEPHIN coefficients and cosexp (for bias term)
%  014  06/05/07  S. Bucher   Updated reference limit to reflect MP Guideline change
%       06/13/07  Tan Trinh   Scheduled update TEPHIN coefficients and cosexp
%  015  06/18/07  Tan Trinh   Added characteristics for ACIS chips for 1PIN1AT model
%                             Changed TEPHIN dwell time limits to be notched
%                             to TEPHIN reference temperature
%  016  07/28/07  Tan Trinh   Updated TEPHIN coefficients & cosexp (actual cosexp change,
%                             not just for bias term) & limits
%  017  09/14/07  Tan Trinh   Edited pline constraint grid ... region 170-185 is now 152-185
%  018  12/11/07  Tan Trinh   Moved PLINE region lower bounds from 152-154, per PLINE 
%                             analysis, approved at FDB 12/06/07
%  019  04/23/08  Tan Trinh   Eliminated 154 base for PLINE region, approved
%                             at FDB 04/17/08  
%  020  07/14/08  S. Wilson   Added column to PLINE table to support dynamic
%                             PLINE regions in LIGER (tools updated to be 
%                             compatible).
%  021  04/07/09  M.Pendexter Updated TEPHIN yellow 119->133, ref 114->117
%                             Updated 1PIN1AT ref 36->38.5
%  022  10/05/09  J.Connelly  Added and updated PSMC model coefficients
%  023  12/03/09  M.Pendexter Updated TEPHIN ref limit 120->117
%  024  01/13/10  J.Connelly  Updated PSMC characteristics to SOT version 6
%  025  01/26/10  M.Pendexter Updated TEPHIN ref limit 117->120
%  026  03/02/10  M.Baski     Added parameters for n-mass thermal model.
%  027  05/27/10  M.Baski     Updated TEPHIN ref limit from 120 to 123 and
%                             limits for multi-mass -Z thermal model per 
%                             the 5/25/10 Thermal Working Group.
%  028  08/12/10  M.Baski     Updated TEPHIN ref limit from 123 to 128 deg
%                             per DDTS OCCcm09128.
%  029  12/08/10  M.Baski     Updated TEPHIN ref limit from 128 to 132 deg
%                             and yellow limit from 133 to 135 degF per 
%                             DDTS OCCcm09213.
%  030  02/02/11  M.Baski     Updated TCYLAFT6 ref limit from 93 to 96 deg
%                             per DDTS OCCcm09250.
%  031  09/18/11  M.Baski     Updated TEPHIN ref limit from 132 to 135 deg,
%                             yellow limit from 135 to 140 deg, and red
%                             limit from 140 to 150 deg, per DDTS 9398 and
%                             15 Sep 2011 FDB.
%  032  12/12/11  M.Baski     Updated PSMC thermal model parameters per
%                             email from Matt (DDTS 9462).
%  033  01/23/12  M.Baski     Updated TFSSBKT1 upper limits per DDTS 9475
%                             and added ACIS DPA thermal model parameters
%                             per DDTS 9486.  Also, changed TCYLAFT6
%                             planning limit from 96 to 99 degF, per DDTS
%                             9490.
%  034  02/27/12  M.Baski     Removed last remnants of the deprecated 
%                             TEPHIN thermal model (the dwell time matrix 
%                             report), per DDTS 9522.
%  035  02/29/12  M.Baski     Added PFTANK2T thermal model characteristics, 
%                             per DDTS 9529.
%  036  05/06/12  M.Baski     Added ACIS FP thermal model characteristics, 
%                             per DDTS 9600 and updated TEPHIN ref and
%                             yellow limits from 135 to 138 degF and from 
%                             140 to 144 degF per DDTS 9625.  Removed
%                             references to 3TRMTRAT (should have been 
%                             removed previously).
%  037  09/04/12  M.Baski     Updated TEPHIN ref limit from 138 to 141 deg
%                             and yellow limit from 144 to 147 deg per 
%                             DDTS 9723.
%  038  10/16/12  M.Baski     Added characteristic for Minus-Z model spec
%                             file as part of replacement of MATLAB model 
%                             calculation code with Python Xija version, 
%                             per DDTS 9784.
%  039  11/26/12  M.Baski     Updated TCYLAFT6 planning limit from 99 to 
%                             102 deg per DDTS 9818.
%  040  11/26/12  A.Arvai     Moved the PLINE constraint pitch bins 3 deg 
%                             forward in support of the IPS tank heater
%                             checkout (extra conservatism), per DDTS 9843.
%  041  12/11/12  M.Baski     Updated TCYLAFT6 Caution High Limit from 
%                             110F to 120F, TEPHIN Planning Limit from 
%                             141F to 144F, TEPHIN Caution High Limit from 
%                             147F to 150F, and removed (set it to -10000) 
%                             TEPHIN Warning High Limit, per DDTS 9840. 
%                             Also, added alternative PLINE pitch bin
%                             values for use during tank heater checkout
%                             activities, for DDTS 9843.
%  042  01/11/13  M.Baski     Added characteristic for PSMC model spec
%                             file and renamed some of the other PSMC
%                             characteristics as part of the replacement  
%                             of the MATLAB PSMC model with a Python Xija 
%                             version, per DDTS 9874.
%  043  04/01/13  M.Baski     Added characteristics for new Minus-YZ
%                             thermal model, for DDTS 9956.  Updated TEPHIN
%                             planning limit from 144 to 147 degF, and 
%                             caution high limit from 150 to 155 degF, per 
%                             DDTS 9937.
%  044  07/08/13  M.Baski     Updated TEPHIN ref limit from 147 to 151 degF
%                             and caution high limit from 155 to 158 degF, 
%                             per DDTS 10030.
%  045  07/09/13  M.Baski     Removed obsolete -Z model, per DDTS 10032.
%  046  09/09/13  M.Baski     Added characteristics for new ACA thermal 
%                             model, per DDTS 10087.
%  047  09/13/12  M.Baski     Updated TCYLAFT6 planning limit from 102 to 
%                             105 deg per DDTS 10097.
%  048  11/05/13  M.Baski     Updated TEPHIN ref limit from 151 to 154 degF
%                             and caution high limit from 158 to 161 degF, 
%                             per DDTS 10126.
%  049  11/14/13  M.Baski     Updated DPA planning limit from 31.5 to 
%                             33.0 degC per DDTS 10136.
%  050  02/24/14  M.Baski     Updated ACA planning limit from -15 to 
%                             -14 degC per DDTS 10217.
%  051  05/14/14  M.Baski     Added characteristics for new forward 
%                             bulkhead thermal model, per DDTS 10312.
%                             Updated DPA planning limit from 33.0 to 
%                             35.5 degC and the caution high limit from
%                             35.0 to 37.5 degC, per DDTS 10316.
%  052  05/27/14  M.Baski     Added Xija model stop time pad to insure  
%                             the models run out through the schedule
%                             end time and state changes at the end of the
%                             schedule are captured, per DDTS 10326.
%                             Removed TMZP_MY parameters, added TEPHIN_0
%                             parameters, and updated TEPHIN planning limit
%                             from 154 to 160 degF, per DDTS 10361.
%  053  03/16/15  M.Baski     Updated TCYLAFT6 planning limit from 105 to 
%                             108 degF per DDTS 10542.  Added parameters
%                             for new central cylinder thermal model and 
%                             removed -YZ thermal model per DDTS 10553.
%  054  04/14/15  M.Baski     Updated characteristics for new MUPS thruster 
%                             thermal models, per DDTS 10577.  Updated
%                             4RT700T limits per DDTS 10606.
%  055  08/30/15  M.Baski     Updated planning limit for OBA forward 
%                             bulkhead temperature from 80 to 82 degF, per 
%                             DDTS 10773.
%  056  11/11/15  M.Baski     Updated Xija model spec filenames to new 
%                             location (in local git clone) per DDTS 10780.
%  057  02/17/16  M.Baski     Added characteristics for new ACIS DEA 
%                             thermal model, per DDTS 10843.  Updated ACA
%                             planning limit from -14 to -13.5 degC per
%                             DDTS 10853.
%  058  06/15/16  M.Baski     Increased the ACA planning limit (AACCCDPT) 
%                             from -13.5 to -12.5 degC per DDTS 10945. 
%                             Increased the OBA forward bulkhead planning limit
%                             (4RT700T) from 82 to 84 degF per DDTS 10944.
%  059  10/17/16  M.Baski     Increased the ACA planning limit (AACCCDPT) 
%                             from -12.5 to -11.5 degC per DDTS 11069. 
%  060  12/08/16  M.Baski     Increased the TCYLAFT6 planning limit from
%                             108 to 113 degF per DDTS 11116.
%-------------------------------------


% Relative path to base directory containing Xija model spec files
xija_base_dir = fullfile('chandra_models','xija');

% globals needed:
std_field_map = containers.Map( ...
    {'planning_warning_high', 'planning_penalty_high', ...
    'odb_caution_high', 'odb_warning_high', 'planning_caution_low'}, ...
    {'reference_limit', 'penalty_limit', 'yellow_limit', 'red_limit', ...
     'low_limit'});

alt_field_map = containers.Map( ...
    {'odb_warning_high', 'odb_caution_high', ...
     'planning_warning_high', 'planning_warning_low'}, ...
    {'red_limit', 'yellow_limit', 'yellow_limit', 'reference_limit'});

%---------- MUPS thruster thermal model parameters ----------%

mups_field_map = containers.Map( ...
    {'odb_warning_high', 'odb_caution_high', ...
     'planning_warning_high', 'planning_warning_low'}, ...
    {'red_limit', 'yellow_limit', 'reference_limit', 'reference_limit'});

Thermal.mups_pm1thv2t_model_spec_file = ...
    fullfile(xija_base_dir,'mups_valve','pm1thv2t_spec.json');

%MUPS 1B (PM1THV2T) parameters (-10000 for ref means don't plot the line)
Thermal.msid_pm1thv2t.default_initial_temperature = 140;
Thermal.msid_pm1thv2t.msid = 'PM1THV2T';
% default limit values
Thermal.msid_pm1thv2t.yellow_limit = -10000;

% specific values for limit:
model_spec_field = 'mups_pm1thv2t_model_spec_file';
limit_sub_field = 'pm1thv2t';
msid_field = 'msid_pm1thv2t';
desired_unit = 'degF';

% retrieve limits stored in the model spec file
Thermal = set_model_limits(Thermal, model_spec_field, limit_sub_field, ...
                           msid_field, desired_unit, mups_field_map);

% PM1THV2T_0 is not a real MSID, it is a component of the MUPS 1B
% thruster thermal model that needs to be initialized
Thermal.msid_pm1thv2t_0.msid = 'PM1THV2T_0';
Thermal.msid_pm1thv2t_0.default_initial_temperature = 140; % degF

Thermal.mups_pm2thv1t_model_spec_file = ...
    fullfile(xija_base_dir,'mups_valve','pm2thv1t_spec_matlab.json');

%MUPS 2A (PM2THV1T) parameters (-10000 for ref means don't plot the line)
Thermal.msid_pm2thv1t.default_initial_temperature = 140;
Thermal.msid_pm2thv1t.msid = 'PM2THV1T';
% default limit values
Thermal.msid_pm2thv1t.yellow_limit = -10000;

% specific values for limit:
model_spec_field = 'mups_pm2thv1t_model_spec_file';
limit_sub_field = 'pm2thv1t';
msid_field = 'msid_pm2thv1t';
desired_unit = 'degF';

% retrieve limits stored in the model spec file
Thermal = set_model_limits(Thermal, model_spec_field, limit_sub_field, ...
                           msid_field, desired_unit, mups_field_map);

% PM2THV1T_0 is not a real MSID, it is a component of the MUPS 2A 
% thruster thermal model that needs to be initialized
Thermal.msid_pm2thv1t_0.msid = 'PM2THV1T_0';
Thermal.msid_pm2thv1t_0.default_initial_temperature = 140; % degF
Thermal.msid_pm2thv1t_1.msid = 'PM2THV1T_1';
Thermal.msid_pm2thv1t_1.default_initial_temperature = 140; % degF

% auto block thrusters above this temperature
Thermal.mups_block_thruster_limit = 195; % degF

%---------- Sim Table parameters ----------%

%Initial default 3TSCPOS value 
Thermal.msid_3tscpos.default_initial_position = 94000;

% Model spec file
Thermal.pline03t_model_spec_file = ...
    fullfile(xija_base_dir,'pline','pline03t_model_spec.json');

%PLINE03T parameters (-10000 for ref means don't plot the line)
Thermal.msid_pline03t.msid = 'PLINE03T';
Thermal.msid_pline03t.default_initial_temperature = 120; % degF
Thermal.msid_pline03t.red_limit = -10000; % degF

% specific values for limit:
model_spec_field = 'pline03t_model_spec_file';
limit_sub_field = 'pline03t';
msid_field = 'msid_pline03t';
desired_unit = 'degF';

% retrieve limits stored in the model spec file
Thermal = set_model_limits(Thermal, model_spec_field, limit_sub_field, ...
                           msid_field, desired_unit, alt_field_map);

Thermal.msid_pline03t.limit_dir = {'gt','gt','lt','gt'};
% PLINE03T_0 is not a real MSID, it is a pseudo node component of the
% PLINE0xT thermal model that needs to be initialized
Thermal.msid_pline03t_0.msid = 'PLINE03T_0';
Thermal.msid_pline03t_0.default_initial_temperature = 85; % degF

% Model spec file
Thermal.pline04t_model_spec_file = ...
    fullfile(xija_base_dir, 'pline', 'pline04t_model_spec.json');

%PLINE04T parameters (-10000 for ref means don't plot the line)
Thermal.msid_pline04t.msid = 'PLINE04T';
Thermal.msid_pline04t.default_initial_temperature = 100; % degF
% default limit values
Thermal.msid_pline04t.red_limit = -10000; % degF

% specific values for limit:
model_spec_field = 'pline04t_model_spec_file';
limit_sub_field = 'pline04t';
msid_field = 'msid_pline04t';
desired_unit = 'degF';

% retrieve limits stored in the model spec file
Thermal = set_model_limits(Thermal, model_spec_field, limit_sub_field, ...
                           msid_field, desired_unit, alt_field_map);

% lower limit for reference limit
Thermal.msid_pline04t.limit_dir = {'gt','gt','lt','gt'};
% PLINE04T_0 is not a real MSID, it is a pseudo node component of the
% PLINE0xT thermal model that needs to be initialized
Thermal.msid_pline04t_0.msid = 'PLINE04T_0';
Thermal.msid_pline04t_0.default_initial_temperature = 50; % degF


%---------- Central Cylinder model parameters ----------%

Thermal.central_cylinder_model_spec_file = ...
    fullfile(xija_base_dir,'tcylaft6','tcylaft6_spec.json');

%TCYLAFT6 parameters (-10000 for ref means don't plot the line)
Thermal.msid_tcylaft6.msid = 'TCYLAFT6';
Thermal.msid_tcylaft6.default_initial_temperature = 65; % degF
% default limit values
Thermal.msid_tcylaft6.red_limit = -10000;
Thermal.msid_tcylaft6.reference_limit = -10000; % degF

% specific values for limit:
model_spec_field = 'central_cylinder_model_spec_file';
limit_sub_field = 'tcylaft6';
msid_field = 'msid_tcylaft6';
desired_unit = 'degF';

% retrieve limits stored in the model spec file
Thermal = set_model_limits(Thermal, model_spec_field, limit_sub_field, ...
                           msid_field, desired_unit, alt_field_map);

% CC0 is not a real MSID, it is a component of the central
% cylinder thermal model that needs to be initialized
Thermal.msid_cc0.msid = 'CC0';
Thermal.msid_cc0.default_initial_temperature = 60; % degF

%---------- HRC CEA model parameters ----------%

% Model spec file
Thermal.hrc_cea_model_spec_file = ...
    fullfile(xija_base_dir,'hrc','cea_spec.json');

%1DPAMZT parameters (-10000 for ref means don't plot the line)
Thermal.msid_2ceahvpt.msid = '2CEAHVPT';
Thermal.msid_2ceahvpt.default_initial_temperature = 5.9; % degC
Thermal.msid_2ceahvpt.red_limit = -10000; % degF

% specific values for limit:
model_spec_field = 'hrc_cea_model_spec_file';
limit_sub_field = '2ceahvpt';
msid_field = 'msid_2ceahvpt';
desired_unit = 'degC';

% retrieve limits stored in the model spec file
Thermal = set_model_limits(Thermal, model_spec_field, limit_sub_field, ...
                           msid_field, desired_unit, std_field_map);

% CEA0 and CEA1 are not a real MSIDs, they are pseudo node components of
% the CEA thermal model that need to be initialized
Thermal.msid_cea0.msid = 'CEA0';
Thermal.msid_cea0.default_initial_temperature = 6.2; % degC
Thermal.msid_cea1.msid = 'CEA1';
Thermal.msid_cea1.default_initial_temperature = -3.4; % degC

%---------- ACIS DPA model parameters ----------%

% Model spec file
Thermal.acis_dpa_model_spec_file = ...
    fullfile(xija_base_dir,'dpa','dpa_spec.json');

%1DPAMZT parameters (-10000 for ref means don't plot the line)
Thermal.msid_1dpamzt.msid = '1DPAMZT';
Thermal.msid_1dpamzt.default_initial_temperature = 20; % degC

% specific values for limit:
model_spec_field = 'acis_dpa_model_spec_file';
limit_sub_field = '1dpamzt';
msid_field = 'msid_1dpamzt';
desired_unit = 'degC';

% retrieve limits stored in the model spec file
Thermal = set_model_limits(Thermal, model_spec_field, limit_sub_field, ...
                           msid_field, desired_unit, std_field_map);

% DPA is not a real MSID, it is a pseudo node component of the DPA
% thermal model that needs to be initialized
Thermal.msid_dpa0.msid = 'DPA0';
Thermal.msid_dpa0.default_initial_temperature = 22; % degC

%---------- ACIS DEA model parameters ----------%

% Model spec file
Thermal.acis_dea_model_spec_file = ...
    fullfile(xija_base_dir,'dea','dea_spec.json');

%1DEAMZT parameters (-10000 for ref means don't plot the line)
Thermal.msid_1deamzt.msid = '1DEAMZT';
Thermal.msid_1deamzt.default_initial_temperature = 20; % degC

% specific values for limit:
model_spec_field = 'acis_dea_model_spec_file';
limit_sub_field = '1deamzt';
msid_field = 'msid_1deamzt';
desired_unit = 'degC';

% retrieve limits stored in the model spec file
Thermal = set_model_limits(Thermal, model_spec_field, limit_sub_field, ...
                           msid_field, desired_unit, std_field_map);

%dea0 is not a real MSID, it is a pseudo node component of the
%1deamzt thermal model that needs to be initialized
Thermal.msid_dea0.msid = 'DEA0';
Thermal.msid_dea0.default_initial_temperature = 22; %degC

%---------- PFTANK2T model parameters ----------%

% Model spec file
Thermal.pftank2t_model_spec_file = ...
    fullfile(xija_base_dir,'pftank2t','pftank2t_spec.json');

%PFTANK2T parameters (-10000 for ref means don't plot the line)
Thermal.msid_pftank2t.msid = 'PFTANK2T';
Thermal.msid_pftank2t.default_initial_temperature = 75; % degF

% specific values for limit:
model_spec_field = 'pftank2t_model_spec_file';
limit_sub_field = 'pftank2t';
msid_field = 'msid_pftank2t';
desired_unit = 'degF';

% retrieve limits stored in the model spec file
Thermal = set_model_limits(Thermal, model_spec_field, limit_sub_field, ...
                           msid_field, desired_unit, std_field_map);

% PF0TANK2T is not a real MSID, it is a component of the PFTANK2T thermal
% model that needs to be initialized
Thermal.msid_pf0tank2t.msid = 'PF0TANK2T';
Thermal.msid_pf0tank2t.default_initial_temperature = 75; % degF

% Conversion coefficients from temperature to approx tank pressure
Thermal.pftank2t_to_pressure.m = 0.52897657;
Thermal.pftank2t_to_pressure.b = 246.17715;

% Tank pressure limits
Thermal.msid_pftankip.yellow_limit    = 307; % PSI
Thermal.msid_pftankip.red_limit       = 330; % PSI
Thermal.msid_pftankip.reference_limit = -10000;

%---------- ACIS Focal Plane (FP) model parameters ----------%


% Model spec file
Thermal.acis_fp_model_spec_file = ...
    fullfile(xija_base_dir,'acisfp','acisfp_spec.json');

%FPTEMP parameters (-10000 for ref means don't plot the line)

% A description of the different limit fields:
% acis_in_use - when ACIS is in use but the specific instrument is not
%               known and no other limits apply
% acis_i_in_use - when ACIS-I is in use and no other limits apply
% acis_s_in_use - when ACIS-S is in use and no other limits apply
% during_cti - during CTIs
% any_other_time - for any other times
acis_field_map = containers.Map( ...
    {'planning_data_quality_high_acisi', ...
     'planning_data_quality_high_aciss', ...
     'planning_data_quality_high_cold_ecs', ...
     'planning_data_quality_high_aciss_hot', ...
     'planning_warning_high', ...
     'safety_caution_high'}, ...
    {'acis_i_in_use', 'acis_s_in_use', 'during_cti', ...
     'acis_s_in_use_hot', 'any_other_time', 'safety_caution_high'});

% specific values for limit:
model_spec_field = 'acis_fp_model_spec_file';
limit_sub_field = 'fptemp';
msid_field = 'msid_fptemp';
desired_unit = 'degC';

% retrieve limits stored in the model spec file
tmp_Thermal = set_model_limits(Thermal, model_spec_field, limit_sub_field, ...
                           msid_field, desired_unit, acis_field_map);
% copy the acis_i_in_use limit to the acis_in_use limit
tmp_Thermal.msid_fptemp.acis_in_use = ...
    tmp_Thermal.msid_fptemp.acis_i_in_use;
% copy over the limit fields into the limits field of the real structure.
% This is done because the ACIS FP limit data lives in a 'limits' sub
% field, instead of being in the top level structure.
Thermal.msid_fptemp.limits = tmp_Thermal.msid_fptemp;

Thermal.msid_fptemp.msid = 'FPTEMP';
Thermal.msid_fptemp.default_initial_temperature = -119; % degC

% 1CBAT and SIM_PX are not real MSIDs, they are components of the ACIS FP
% thermal model that needs to be initialized
Thermal.msid_1cbat.msid = '1CBAT';
Thermal.msid_1cbat.default_initial_temperature = -55; % degC
Thermal.msid_sim_pxt.msid = 'SIM_PX';
Thermal.msid_sim_px.default_initial_temperature = -110; % degC

%---------- Aspect Camera (ACA) model parameters ----------%

% Model spec file
Thermal.aca_model_spec_file = ...
    fullfile(xija_base_dir,'aca','aca_spec.json');

%AACCCDPT parameters (-10000 for ref means don't plot the line)
% AACCCDPT_C is AACCCDPT in degC (standard eng units are degF)
Thermal.msid_aacccdpt_c.msid = 'AACCCDPT_C';
Thermal.msid_aacccdpt_c.default_initial_temperature = -20; % degC
% default limit values
Thermal.msid_aacccdpt_c.yellow_limit = -10000; % degC
Thermal.msid_aacccdpt_c.red_limit = -10000; % degC

% specific values for limit:
model_spec_field = 'aca_model_spec_file';
limit_sub_field = 'aacccdpt';
msid_field = 'msid_aacccdpt_c';
desired_unit = 'degC';

% retrieve limits stored in the model spec file
Thermal = set_model_limits(Thermal, model_spec_field, limit_sub_field, ...
                           msid_field, desired_unit, std_field_map);

% ACA0 is not a real MSID, it is a component of the ACA thermal
% model that needs to be initialized
Thermal.msid_aca0.msid = 'ACA0';
Thermal.msid_aca0.default_initial_temperature = -20; % degC


%---------- Forward Bulkhead model parameters ----------%

% Model spec file
Thermal.fwd_bulkhead_model_spec_file = ...
    fullfile(xija_base_dir,'fwdblkhd','4rt700t_spec.json');

% 4RT700T parameters (-10000 for ref means don't plot the line)
Thermal.msid_4rt700t.msid = '4RT700T';
Thermal.msid_4rt700t.default_initial_temperature = 70; % degF
Thermal.msid_4rt700t.limit_dir = {'gt','gt','gt','lt'};

% specific values for limit:
model_spec_field = 'fwd_bulkhead_model_spec_file';
limit_sub_field = '4rt700t';
msid_field = 'msid_4rt700t';
desired_unit = 'degF';

fwdblkhd_field_map = containers.Map( ...
    {'planning_warning_high', 'odb_caution_high', 'odb_warning_high', ...
    'planning_warning_low'}, ...
    {'reference_limit', 'yellow_limit', 'red_limit', 'low_limit'});

Thermal = set_model_limits(Thermal, model_spec_field, limit_sub_field, ...
                           msid_field, desired_unit, fwdblkhd_field_map);
                       
% OBA0 is not a real MSID, it is a component of the forward bulkhead
% thermal model that needs to be initialized
Thermal.msid_oba0.msid = 'OBA0';
Thermal.msid_oba0.default_initial_temperature = 70; % degF

%---------- PSMC model parameters ----------%

% Model spec file
Thermal.psmc_model_spec_file = ...
    fullfile(xija_base_dir,'psmc','psmc_spec.json');

% 1PDEAAT parameters
Thermal.msid_1pdeaat.msid = '1PDEAAT';
Thermal.msid_1pdeaat.default_initial_temperature = 40; % degC

% specific values for limit:
model_spec_field = 'psmc_model_spec_file';
limit_sub_field = '1pdeaat';
msid_field = 'msid_1pdeaat';
desired_unit = 'degC';

Thermal = set_model_limits(Thermal, model_spec_field, limit_sub_field, ...
                           msid_field, desired_unit, std_field_map);

% PIN1AT psuedo MSID parameters
Thermal.msid_pin1at.msid = 'PIN1AT';
Thermal.msid_pin1at.default_initial_temperature = 35; % degC
% default limit values
Thermal.msid_pin1at.yellow_limit = -10000; % degC
Thermal.msid_pin1at.red_limit = -10000; % degC
Thermal.msid_pin1at.reference_limit = -10000;

%---------- General Xija thermal model parameters ----------%

% Padding for the Xija thermal model stop time so the last time output 
% by the xija model is closer to the actual stop time, and that last
% minute state changes are captured
Thermal.xija_model_stop_pad_time = 15*60; % seconds

function Thermal = set_model_limits(Thermal, model_spec_field, ...
        limit_sub_field, msid_field, desired_unit, field_map)
    % set the limit values for the given model based on the values in the spec

    % specific values for limit:
    % model_spec_field = "aca_model_spec_file"
    % limit_sub_field = "aacccdpt"
    % limit_fields = {'planning_warning_high', 'planning_penalty_high'};
    % desired_unit = 'degC'
    
    % make sure the sub field is a valid field name (might start with a
    % number, which is not valid.
    limit_sub_field = matlab.lang.makeValidName(limit_sub_field);
    model_spec = model_Thermal_Xija.get_spec(Thermal.(model_spec_field));
    if(issubfield(model_spec, ['limits.', limit_sub_field]))
        spec_limits = model_spec.limits.(limit_sub_field);
        limit_fields = fieldnames(spec_limits);
        limit_fields(strcmp(limit_fields, 'unit')) = [];
        for idx = 1:numel(limit_fields)
            limit_field = limit_fields{idx};
            % if the limit in the spec file isn't mapped to any MATLAB
            % specific characteristic value, skip it.
            if(~field_map.isKey(limit_field))
                continue
            end
            % assume values are stored in the expected units
            local_limit = spec_limits.(limit_field);
            % convert units if necessary
            if(~strcmp(spec_limits.unit, desired_unit))
                if(strcmpi(spec_limits.unit, 'degF'))
                    local_limit = (local_limit - 32) * 5 / 9;
                elseif(strcmpi(spec_limits.unit, 'degC'))
                    local_limit = (local_limit * 9 / 5) + 32;
                else
                    warndlg(sprintf( [ ...
                        'Unexpected Limit Units for %s (%s)\n', ...
                        'using raw values...'], ...
                        upper(limit_sub_field), spec_limits.unit), ...
                        'Unexpected Unit')
                end
            end
            Thermal.(msid_field).(field_map(limit_field)) = local_limit;
        end
    end
end
end