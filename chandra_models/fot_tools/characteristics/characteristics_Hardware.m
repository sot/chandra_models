function Hardware = characteristics_Hardware

%  characteristics_Hardware:    Values for IRUs, FSS, OBC, Reaction Wheels,
%  and MUPS.

%-------------------------------------
% Rev#    Date       Who     Purpose
% ----  --------  ---------  ---------
%  000  07/01/02  P.Goulart  Original
%  001  01/23/03  S.Bucher   Changed RW low spped warning to 500 rpm
%  002  07/10/03  S.Bucher   Edited IRU parametres for IRU-2 primary
%  003  01/06/04  S.Bucher   Changed max momentum limit to 26.0
%  004  07/18/05  S.Bucher   Updated IRU-2 M-matrix
%  005  12/20/06  S.Bucher   Updated IRU-2 M1 and M@ matrix for IRU cal uplink
%  006  05/25/07  S.Bucher   Added OBC unloading k-constants to allow
%                            mimicing FSW unloading logic
%  007  04/28/10  A.Arvai    Added default timeout value for momentum dumps
%  008  01/27/11  M.Baski    Updated IRU-2 M1 and M2 matrix for IRU cal
%                            uplink, per DDTS 9229.
%  009  06/01/11  A.Arvai    Added MUPS alignment, thrust, and command
%                            quantization
%  010  07/01/11  M.Baski    Added parameters representing the physical
%                            size and geometry of Chandra for meteor 
%                            probability of impact calculations (DDTS
%                            9148).
%  011  07/06/11  A.Arvai    Updated thruster torque matrix with 2011
%                            calibration (DDTS 9341)
%  012  07/06/11  M.Baski    Updated IRU-2 M1 and M2 matrix for IRU cal
%                            uplink, per DDTS 9345
%  013  03/01/12  M.Baski    Updated IRU-2 M1 and M2 matrix for IRU cal
%                            uplink, per DDTS 9531.
%  014  08/29/12  M.Baski    Updated FSS field of view angle, per
%                            DDTS 9674.
%  015  01/14/13  A.Arvai    Replaced MUPS torques with offset from CG to 
%                            eliminate redundancy with thrust per DDTS 9867.
%  016  01/15/13  A.Arvai    Replaced MUPS thrust with fuel remaining and other
%                            MUPS tank constants per DDTS 9872.
%  017  01/25/13  A.Arvai    Increased total system momentum planning limit per 
%                            DDTS 9885.
%  018  03/10/13  M.Baski    Updated FSS FOV per DDTS 9930.
%  019  04/04/13  M.Baski    Changed momentumThreshold units to ft-lb-sec 
%                            as part of the code cleanup for DDTS 9956.
%                            Updated IRU-2 M1 and M2 matrix for IRU cal
%                            uplink, per DDTS 9961.
%  020  04/30/13  M.Baski    Reverted FSS FOV per DDTS 9976.
%  021  05/30/14  M.Baski    Added CPE yaw bias value and various normal
%                            sun mode control law algorithm constants for 
%                            DDTS 10184.  Reduced total system momentum 
%                            planning limit from 29 to 28 ft-lb-sec per 
%                            DDTS 10362.
%  022  05/14/15  M.Baski    Updated MUPS fuel mass remaining from 43.5 to 
%                            41.3 lbm per DDTS 10546 and TempDurMatrix per 
%                            DDTS 10609.
%  023  03/06/16  M.Baski    Updated nsm_yaw_bias and updated CSS 
%                            characteristics for DDTS 10858.
%  024  06/15/16  M.Baski    Raised the total system momentum planning limit
%                            from 28 to 29 ft-lb-sec for DDTS 10943. Updated 
%                            MUPS fuel mass remaining from 41.3 to 40.02 lbm
%                            per DDTS 10959.
%  022  05/14/15  S.Blanch   Updated MUPS fuel mass remaining from 40.02 to 
%                            39.0 lbm per DDTS 11426.
%  026  11/10/20  S.Blanch   Updated Iru.F1,G1,M1, and U1 for return to IRU-2
%-------------------------------------

%Reaction wheel moments of inertia (metric)
Hardware.Rwa.Irw = diag(ones(6,1)*0.107895);

%Reaction unit orientation vectors 
Hardware.Rwa.Arw = ...
[0.5            0.5          0.5             0.5            0.5          0.5
 0.75           0           -0.75           -0.75           0            0.75
 sqrt(3/16)     sqrt(3)/2    sqrt(3/16)     -sqrt(3/16)    -sqrt(3)/2   -sqrt(3/16)];

         
%Reaction wheel bias speed (RPM).  This is a scalar, so bias must be
%the same for each wheel as currently implemented.
Hardware.Rwa.biasrpm = [2050   % Normal (OBC control)
                           0]; % Safe mode (CPE control)

%Reaction wheel bias sign.  Determines sign of biasrpm%
Hardware.Rwa.biasdist = [1 -1  1 -1  1 -1   % Normal (OBC control)
                         1 -1  1 -1  1 -1]; % Safe mode (CPE control)

%These are the maneuver parameters.  The first set is for normal 
%parametere, the second for Transfer orbit maneuvers, and the 
%last is for RCS maneuvers
Hardware.Rwa.manvr.delta = [60 60 0.001];
Hardware.Rwa.manvr.alpha = [2.18166e-006 2.83616e-006 0.000349066];
Hardware.Rwa.manvr.omega = [0.001309 0.0020944 0.00698132];

% Typical CPE Normal Sun attitude yaw bias
Hardware.Cpe.control.nsm_yaw_bias = 0.0255*pi/180; % rad/sec

% CPE control law parameters
Hardware.Cpe.control.sun_point_ang = 30; % deg
Hardware.Cpe.control.sa_ang_thresh = 0.001;
Hardware.Cpe.control.sun_acq = ...
    struct('angle_gain',      [  2.0716,    13.2212,    13.7436],...
           'angle_lim',       [  0.1745,     0.1745,     0.1745],...
           'int_gain',        [  0.0,        0.0,        0.0   ],...
           'int_lim',         [  1.0E6,      1.0E6,      1.0E6 ],...
           'int_rate_err_lim',[  1.0E6,      1.0E6,      1.0E6 ],...
           'rate_gain',       [207.16,    1322.12,    1374.36  ],...
           'rate_lim',        [  1.0E6,      1.0E6,      1.0E6 ],...
           'torq_deadzone',   [  0.0,        0.0,        0.0   ],...
           'torq_lim',        [  0.25,       0.25,       0.25  ],...
           'bending_filter',struct(...
             'coeff',{[1.23E-3, 2.46E-3, 1.23E-3, 0.0, 0.0, 0.0, 0.0],...
                      [1.23E-3, 2.46E-3, 1.23E-3, 0.0, 0.0, 0.0, 0.0],...
                      [1.23E-3, 2.46E-3, 1.23E-3, 0.0, 0.0, 0.0, 0.0]},...
             'coeff_p',{[-1.91,  9.18E-1, 0.0,     0.0, 0.0, 0.0],...
                        [-1.91,  9.18E-1, 0.0,     0.0, 0.0, 0.0],...
                        [-1.91,  9.18E-1, 0.0,     0.0, 0.0, 0.0]},...
             'order',{2, 2, 2}));
Hardware.Cpe.control.sun_point = ...
    struct('angle_gain',      [  2.0716,    13.2212,    13.7436],...
           'angle_lim',       [  6.9813E-2,  3.0543E-2,  1.7453E-2],...
           'int_gain',        [  0.0,        0.0,        0.0   ],...
           'int_lim',         [  1.0E6,      1.0E6,      1.0E6 ],...
           'int_rate_err_lim',[  1.0E6,      1.0E6,      1.0E6 ],...
           'rate_gain',       [207.16,    1322.12,    1374.36  ],...
           'rate_lim',        [  1.0E6,      1.0E6,      1.0E6 ],...
           'torq_deadzone',   [  0.0,        0.0,        0.0   ],...
           'torq_lim',        [  0.25,       0.25,       0.25  ],...
           'bending_filter',struct(...
             'coeff',{[1.23E-3, 2.46E-3, 1.23E-3, 0.0, 0.0, 0.0, 0.0],...
                      [1.23E-3, 2.46E-3, 1.23E-3, 0.0, 0.0, 0.0, 0.0],...
                      [1.23E-3, 2.46E-3, 1.23E-3, 0.0, 0.0, 0.0, 0.0]},...
             'coeff_p',{[-1.91,  9.18E-1, 0.0,     0.0, 0.0, 0.0],...
                        [-1.91,  9.18E-1, 0.0,     0.0, 0.0, 0.0],...
                        [-1.91,  9.18E-1, 0.0,     0.0, 0.0, 0.0]},...
             'order',{2, 2, 2}));
Hardware.Cpe.control.sa_ref_cmd = pi/2;    % rad
Hardware.Cpe.control.sa_err_gain = 0.04;   % step/s/step
Hardware.Cpe.control.sa_rate_lim = 3.3333; % rad/sec
Hardware.Cpe.control.sa_step_lim = 7;      % steps
Hardware.Cpe.control.sa_step_quantum = 3819.7186; % step/rad
% CPE CSS scale factors (KP.CSS)
Hardware.Cpe.cssa_sf = [2.44200E-4   % 1/(4095 * 2*sin(30))
                        1.40989E-4]; % 1/(4095 * 2*cos(30))
               
%Throw a warning of the wheel speeds cross this value (RPM)
%during a hold period
Hardware.Rwa.lowThreshold = 500;

%FSS field of view (deg)
Hardware.Fss.Fov = 49.3;
% Disable SPM beyond this pitch angle to avoid edge of FSS FOV
Hardware.Fss.SpmBoundary = 135.0; % SSAWG 4/22/20

% Model of  individual coarse sun sensors (CSS).  Per the PCAD CDA, 11 Jan 
% 1996, section 4-04, "Each CSSA outputs a current nominally proportional  
% to the cosine of the angle between the sun vector and the normal to the 
% CSSA face." However, the sensor output does not exactly match the cosine
% of the angle.  The actual output profile is shown in Figure 4.4.3.1-3 of 
% the CDA and is captured here.
Hardware.Css.output_model = [ 0          4.413043478
                              5          4.391304348
                             10          4.347826087
                             15          4.260869565
                             20          4.173913043
                             25          4.065217391
                             30          3.936170213
                             35          3.776595745
                             40          3.574468085
                             45          3.329787234
                             50          3.074468085
                             55          2.787234043
                             60          2.46875
                             65          2.072916667
                             70          1.563829787
                             75          1.071428571
                             80          0.606382979
                             82.60869565 0.395833333
                             85          0.208333333
                             86.45833333 0.135416667
                             88.33333333 0.072916667
                             90.01       0.041666667];
% Orientation of the four CSS sensors
Hardware.Css.face_normals = [-sin(30*pi/180)  cos(30*pi/180) 0; ...
                              sin(30*pi/180)  cos(30*pi/180) 0; ...
                              sin(30*pi/180) -cos(30*pi/180) 0; ...
                             -sin(30*pi/180) -cos(30*pi/180) 0];
% Digitization spec, per Table 3.2.1.3-3 of the SPE performance spec 
Hardware.Css.counts_per_mA = 745/1; % counts/mA
                              
%Various IRU calibration matrices (supplied by W Davis)
%Matrices marked '1' are the onboard values.  Matrices
%marked '2' are the ground calculated 'true' values.  The
%difference between '1' and '2' is what determines the 
%IRU calibration error.

%low-rate scale factors (2,1,4,3) -upper, +lower
% ground version is flight values divided by four. Flight computes every
% minor cycle, ground every minor frame
Hardware.Iru.F1 = ...
[    1.556414E-006  1.565245E-006  1.552804E-006  1.570255E-006
     1.556111E-006  1.565064E-006  1.552675E-006  1.570089E-006]./4;
         
Hardware.Iru.F2 = Hardware.Iru.F1;

% IRU to ACA pseudo-inverse
% G1 same as on-board values 
% G2 best available values 
Hardware.Iru.G1 = ...
[  -0.499377392   0.499842147   0.500567325  -0.500571427
   -0.254175578   0.609872424  -0.253136728   0.610150734
   -0.558040055  -0.053074648  -0.556442099  -0.053918661];
      
Hardware.Iru.G2 = Hardware.Iru.G1;

%alignment/scale-factor matrix
Hardware.Iru.M1 = ...
[   1.05118411E-04   9.71687352E-05   8.21970277E-05
   -1.13730519E-04  -2.75105723E-06  -3.98690038E-06
   -3.78150044E-05   1.50690646E-06   3.19926813E-05  ];

Hardware.Iru.M2 =  Hardware.Iru.M1;


%U-Matrix of gyro axes
Hardware.Iru.U1 = ...
    [  -0.498710663  -0.076330874  -0.863400991
        0.500165395   0.788193377  -0.358588592
        0.500874658  -0.075004316  -0.862263839
       -0.499888574   0.788190158  -0.358981456];
       
Hardware.Iru.U2 = Hardware.Iru.U1;

          
%Deadband value for mups unloading (N-m)
Hardware.Mups.deadZone = 2.7116; % 2 ft-lb-sec

%Maximum value for on board momentum.  Throw
%a warning if calculated momentum exceeds this value
Hardware.Mups.momentumThreshold = 29.0; % ft-lb-sec
Hardware.Mups.momentumRadzoneThreshold = 34.0; % ft-lb-sec

%MUPS location from CG (ft)
Hardware.Mups.OffsetCG = ...
[   9.0750    9.0750    9.0750    9.0750
   -3.5000    3.5333    3.5333   -3.5000
   -6.0083   -6.0083    5.8250    5.8250];

%MUPS Alignment with Body Coordinates (unitless)
Hardware.Mups.Alignment = ...
    [           0           0            0            0
     -sin(30*pi/180) sin(30*pi/180)  sin(30*pi/180) -sin(30*pi/180)
      cos(30*pi/180) cos(30*pi/180) -cos(30*pi/180) -cos(30*pi/180)];

%MUPS firing period (minor frames, k-const)
Hardware.Mups.FP=10;
%MUPS Momentum Capability matrix (PCAD k-const, FPS)
Hardware.Mups.MomCap=[.47393,.65298,.37700];
%MUPS Minimum Allowed fraction of max pulsewidth (PCAD k-const)
Hardware.Mups.TimeFractMin=0.25;
%MUPS Maximum Pulsewidth (PCAD k-const)
Hardware.Mups.MaxPW=.2;
%MUPS Default Momentum Unload Timeout (sec)
Hardware.Mups.ObcDumpTimeout=400;
%MUPS Thrusters Command Quantization (sec)
Hardware.Mups.CommandQuant=0.010;
%MUPS tank volume (in^3)
Hardware.Mups.VTank = 2382; 
%MUPS tank helium mass (lbm)
Hardware.Mups.massHe = 0.1;
%MUPS fuel mass remaining (lbm)
Hardware.Mups.massN2H4 = 39.0;

%MUPS Thrust vs Pressure Linear Fit Parameters
%Thrust [lbf] = pressure[psia] * ThrustSlope + ThrustOffset
Hardware.Mups.ThrustSlope=...
     [ 0.00070482      0.00087661      0.00079171      0.00078669];
Hardware.Mups.ThrustOffset=...     
     [ 0.02423169     -0.00905957     -0.00287366     -0.00999972];

% MUPS Firing Constraint Parameters
% No unloads within this many sec of either side of a maneuver where the momentum monitor is disabled
Hardware.Mups.FiringConstraints.MomMonKeepout = [70*60 10*60]; 
% No unloads within this many sec of either side of an eclipse (penumbra)
Hardware.Mups.FiringConstraints.EclipseKeepout = [85*60 20*60]; 
Hardware.Mups.FiringConstraints.MaxCounts=[Inf 0 Inf Inf]; % max counts per thruster
Hardware.Mups.FiringConstraints.MinCountsNPM=[250 0 250 250]; % min counts per thruster while in NPM
Hardware.Mups.FiringConstraints.MinCountsNMM=[350 0 350 350]; % min counts per thruster while in NMM
% multiply dump duration by this when checking for overlaps
Hardware.Mups.FiringConstraints.DurationPad=1.1; 
Hardware.Mups.FiringConstraints.MinGap = 48*3600; % Minimum time between dumps (seconds)
% Dump cut off commands must be within Timeout +/- TimeoutPad seconds of the dump end time
Hardware.Mups.FiringConstraints.Timeout = 50; 
Hardware.Mups.FiringConstraints.TimeoutPad = 10; 
% No dumps within this long (sec) of maneuver start
Hardware.Mups.FiringConstraints.ManeuverKeepout = 300; 
% first two columns are MUPS-1 and 2 temps respectivly, third column is max duration if under those temps
Hardware.Mups.FiringConstraints.TempDurMatrix = [112 112 363;132 132 272;162 162 181]; 


 %Minor frame duration (sec)
Hardware.Obc.minorFrameT = 0.25625;

%LGA parameters
Hardware.LGA.LowPowerRange = 21050; % km, from CCDM-L-005

% Approximate area of various components of the Chandra spacecraft
% (for computing meteor probability of impact).
% These values were taken from the meteor handling spreadsheets for the
% 2001 Leonids meteor shower, except where noted.
Hardware.Geometry.Solar_Array_Area = 26.1; % m^2
Hardware.Geometry.Solar_Array_Edge_Area = 0.28; % m^2
%   Area of body looking down the X axis
Hardware.Geometry.Body_End_Area = 136.1^2*(0.0254^2); % m^2
%   Area of body looking perpendicular to the X axis
Hardware.Geometry.Body_Side_Area = ...
        ((34.5*50)+(20*98.4)+(73*136.1))*(0.0254^2); % m^2
%   Area of telescope looking from the side (perpendicular to the X axis)
% This is based on dimensions provided in "Interface Control Drawing -
% Telescope AXAF-I", Drawing 301160, sheet 14
Hardware.Geometry.Tel_Side_Area = (387-60)*((52+99)/2)*(0.0254^2); % m^2
%   Angle below which the wider body obscures (hides) the telescope
Hardware.Geometry.Body_Obscures_Tel_Angle = 8.2; % deg

Hardware.Sim.CommandingDelays=65.4; % worst case commanding delays for each SIM command (sec)
Hardware.Sim.Trans.StepPerSec = 727;
Hardware.Sim.Trans.RampTime = 30; % Pad to account for ramp up/ramp down (in sec)
Hardware.Sim.Trans.NominalRangeMax=92905;
Hardware.Sim.Trans.NominalRangeMin=-99616 ;
Hardware.Sim.Trans.MissionMax=101856;
Hardware.Sim.Trans.MissionMin=-102792;
Hardware.Sim.Focus.StepPerSec = 50;
Hardware.Sim.Focus.Overshoot = 50; % overshoot for moves in +ve direction 
Hardware.Sim.Focus.GoToDelay = 11; % delays for "go-to" commanding (sec)
Hardware.Sim.Focus.NominalRangeMax=-418;
Hardware.Sim.Focus.NominalRangeMin=-1061;
Hardware.Sim.Focus.MissionMax=-418;
Hardware.Sim.Focus.MissionMin=-1061;

