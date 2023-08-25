function general = characteristics_general

%  characteristics_general:     Parameters for solar torque, speed of light,
%  planetary and XRay target values, and other generally useful values.

%-------------------------------------
% Rev#    Date       Who     Purpose
% ----  --------  ---------  ---------
%  000  07/01/02  P.Goulart  Original
%  001            S.Bucher   Update Earth constraint for consistency with updated CARD
%  002  10/23/07  S.Bucher   Modify Jupiter, Venus, Saturn stay out region
%                              to 2 deg due to high background anomaly &
%                              sun to 46.2 for consistency w/ SPM constraint
%  003  02/29/08  S.Bucher   Modify Mars stay out to 2 deg
%  004  10/09/09  J.Connelly Added Celsius to/from Kelvin constant
%  005  09/18/11  M.Baski    Removed off-nominal roll limit per DDTS 9386.
%  006  10/18/12  M.Baski    Updated SPM check parameters for consistency
%                            with recent FSS FOV update, per DDTS 9788.
%  007  03/10/13  M.Baski    Updated SPM check parameters per DDTS 9930.
%  008  04/04/13  M.Baski    Added conversion from ft-lb-sec to kg-m2/sec
%                            as part of the code cleanup for DDTS 9956.
%  009  04/30/13  M.Baski    Reverted SPM check parameters per DDTS 9976.
%  010  05/31/14  M.Baski    Added moment of inertia unit conversions for 
%                            DDTS 10184.
%-------------------------------------



%Radius of the Earth (km).  This value also exists in 
%the SSObjects part of the characteristics
general.earthradius = 6378.166;

%Solar pressure table.  Pitch and Roll are in degrees, and
%define the dimensions of the lookup table.
%The Torque table is a MxNx3 matrix of torque in kg-m/s/s,
%with the third dimension giving different values for X,
%Y, and Z torques in the body frame
general.solarpressure.pitch = 45:180;
general.solarpressure.roll = -30:30;
fname = 'solarPressureTorqueTable';         %table is huge, so load it from a file
general.solarpressure.torque = getfield(load(fname),fname); 

%Astronomical Unit (km)
general.AU = 149597870.691;

%AXAF Inertia Matrix (kg-m^2)
general.I = [...
          9106.39232430812          57.6724056616694         -828.570546785547
          57.6724056616694          49664.4049251704          203.011541380138
         -828.570546785547          203.011541380138          52838.4338546339];
    
%XRAY source names and locations.  The locations are a set of 2xn unit
%vectors in RA and DEC.  The limbConstraint is the stay-out region for
%each individual target in degrees.
xray_source_list = fullfile(get_ska_data_dir(), 'pcad', ...
    'bright_sources.csv');
if(exist(xray_source_list, 'file') == 2)
    % supress a warning about Column Headers being modified
    [target_names, RA, DEC] = parse_bright_xray_list(xray_source_list);
    general.xray.targets(1,:)   = RA;
    general.xray.targets(2,:)   = DEC;
    general.xray.names          = target_names;
else
    general.xray.targets(1,:)   = [244.97945, 236.78449, 274.84014, 288.79815, 270.29055, 256.43538, 299.59032, 230.17022, 326.17148, 266.98332];
    general.xray.targets(2,:)   = [-15.64028, -47.66952, -25.40718, 10.94581, -25.07892, -36.42307, 35.20161, -57.16669, 38.32141, -26.56357];
    general.xray.names          = {'Sco X-1', '4U 1543-475', 'V4641 Sgr', 'GRS 1915+105', 'GX 5-1', 'GX 349+2', 'Cyg X-1', 'Cir X-1', 'Cyg X-2', 'GX 3+1'};
end
general.xray.limbConstraint = 1.5 * ones(1, numel(general.xray.names));
general.xray.limbConstraint_ACIS = 35/60; % 35 arcmin

% Pitch Reference Limit for Pitch Plot
general.pitch.reference_limit = 178;

%Sun Position Monitor Definition.  Units are deg.  The table
%is a 2xn set of points defining the OFLS sun position monitor
%constraint.  First column is pitch, second column, roll.  Only
%one side of the table is defined b/c, as implemented, the SPM
%check assumes that the SPM is symmetric about the X-Z plane.
%The table is written column-wise here for easy editing, and
%then transposed.
general.SPM = [...
    46      0
    46.2    0
    46.2    1.269
    46.4    1.269
    46.4    2.052
    46.6    2.052
    46.6    2.635
    46.8    2.635
    46.8    3.111
    47      3.111
    47      3.517
    47.2    3.517
    47.2    3.942
    47.5    3.942
    47.5    4.501
    48      4.501
    48      5.192
    48.5    5.192
    48.5    5.771
    49      5.771
    49      6.268
    49.5    6.268
    49.5    6.726
    50      6.726
    50      7.142
    55      7.142
    55      10.043
    60      10.043
    60      11.753
    65      11.753
    65      12.894
    70      12.894
    70      13.659
    75      13.659
    75      14.182
    80      14.182
    80      14.523
    85      14.523
    85      19.899
    125     19.899
    125     17
    134.9     17
    134.9     13.979
    137.08  13.979
    137.08  14.516
    140     14.516
    140     15.339
    145     15.339
    145     17.088
    150     17.088
    150     19.425
    151.02     19.425
    151.02     19.999
    157     19.999
    157     19.999
    160     19.999
    160     19.999
    163     19.999
    163     19.999
    166     19.999
    166     19.999
    170     19.999
    170     19.999
    180     19.999]';

spm_dir = fullfile(fileparts(mfilename('fullpath')));
general.SPM_OFFSET = readmatrix(fullfile(spm_dir, ...
    'Pitch_Roll_230413.csv'))';   

general.SPM_HRMA = [ ...
    86, 4.958
    87, 5.113
    88, 5.377
    89, 5.756
    90, 6.264
    91, 6.927
    92, 7.787
    93, 8.930
    93.71, 10.018]';

general.SPM_SA = [ ...
    45, 14.215
    46, 13.969
    47, 13.735
    48, 13.513
    49, 13.302
    50, 13.101
    51, 12.911
    52, 12.730
    53, 12.558
    54, 12.394
    55, 12.238
    56, 12.090
    57, 11.949
    58, 11.815
    59, 11.688
    60, 11.566
    61, 11.451
    62, 11.342
    63, 11.238
    64, 11.139
    65, 11.046
    66, 10.957
    67, 10.873
    68, 10.794
    69, 10.719
    70, 10.649
    71, 10.582
    72, 10.520
    73, 10.461
    74, 10.407
    75, 10.356
    76, 10.309
    77, 10.265
    78, 10.225
    79, 10.189
    80, 10.155
    81, 10.125
    82, 10.099
    83, 10.075
    84, 10.055
    85, 10.038
    86, 10.024
    87, 10.013
    88, 10.006
    89, 10.001
    90, 10.000
    91, 10.001
    92, 10.006
    93, 10.013
    94, 10.024
    95, 10.038
    96, 10.055
    97, 10.075
    98, 10.099
    99, 10.125
    100, 10.155
    101, 10.189
    102, 10.225
    103, 10.265
    104, 10.309
    105, 10.356
    106, 10.407
    107, 10.461
    108, 10.520
    109, 10.582
    110, 10.649
    111, 10.719
    112, 10.794
    113, 10.873
    114, 10.957
    115, 11.046
    116, 11.139
    117, 11.238
    118, 11.342
    119, 11.451
    120, 11.566
    121, 11.688
    122, 11.815
    123, 11.949
    124, 12.090
    125, 12.238
    126, 12.394
    127, 12.558
    128, 12.730
    129, 12.911
    130, 13.101
    131, 13.302
    132, 13.513
    133, 13.735
    134, 13.969
    135, 14.215
    136, 14.476
    137, 14.750
    138, 15.041
    139, 15.348
    140, 15.673
    141, 16.017
    142, 16.382
    143, 16.770
    144, 17.183
    145, 17.622
    146, 18.091
    147, 18.592
    148, 19.128
    149, 19.703
    150, 20.321]';

%Values that define the onboard SPM monitor,
%as determined by flight sofware
general.onboardSPM.KP_XEllipse = [1, 0.69466];
general.onboardSPM.KP_YEllipse = [0.342, 0.2588];
general.onboardSPM.KP_Region_Bound = 0.0872;

% Values related to a 10 degree offset from the onboard ellipse
general.onboardSPM.KP_XEllipse_offset = [1, 0.55919];
general.onboardSPM.KP_YEllipse_offset = [0.342, 0.08716];

% SPM roll limit values
general.SPMPerigeeAlt = 25000; % km radius threshold to apply restriction
general.SPMPerigeeLim = 100; % roll limit(deg) under radius threshold
general.SPMPerigeePitch = 124.9; % pitch(deg) above which perigee lim applies

% SPM disable after eclipse timing
general.SPM_disable_after_eclipse = 20 * 60; % 20 minutes (in seconds)

% SCS-98 threshold pitch
general.SCS98Pitch = 45;

% pads from the on-board SPM ellipse that define the scheduling constraint
general.SPMPitchPad=0.5; %inside ellipse in pitch (deg)
general.SPMPosRollPad=1.25; % inside ellipse for positive roll values (deg)
general.SPMNegRollPad=1.25;% inside ellipse for negative roll values (deg)
general.SPMPadCutOffAngle=180; % only pad for pitch angles below (deg)

%Names, Radii (km), and boresight constraint values (deg) for 
%objects in the solar system.  
general.SSObjects.names          = {'Mercury', 'Venus','Earth',   'Mars','Jupiter','Saturn','Uranus','Neptune','Pluto','Moon','Sun'};
general.SSObjects.sizes          = [ 2440        6052   6378.166   3390   69911     58232    25362    24624     1151    1738   696000 ];
general.SSObjects.limbConstraint = [ 1           2      10         2      2         2        1        1         1       6      46.2 ];

%Default monitor window coordinates
general.mon.angleY = 70 * 4.8481368e-006; % center of telescope boresight
general.mon.angleZ = 56 * 4.8481368e-006;

%The speed of light (km/sec)
general.speedOfLight = 299792.458;

% Celsius/Kelvin
general.CtoK = 273.15;
general.KtoC = -general.CtoK;

% Fahrenheit/Rankine
general.FtoR = 460.67;
general.RtoF = -general.FtoR;

% N/Lbf
general.NtoLbf = 0.224809;
general.lbfToN = 1/general.NtoLbf;

% m/ft
general.mToFt = 3.28084;
general.ftToM = 1/general.mToFt;

% Momentum unit conversions
general.ftlbsecToNms = 1.355818;
general.NmsToftlbsec = 1/general.ftlbsecToNms;

% Moment of inertia units conversions
general.kgm2Toslugft2 = 0.737562149;
general.slugft2Tokgm2 = 1/general.kgm2Toslugft2;

% Density of hydrazine [lbm/in^3]
general.rhoN2H4 = 0.036511;

% Specific gas constant for helium [in-lbf/lbm-R]  
general.RHe = 4632;

% Momentum Dumps near Acquisitions (which are near Perigee)
general.perigeeDumpKeepoutThreshold = 2 * 3600; % 2 hours
general.perigeeAcqKeepoutThreshold = 10.5 * 60; % 10.5 minutes

general.HighIR_PrePerigee = -1800;
general.HighIR_PostPerigee = 1200;

general.HRC_Allowable_On_Duration = 15000; % seconds
general.HRC_Minimum_Off_Duration = 30000; % seconds
