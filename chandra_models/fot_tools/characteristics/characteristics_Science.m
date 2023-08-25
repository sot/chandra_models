function Science = characteristics_Science

%  characteristics_Science:     Instrument chip positions, fid light values,
%  default sim positions, sim translation tables, ACA parameters, and 
%  ACIS radiator parameters.

%-------------------------------------
% Rev#    Date       Who     Purpose
% ----  --------  ---------  ---------
%  000  07/01/02  P.Goulart  Original
%  001  01/22/07  S.Bucher   Updated Fid positions w/ data from T.Aldcraoft
%                            after Jan 07 CCD cooling
%  002  01/31/07  S.Bucher   Updated FID positions with corrected values from Ball memo
%  003  10/23/07  S.Bucher   Added Rad section
%  004  03/22/10  M.Baski    Reduced radzone perigee offset from 5hrs to 4hrs per
%                            DDTS entry OCCcm09007.
%  005  11/18/10  M.Baski    Added ref limit for Earth solid angle in
%                            ACIS radiator field of view for DDTS 9211.
%  006  12/07/11  M.Baski    Changed Rad.MinEntryTime to 0 and created new 
%                            parameter for estimating rad entry, 
%                            Rad.EntryTimeEst, for DDTS 9455.
%-------------------------------------


%Positions of the Chip edges and fid lights.  These values are
%in some kind of bizarre units that get transformed into angles
%when the appropriate sim translation/focus calculation is applied
Science.HRC_S.chippos = ...
[   -0.146                     -0.01
    -0.046                     -0.01
     0.054                     -0.01
     0.154                     -0.01
     0.154                      0.01
     0.054                      0.01
    -0.046                      0.01
    -0.146                      0.01];

Science.HRC_I.chippos = ...
[    0                        -0.06576
     0.06576                   0
     0                         0.06576
    -0.06576                   0      ];

Science.ACIS_S.chippos = ...
[   -0.0808                   -0.0123
    -0.0559                   -0.0123
    -0.0309                   -0.0123
    -0.006                    -0.0123
     0.0189                   -0.0123
     0.0439                   -0.0123
     0.0688                   -0.0123
     0.0688                    0.0123
     0.0439                    0.0123
     0.0189                    0.0123
    -0.006                     0.0123
    -0.0309                    0.0123
    -0.0559                    0.0123
    -0.0808                    0.0123];

Science.ACIS_I.chippos = ...
[   -0.0265                   -0.0265
    -0.0017                   -0.0265
     0.0231                   -0.0265
     0.0231                   -0.0017
     0.0231                    0.0231
    -0.0017                    0.0231
    -0.0265                    0.0231
    -0.0265                   -0.0017];


%Fid light positions.  
Science.HRC_S.fidpos = ...
  [      0.0571252    0.0227634
        -0.0595400    0.0224085
         0.0572545   -0.0272881
        -0.0594729   -0.0274048 ];
 Science.HRC_I.fidpos = ...
  [       0.0377667    0.0635461
         -0.0406593    0.0636239
          0.0586035   -0.0485306
         -0.0615813   -0.0484119 ];
 Science.ACIS_S.fidpos = ...
  [      -0.0448963    0.0845719
          0.0376268    0.0847734
         -0.00194703   0.0910544
         -0.104151    -0.0081088
          0.0888731   -0.0077944
         -0.0189102   -0.0391135 ];
 Science.ACIS_I.fidpos = ...
  [      -0.0447620    0.0410805
          0.0376852    0.0413759
         -0.00180980   0.0475558
         -0.104142    -0.0513726
          0.0889680   -0.0512821
         -0.0187749   -0.0826233 ];


            
%The nominal sim translation position for each instrument
Science.HRC_S.simpos  = -99612;
Science.HRC_I.simpos  = -50505;
Science.ACIS_S.simpos =  75620;
Science.ACIS_I.simpos =  92905;

% The nominal dither pattern for each instrument
Science.HRC_S.standard_ditherVal  = [0.005556,0.331200,0.000000,0.005556,0.468400,0.000000];
Science.HRC_I.standard_ditherVal  = [0.005556,0.331200,0.000000,0.005556,0.468400,0.000000];
Science.ACIS_S.standard_ditherVal = [0.004444,0.254600,0.000000,0.004444,0.180000,0.000000];
Science.ACIS_I.standard_ditherVal = [0.004444,0.254600,0.000000,0.004444,0.180000,0.000000];

%The nominal focus position for this instrument
Science.HRC_S.focallength  = 10.02773;
Science.HRC_I.focallength  = 10.031032;
Science.ACIS_S.focallength = 10.037572;
Science.ACIS_I.focallength = 10.037572;


%Preferred fid combinations
Science.HRC_S.fid_combo = [1 2 3 ;1 3 4 ;2 3 4 ;1 2 4 ];
Science.HRC_I.fid_combo = [1 2 3 ;1 3 4 ;2 3 4 ;1 2 4 ];
Science.ACIS_I.fid_combo = [1 5 6 ;3 5 6 ;1 3 5 ;1 3 6 ;1 4 5; 1,2,4;1,2,5; 1,2,6; 1,3,4; 1,4,6; 2,3,4; 2,3,5; 2,3,6; 2,4,5; 2,4,6; 2,5,6; 3,4,5; 3,4,6; 4,5,6; 1,2,3];
Science.ACIS_S.fid_combo = [2 4 5 ;3 4 5 ;1 4 5 ;1 5 6 ;2 4 6 ;3 5 6 ;4 5 6 ;2 3 4; 1,2,4; 1,2,5; 1,2,6; 1,3,4; 1,3,5; 1,3,6; 1,4,6; 2,3,5; 2,3,6; 2,5,6; 3,4,6; 1,2,3];

Science.HRC_S.fid_combo2 = [1 ; 2 ; 3 ; 4];
Science.HRC_I.fid_combo2 = [1 ; 2 ; 3 ; 4];
Science.ACIS_I.fid_combo2 = [1 ; 2 ; 3 ; 4 ; 5 ; 6];
Science.ACIS_S.fid_combo2 = [1 ; 2 ; 3 ; 4 ; 5 ; 6];


%Nominal magnitudes for each fid light.  SAUSAGE always
%commands these magnitudes.
Science.HRC_S.fid_magnitude  = [7.1007 7.1007 7.0857 7.1198];
Science.HRC_I.fid_magnitude  = [7.0749 7.0830 7.1159 7.0806];
Science.ACIS_S.fid_magnitude = [7.2531 7.1778 7.3382 7.1966 7.2168 7.2696];
Science.ACIS_I.fid_magnitude = [7.2531 7.1778 7.3382 7.1966 7.2168 7.2696];

%The nominal focus position for each instrument
Science.HRC_S.focuspos  = -991;
Science.HRC_I.focuspos  = -716;  
Science.ACIS_S.focuspos = -468;  
Science.ACIS_I.focuspos = -536;

%Sim translation step size
Science.Sim.stepsize = 2.51432e-006;

%Sim focus table.  Same as in the OFLS characteristics file.
Science.Sim.focus_table = ...
[   -11000                  -0.01062
    -10900                  -0.01058
    -10800                  -0.01054
    -10700                   -0.0105
    -10600                  -0.01046
    -10500                  -0.01042
    -10400                  -0.01037
    -10300                  -0.01033
    -10200                  -0.01028
    -10100                  -0.01023
    -10000                  -0.01019
    -9900                  -0.01014
    -9800                  -0.01009
    -9700                  -0.01004
    -9600                  -0.00998
    -9500                  -0.00993
    -9400                  -0.00988
    -9300                  -0.00982
    -9200                  -0.00976
    -9100                  -0.00971
    -9000                  -0.00964
    -8900                  -0.00959
    -8800                  -0.00953
    -8700                  -0.00946
    -8600                   -0.0094
    -8500                  -0.00933
    -8400                  -0.00927
    -8300                   -0.0092
    -8200                  -0.00913
    -8100                  -0.00907
    -8000                  -0.00899
    -7900                  -0.00892
    -7800                  -0.00885
    -7700                  -0.00878
    -7600                   -0.0087
    -7500                  -0.00863
    -7400                  -0.00855
    -7300                  -0.00847
    -7200                  -0.00839
    -7100                  -0.00831
    -7000                  -0.00823
    -6900                  -0.00815
    -6800                  -0.00806
    -6700                  -0.00798
    -6600                  -0.00789
    -6500                  -0.00781
    -6400                  -0.00772
    -6300                  -0.00763
    -6200                  -0.00754
    -6100                  -0.00745
    -6000                  -0.00736
    -5900                  -0.00726
    -5800                  -0.00717
    -5700                  -0.00707
    -5600                  -0.00697
    -5500                  -0.00688
    -5400                  -0.00678
    -5300                  -0.00668
    -5200                  -0.00658
    -5100                  -0.00648
    -5000                  -0.00637
    -4900                  -0.00627
    -4800                  -0.00616
    -4700                  -0.00606
    -4600                  -0.00595
    -4500                  -0.00584
    -4400                  -0.00573
    -4300                  -0.00562
    -4200                  -0.00551
    -4100                   -0.0054
    -4000                  -0.00529
    -3900                  -0.00517
    -3800                  -0.00505
    -3700                  -0.00494
    -3600                  -0.00482
    -3500                   -0.0047
    -3400                  -0.00458
    -3300                  -0.00446
    -3200                  -0.00434
    -3100                  -0.00427
    -3000                   -0.0041
    -2900                  -0.00397
    -2800                  -0.00385
    -2700                  -0.00372
    -2600                  -0.00359
    -2500                  -0.00347
    -2400                  -0.00334
    -2300                  -0.00321
    -2200                  -0.00308
    -2100                  -0.00295
    -2000                  -0.00281
    -1900                  -0.00268
    -1800                  -0.00255
    -1700                  -0.00241
    -1600                  -0.00228
    -1500                  -0.00214
    -1400                    -0.002
    -1300                  -0.00187
    -1200                  -0.00173
    -1100                  -0.00159
    -1000                  -0.00145
    -900                  -0.00131
    -800                  -0.00116
    -700                  -0.00102
    -600                  -0.00088
    -500                  -0.00073
    -400                  -0.00059
    -300                  -0.00044
    -200                  -0.00029
    -100                  -0.00015
    0                         0
    100                   0.00015
    200                  0.000297
    300                   0.00045
    400                  0.000599
    500                  0.000752
    600                  0.000904
    700                  0.001057
    800                  0.001212
    900                  0.001364
    1000                  0.001519
    1100                  0.001676
    1200                  0.001831
    1300                  0.001989
    1400                  0.002146
    1500                  0.002306
    1600                  0.002464
    1700                  0.002624
    1800                  0.002784
    1900                  0.002944
    2000                  0.003106
    2100                  0.003269
    2200                  0.003432
    2300                  0.003594
    2400                  0.003759
    2500                  0.003924
    2600                  0.004089
    2700                  0.004255
    2800                   0.00442
    2900                  0.004587
    3000                  0.004755
    3100                  0.004923
    3200                  0.005093
    3300                   0.00526
    3400                  0.005431
    3500                  0.005603
    3600                  0.005773
    3700                  0.005946
    3800                  0.006119
    3900                  0.006292
    4000                  0.006464
    4100                   0.00664
    4200                  0.006812
    4300                   0.00699
    4400                  0.007165
    4500                  0.007343
    4600                  0.007518
    4700                  0.007699
    4800                  0.007877
    4900                  0.008057
    5000                  0.008237
    5100                  0.008418
    5200                  0.008598
    5300                  0.008781
    5400                  0.008964
    5500                  0.009147
    5600                  0.009332
    5700                  0.009517
    5800                  0.009703
    5900                  0.009891
    6000                  0.010079
    6100                  0.010267
    6200                  0.010457];
                  
  
%Rotation matrix from SI to ACA frame 
%(Orthonormalized version of circa 2000 baseline - provided by WSD June 2016)
Science.ACA.SI2ACA.ACIS_I = ...
[0.999999905689160  -0.000337419984089  -0.000273439987106;...
0.000337419984089   0.999999943073875  -0.000000046132060;...
0.000273439987106  -0.000000046132060   0.999999962615285];

% maintain ability to set these for each SI, but currently not used
Science.ACA.SI2ACA.ACIS_S = Science.ACA.SI2ACA.ACIS_I;
Science.ACA.SI2ACA.HRC_I = Science.ACA.SI2ACA.ACIS_I;
Science.ACA.SI2ACA.HRC_S = Science.ACA.SI2ACA.ACIS_I;
Science.ACA.SI2ACA.NONE = diag([1 1 1]); % ERs specified in ACA frame, no transformation needed
Science.ACA.MaxAllowedAimpointDelta = 1; % delta from last iteration allowed when generating a DOT
Science.ACA.AimpointAdjustWarn = 60;

% OFLS transform matrix used to back-out OFLS scheduled attitudes post NOV1615
%!Updated via aimpoint_mon/update_characteristics version 1.1
%!Run at 2016-07-07 00:43Z
%!Started with baseline file CHARACTERIS_11JUN16
%!ACIS-I offsets DY=11.46 arcsec, DZ=2.68 arcsec
%!ACIS-S offsets DY=13.94 arcsec, DZ=3.37 arcsec
% Need transpose of OFLS in Matlab
Science.ACA.OFLS_SI2ACA.ACIS_I = [9.999999E-01, 3.929607E-04, 2.864460E-04;...     
                          -3.929607E-04, 9.999999E-01, -6.131912E-08;...   
                          -2.864460E-04, -5.124290E-08, 1.000000E+00]';   
                          
Science.ACA.OFLS_SI2ACA.ACIS_S = [9.999999E-01, 4.050146E-04, 2.897667E-04;...    
                          -4.050146E-04, 9.999999E-01, -6.461513E-08;... 
                          -2.897667E-04, -5.274460E-08, 1.000000E+00]';
                          
Science.ACA.OFLS_SI2ACA.HRC_I = [1.0, 3.3742E-4, 2.7344E-4;...
                          -3.3742E-4, 1.0, 0.0;...
                          -2.7344E-4, 0.0, 1.0]';
                         
Science.ACA.OFLS_SI2ACA.HRC_S = [1.0, 3.3742E-4, 2.7344E-4;...
                          -3.3742E-4, 1.0, 0.0;...
                          -2.7344E-4, 0.0, 1.0]';



% monitor window position offsets (arcsec)
Science.ACA.Monitor.YAG_Offset=70;
Science.ACA.Monitor.ZAG_Offset=56;
Science.ACA.Monitor.magMax=13.94;
Science.ACA.Monitor.magMin=13.94;
Science.ACA.Monitor.ditherDisaDeltaT=60; % back off time for dither workaround

%A set of unit vectors (columns) normal to the planes of the 
%ACIS radiator.  The Earth is in the radiator FOV
%when it can be seen from the front side of all planes
%simultaneously
Science.ACISRadiator.surfaceNormals = ...
[   0 sqrt(3)/2 -sqrt(3)/2
    0         0          0
    1       1/2        1/2];

% Limits for Earth solid angle (steradian) illuminating
% the ACIS Radiator
Science.ACISRadiator.Solid_Angle.red_limit       = -10000;
Science.ACISRadiator.Solid_Angle.yellow_limit    = -10000;
Science.ACISRadiator.Solid_Angle.reference_limit = 0.012;


% Radiation Handling settings
Science.Rad.EntryID='EEF1000'; % what orbit event is Rad Entry
Science.Rad.ExitID='XEF1000'; % what orbit event is Rad Exit
Science.Rad.MinEntryTime=0;  % pad all enties less than this to this
Science.Rad.EntryTimeEst=4*3600;  % used to estimate Rad entry
Science.Rad.ACISEntryPadEvent='EQF013M';
Science.Rad.ACISExitPadEvent='XQF013M';
Science.Rad.ACISMaxPad=10000;
Science.Rad.ACISMinPad=0; % set to 0 to remove artifical pad histroically used for CTI (6/24/2020)
Science.Rad.HRCpad=10000;  % HRC pad time
Science.Rad.HRCEntryCommandingDelay = 19;  % time to complete HRC Rad entry commanding
% Duration of Radmon Enable ATS.  There is a single command with a -1
% second delta, so the ATS takes essentially no time to complete.
Science.Rad.RadmonEnableCommandingDuration = 0.0;
Science.Rad.RadmonDisableCommandingDelay = 3.0; %Duration of Radmon Enable ATS
% Duration of Radmon Disable ATS.  There is a single command with a 3
% second delta, so the ATS takes essentially 4 seconds to complete.
Science.Rad.RadmonDisableCommandingDuration = 4.0;
Science.Rad.MeanExitTime=6*3600;   % used to estimate Rad exit
Science.Rad.ACISCTISIModes.SixChip={'TE_007AC','TE_007AE','TE_00B26'}; % ACIS CTI modes
Science.Rad.ACISCTISIModes.FiveChip={'TE_00C60','TE_00CA8','TE_00C60'}; % 5 chip versions, must be one-to-one match with six chip
Science.Rad.SafeSimPos=-99612;
Science.Rad.SafeFep=3; % number of FEPs powered-on during a safing action
Science.Rad.ACISRadTripletTiming = [0 9 72]; % delay for EERAD triplet commands from entry event
Science.Rad.ACISRadTripletCommands = {'AA00000000','WSPOW0002A','RS_0000001'};
Science.Rad.ExitDelay.ACIS = 0; % sec to delay start of science commanding after nominal rad exit
Science.Rad.ExitDelay.HRC = 0; %guideline HRC MCP High Voltage Handling
Science.Rad.HrcRadMonEnableDelay = 24; % No HRC commands until this long (sec) after RADMON_EN is issued
Science.Rad.RadDsFormatSep = 11; % Minimum time (sec) required between RADMON_DS and a format change

Science.Acis.FepCmdBuffer = 4; % sec, delay this long after a stop science before a FEP command
Science.Acis.MinFepCmds = {'WSPOW0002A','RS_0000001'}; % commands to power FEPs to maintain minimum required temp
Science.Acis.MinFepTiming = [0 63]; % required delay before each min FEP command
Science.Acis.TxingSetupPad = 1152;

Science.Hrc.DetectorSwapDelay = 96; % time in sec for HRCDET to complete

Science.Acis.MinAcisDelay = 1; %minimum time between ACIS commands

