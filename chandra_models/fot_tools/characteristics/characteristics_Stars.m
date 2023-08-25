function Stars = characteristics_Stars

%  characteristics_Stars:  Settings for the star selection algorithm.

%-------------------------------------
% Rev#    Date       Who     Purpose
% ----  --------  ---------  ---------
%  000  07/01/02  P.Goulart  Original
%  001  10/22/02  S.Bucher   Added General.ERImageSize
%  002  12/15/02  s.Bucher   Updated stage settings per SS&AWG
%  003  07/08/03  S.Bucher   Updated Bad Pixel List
%  004  07/23/03  S.Bucher   Updated Bad Pixel List - DK Cur 2003195
%  005  10/29/03  S.Bucher   Added DoBminusBcheck
%  006  01/13/04  S.Bucher   Updated Bad Pixel List
%  007  05/18/04  S.Bucher   Added geometry check for FIDs and traps
%  008  05/24/04  S.Bucher   Replaced nMinCand with nSurplus
%  009  07/15/04  S.Bucher   Updated Bad Pixel List
%  010  10/06/04  S.Bucher   Updated Bad Star List
%  011  04/13/05  S.Bucher   Updated Bad pix & corrected acq stage typo
%  012  07/01/05  S.Bucher   Update Guide Star Selection Stage criteria
%  013  12/02/05  S.Bucher   Updated Bad Pixels
%  014  01/22/07  S.Bucher   Updated Bad pixels from Jan 07 dark current
%  015  04/18/07  S.Bucher   Updated bad pixels from March 07 dark current
%  016  10/23/07  S.Bucher   Updated Bad Pixels from Sept 07 Dark Current -
%                             note intentional deletion of "reformed pixels"
%  017  10/30/08  M.Pendexter Updated Bad Pixels from Sept 08 Dark Current
%  018  04/13/08  M.Pendexter Updated faint magnitude threshold for the
%                             last search stage for guide stars to 10.8
%  019  01/26/10  M.Pendexter Updated Bad Pixels from 2009 Dark Currents
%  020  05/03/10  M.Baski    Updated Bad Stars per list from Jean in
%                            DDTS OCCcm09028.
%  021  11/08/13  M.Baski    Updated Bad Stars per list from Jean in
%                            DDTS OCCcm10107.
%  022  03/12/15  M.Baski    Updated Bad Stars per list from Jean for
%                            DDTS OCCcm10550.
%
%-------------------------------------


%The Stars portion of the the characteristics structure is 
%defined here.  Each of the sub-structure (General, Acq, Guide,
%Fid) is created, and then they all get slapped together into
%the output 'Stars' at the very end.

%-----------------------------------------------------------------
%ACA values - Conversions, boundaries, bad pixels, etc
%-----------------------------------------------------------------

General.dyn_bgd_n_faint = 0;
General.dyn_bgd_dt_ccd = -4; % DegC

%ACA to pixel frame conversion. (arcseconds to pixels)
General.Aca2Pix = [6.08840495576943         4.92618563916467;
   0.000376181788609776     0.200203020554239;
   -0.200249577514165        0.000332284183255046;
   -2.7052897180601e-009    -5.35702097772202e-009;
   9.75572638037165e-010    1.91073314224894e-008;
   -2.94865155316778e-008   -4.85766581852866e-009;
   8.31198018312775e-013    2.01092070428495e-010;
   -1.96043819238097e-010    5.09721545876414e-016;
   5.14134244771463e-013    1.99339355492595e-010;
   -1.97282476269237e-010    2.52739834319184e-014];

%Pixel to arcsecond conversion
General.Pix2Arc = 4.96289;			

%Default star search area and cutoff magnitude
General.CatalogRadius = 1.1;       %get stars over this radius for search (deg)
General.CatalogMinMag = 14.5;      %stars dimmer than this value are ignored

%initial maneuver attitude uncertainty and search box error margin
General.ManvrErrorSigmaInit       = [10.0,0.1,0.1]*pi/180/3600; 
General.ManvrErrorSearchBoxMargin = 20.0*pi/180/3600;

%bad star list
General.BadStarList = [  36178592
                         39980640
                        185871616
                        188751528
                        190977856
                        260968880
                        260972216
                        261621080
                        296753512
                        300948368
                        301078152
                        301080376
                        301465776
                        335025128
                        335028096
                        414324824
                        444743456
                        465456712
                        490220520
                        502793400
                        509225640
                        570033768
                        614606480
                        637144600
                        647632648
                        650249416
                        656409216
                        690625776
                        692724384
                        788418168
                        849226688
                        956175008
                        989598624
                       1004817824
                       1016736608
                       1044122248
                       1117787424
                       1130635848
                       1130649544
                       1161827976
                       1196953168
                       1197635184]';


%Min commandable magnitude
General.ACAFaintCommandLimit = 11.2;

%Minimum commandable error bar (command must be
%at least MAG_ACA +- this value
General.minCmdMagErrorBar = 1.5;

%Star acquisition time used for scheduling
General.StarAcqTime = 270; %sec

% Image Size for ERs (defined here as attitudes with no fid lights requested)
%  choose 0 for 4x4, 1 for 6x6 and 2 for 8x8
General.ERImageSize=2;

% Multiplicative change in dark current for each 4 degC increase
% (for the dark current scaling formula from the dark_temp_scale 
%  function in chandra_aca/dark_model.py - ref:
%  https://github.com/sot/chandra_aca/blob/master/chandra_aca/dark_model.py#L44)
General.Dark_Map.Scale_4c = 1.59;

%-----------------------------------------------------------------
%General Star Selection Settings
%-----------------------------------------------------------------

%First create a general set of Acq/Guide/Fid settings called
%'Star'.  This is where the default parameters for each stage
%are defined.  Once Star is constructed, The Acq/Guide/Fid fields
%are created by making a copy of 'Star', and then modifying
%or appending as required.  Don't confuse the generic search
%settings 'Star' with the ultimate output 'Stars'


Star.SearchSettings.DoColumnRegisterCheck = 1;
%Star.SearchSettings.NMinCand              = 9;           
Star.SearchSettings.DoBminusVcheck = 1;

%-----------------------------------------------------------------
%Inertial Checks
%-----------------------------------------------------------------

%Define some useful parameters here.  
Star.Inertial.MagLimit      = [5.8 10.2];   %in magnitude units
Star.Inertial.MagErrorTol   = 100;          %in 0.01 mag increments
Star.Inertial.PosErrorTol   = 3000;         %in milli arc seconds
Star.Inertial.ASPQ1Lim      = [0 0];        %ASPQ1 must be in this range (magnitude spoilers)
Star.Inertial.ASPQ2Lim	    = [0 0];        %ASPQ2 must be in this range (proper motion spoilers)
Star.Inertial.ASPQ3Lim		= [0 999];      %ASPQ3 must be in this range (neighbor with undef pos error)
Star.Inertial.VARIABLELim   = -9999;        %VARIABLE must be no bigger than this (variable magnitude marker: -9999 = not variable)
Star.Inertial.MagErrRand    = 0.26;         %Random Magnitude Error in magnitude units
Star.Inertial.MagErrSyst    = 0;            %Systematic Error - This value is a linear expansion of the mag error in BOTH directions, A Positive value INCREASES the magnitude error
Star.Inertial.MaxMagError    = 1.5;         %magnitude errors are limited to this value		


%-----------------------------------------------------------------
%Roll and Camera Dependent Checks
%-----------------------------------------------------------------

Star.Body.Column.MagDiff = 5;
Star.Body.Column.Separation = 4;

Star.Body.Register.MagDiff = 5;
Star.Body.Register.Separation = 4;
Star.Body.Register.Width   = 2;

%Define some of the boundaries of the chips
Star.Body.Pixels.ZPixLim = [-512.5 511.5];    %+- extent in Z direction
Star.Body.Pixels.YPixLim = [-512.5 511.5];    %+- extent in Y direction
Star.Body.Pixels.Center  = [-0.5 -0.5];       %Y-Z position of quadrants joint
Star.Body.Pixels.EdgeBuffer = 5;

Star.Body.Traps.Column =  347;                 %trap positions in pixels (for geometric check)
Star.Body.Traps.Row    = -374;
Star.Body.Traps.DeltaColumn = 3;
Star.Body.Traps.ExclusionZone.Neg = [-6 -2];
Star.Body.Traps.ExclusionZone.Pos = [3 7];

%Stars this many pixels from the edge cannot be candidates
                                         %ie, shrinks the effective search area for candidates                                                        
Star.Body.FOV.YArcSecLim = [-2410 2473]; %+- limits on star positions in arcseconds.
Star.Body.FOV.ZArcSecLim = [-2504 2450]; %set to [-Inf +Inf to ignore this check]



%(1=y-pixel min, 2=y-pixel max, 3=z-pixel min, 4=z-pixel max)
%QUAD BOUNDARIES MUST BE FIRST TWO ENTRIES

%Bad Pixel List is now an array for the ACA FOV boundaries and the trap
Star.Body.Pixels.BadPixels = [ ...
 -512,  511,   -1,    0; ...
   -1,    0, -512,  511; ...
 -245,    0,  454,  454;
];


%-----------------------------------------------------------------
%Spoiler Parameters
%-----------------------------------------------------------------

Star.Spoiler.MinSep = 7;              %minimum spoiler separation (pixels)
Star.Spoiler.MaxSep = 11;             %maximum search box size (pixels)
Star.Spoiler.Intercept = 9;           %0 magnitude difference intercept (pixels)
Star.Spoiler.Slope = 1/2;             %spoiler slope boundary
Star.Spoiler.SigErrMultiplier = 3;    %multiplier for 1-sigma error calculations

Star.Spoiler.MagDiffLimit     = -Inf; %Stars this much dimmer can't ever be spoilers
                                      %-Inf means all stars will be considered
                                      %This value is checked against the difference
                                      %in nominal magnitudes, regardless of errors

%-----------------------------------------------------------------
%Acq Selection Values
%-----------------------------------------------------------------

%Make a copy of the generic settings, and tack on 
%a few Acq specific settings

Acq = Star;
Acq.Select.MaxSearchBox = [180 200 220 240]; %maximum search box size (arcsec)
                                         %smallest valid value is chosen
                                         %given maneuver/dither error
Acq.Select.MinSearchBox = 25;            %maximum search box size (arcsec)
Acq.Select.NMaxSelect   = 8;             %maximum acquisition stars
Acq.Select.nSurplus = 0;
Acq.Select.nBigSearchBox = 3;         % you must have at least this many stars with search boxes >= Acq.Select.BigSearchBoxSize
Acq.Select.BigSearchBoxSize = 160;    % lower bound to be considered a "big search box"
%-----------------------------------------------------------------
%Acq Staging Values 
%-----------------------------------------------------------------

%Now define the search stages.  Each stage is 
%just a copy of the one before it, plus a few
%further modifications.  There is no limit to
%the number of search stages (i.e., the # of 
%search stages is DEFINED as length(Acq)

%Stage 1

% Bad Pixel List is now empty and is not used in star seleciton
Acq.Body.Pixels.BadPixels = [ ...
 -512,  511,   -1,    0; ...
   -1,    0, -512,  511; ...
 -245,    0,  454,  454;
];
Acq.Body.Pixels.BadPixels(1:2,:) = [];      %no quad boundaries for Acq stars
Acq(1).Inertial.MagLimit      = [5.8 9.2];

%Stage 2
Acq(2) = Acq(1);
Acq(2).Inertial.MagLimit      = [5.8 10.2];
Acq(2).Select.MaxSearchBox = [160 180 200 220 240]; %maximum search box size (arcsec)
Acq(2).Spoiler.SigErrMultiplier = 1;

%Stage 3
Acq(3) = Acq(2);
Acq(3).Inertial.MaxMagError = 1;
Acq(3).SearchSettings.DoColumnRegisterCheck = 0;
Acq(3).Select.MaxSearchBox = [120 140 160 180 200 220 240]; %maximum search box size (arcsec)
Acq(3).Inertial.MagLimit      = [5.8 10.5];

%Stage 4
Acq(4) = Acq(3);
Acq(4).Spoiler.SigErrMultiplier = 0;
Acq(4).Body.Pixels.BadPixels = []; %no bad pixels
Acq(4).Inertial.MagLimit      = [5.8 10.6];

%Stage 5
Acq(5) = Acq(4);
Acq(5).SearchSettings.DoBminusVcheck = 0;
Acq(5).Inertial.MagLimit      = [5.8 11.0];

%----------------------------------------------------------------
%Guide Selection values
%-----------------------------------------------------------------

%Make a copy of the generic settings, and tack on 
%a few Guide specific settings

Guide = Star;
Guide.Select.NMaxSelect    = 8;               %maximum guide stars

Guide.Select.MaxSearchBox  = 25;              %guide search boxes are always this size
Guide.Select.MinSearchBox  = 25;              %maximum search box size (arcsec)
Guide.Select.LeverArm      = 1.*pi/180;       %Lever arm factor for guide star optimization
Guide.Select.NDirectSearch = nchoosek(12,5);  %maximum combinations for direct search
Guide.Select.C_10          = 1444.0;          %ODB_CO_MAG_10
Guide.Select.CCDIntTime    = 1.4;             %?????
Guide.Select.Sig_P1        = 16.2;            %ODB_SIGMA_P1
Guide.Select.Sig_P2        = 0.5;             %ODB_SIGMA_P2

%Guide.SearchSettings.NMinCand  = 6;           %search staging proceeds until this many found
Guide.Select.nSurplus = 1;

%-----------------------------------------------------------------
%Guide Staging Values 
%-----------------------------------------------------------------

%Now define the search stages.  Each stage is 
%just a copy of the one before it, plus a few
%further modifications.  There is no limit to
%the number of search stages (i.e., the # of 
%search stages is DEFINED as length(Guide)

Guide(2) = Guide(1);
Guide(2).Inertial.MagErrRand = 0.15;
Guide(2).Spoiler.SigErrMultiplier = 2;
Guide(2).Inertial.MaxMagError      = 1;

Guide(3) = Guide(2);
Guide(3).Inertial.MagErrRand = 0.0;
Guide(3).Spoiler.SigErrMultiplier = 1;
Guide(3).Inertial.MaxMagError      = 0.5;
Guide(3).Inertial.MagLimit      = [5.8 10.3];

Guide(4) = Guide(3);
Guide(4).Spoiler.SigErrMultiplier = 0;
Guide(4).Inertial.MagLimit      = [5.8 10.3];

Guide(5) = Guide(4);
Guide(5).SearchSettings.DoBminusVcheck = 0;


%-----------------------------------------------------------------
%FID Selection values
%-----------------------------------------------------------------

%Make a copy of the generic settings, and tack on 
%a few Fid specific settings

Fid = Star;
Fid.Select.SearchBox      = 25;     %Fid search box size in arcseconds
Fid.Select.MagBrightLimit = 5.8;    %Max magnitude for ACA catalog
Fid.Select.MagFaintLimit  = 8;      %Min magnitude for ACA catalog

Fid.Spoiler.MinSep = 5;             %Anything less than 5 pix, rejected
Fid.Spoiler.MaxSep = 5;	            %anything more than 5 pix, ok
Fid.Spoiler.Intercept = 5;
Fid.Spoiler.Slope = 1/2;
Fid.Spoiler.SigErrMultiplier = 3;
Fid.Spoiler.MagDiffLimit     = -5; 
Fid.SearchSettings.DoGeometricTrapCheck=1;
Fid.SearchSettings.max_num_fids = 3;
%Now define the search stages.  Each stage is 
%just a copy of the one before it, plus a few
%further modifications.  There is no limit to
%the number of search stages (i.e., the # of 
%search stages is DEFINED as length(Fid)

%Add a second stage with a more liberal mag cuttoff
%limit for spoilers
Fid(2) = Fid(1);
Fid(2).Spoiler.MagDiffLimit = -4;


%-----------------------------------------------------------------


%-----------------------------------------------------------------
%Assemble it all into one structure
%-----------------------------------------------------------------
Stars.General = General;
Stars.Acq     = Acq;
Stars.Guide   = Guide;
Stars.Fid     = Fid;

