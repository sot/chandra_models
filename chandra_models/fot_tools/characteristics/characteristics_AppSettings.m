function AppSettings = characteristics_AppSettings()

%  Settings for various Axaftools software.

%-------------------------------------
% Rev#    Date       Who     Purpose
% ----  --------  ---------  ---------
%  000  07/01/02  P.Goulart  Original
%  001  03/05/07  S.Bucher   Re-baseline with added parameters for
%                            newViewer and LIGER
%  002  10/23/07  S.Bucher   Added new pool filter by SImode and Lunar
%                             Eclipses to orbit events
%  003  10/14/09  M.Pendexter Adjusted the SIR pad time to be 6 hrs
%  004  05/10/11  S.Hurley   Added ACIS Bias default values & acq color
%  005  05/25/11  S.Hurley   Added grating move times
%  006  08/01/12  M.Baski    Added star density map settings for DDTS 9109.
%  007  11/04/13  S.Hurley   Added ACIS readout time
%  008  01/18/14  S.Hurley   Added tolerence for starcat updates in ORViewer
%-------------------------------------

%--------------------------------------------------------------------
%MCC Settings
%--------------------------------------------------------------------

%Minimum time in seconds between maneuvers.  MCC throws a warning
%if this value is less than the time between the end of one maneuver
%and the start of the next
AppSettings.Mcc.minholdtime = 19.5;
AppSettings.Mcc.TelemPageAddressList={'http://asc.harvard.edu/mta/SOH/Prop/soh-prop.html',...
    'http://asc.harvard.edu/mta/SOH/Load/soh-load-rev.html',...
    'http://asc.harvard.edu/mta/SOH/Config/soh-config.html'};
AppSettings.Mcc.DefaultDotEndPad=86400; % if no schedule end time is passed, add a null maneuver this far after the last command in the DOT

%--------------------------------------------------------------------
%ORViewer/MPS Settings
%--------------------------------------------------------------------
%Amount of time (in seconds) for ORViewer to include
%between maneuver segments when constructing a schedule
AppSettings.Mps.manvrSegmentHoldTime = 20;
AppSettings.Mps.minManTime = 240;
AppSettings.Mps.meanManTime = 1400; % default maneuver time used when estimating schedule
AppSettings.Mps.maxManAngle = 180; % default max allowed maneuver angle
AppSettings.Mps.minHoldTime = 1200;
AppSettings.Mps.perigeeAttitudeSearchRadius=5.0 ; % perigee attitude search tolerance (degrees)
AppSettings.Mps.FirstERobsid=38000;   % consider all obs with obsid > than this to be non-science
AppSettings.Mps.ExcludedERobsids = [49899 49898 49896]; % unallowed ER obsids (previously used for ORs) 
AppSettings.Mps.DoNotShortenBelow = 5000;  % don't shink obs with durations less than this
AppSettings.Mps.MinimumPercentDuration = .9; % shorten obs to no less than their requested duration * this
AppSettings.Mps.MaxShortenBy = 10000; % do not take more than this amount of time off an OR
AppSettings.Mps.MinDurPad = 300; % pad minimum OR duration by this
AppSettings.Mps.MaximumPercentDuration = 1.1; % extend observations to no more than this
AppSettings.Mps.MaxDurCap = 5000; % maximum allowable time added to any OR
AppSettings.Mps.Eph.Step=60;
AppSettings.Mps.GGStep=300; % time step (in seconds) to use when propigating momentum for gravity gradient display
AppSettings.Mps.AttitudeTolerance=1e-5; % allowable deviation when checking if attitudes match (deg)
AppSettings.Mps.Antisun.Step=21600;  % step size for colored dots to show OR movement in Antisun plot
AppSettings.Mps.AllowedManDelT=60; % how far from the time used to calculate the quaternions for an observaiton is the start time allowed to slide
AppSettings.Mps.DefaultAcisDelayNoBias = 250;  %default delay for ACIS setup with no SIMOde change
AppSettings.Mps.DefaultAcisBiasTime = 1500;  % default ACIS bias duration
AppSettings.Mps.DummyAcisModes = {'TE_0003E' 'TE_001DC' 'TE_005C6' 'TE_002F8' 'TE_00C6A' 'TE_00654'};  % use these SI Modes to generate dummy ACIS commands, ordered from 1 chip to 6 chips
AppSettings.Mps.AcisReadOutTime = 180; % delay before OBSID commanding or other ACIS commands to allow ACIS read out to complete
AppSettings.Mps.AcisUCBackoff = 60; % backoff time for OBSID and Format swap for ACIS undercover observations
AppSettings.Mps.AcisDitherSep = 12*60; % minimum time (sec) required after start science before any dither commands
AppSettings.Mps.HrcDetectorSwapDelay = 96; % time in sec for HRCDET to complete
AppSettings.Mps.Gratings.SingleMoveTime = 290.6; %3:45 + 2 format changes
AppSettings.Mps.Gratings.DoubleMoveTime = 515.6; %8:34 + 2 format changes
AppSettings.Mps.FormatChangeTime = 32.8;
AppSettings.Mps.MinNilDuration = 0; % minimum duration to schedule an ACIS NIL (sec)
AppSettings.Mps.MinNilForceDuration = 25000; % for NILs longer than this, allow schedule inefficiency due to bias
AppSettings.Mps.MinCtiDuration = 1680; % minimum duration to schedule a CTI (1500 for bias plus 180 for readout)
AppSettings.Mps.SchedEndGapWarn = 60; % issue a warning if the schedule end time is more than this far after the last activity (sec)
AppSettings.Mps.prelimFilesSuffixDefault = 'prelim'; % default suffix for prelim files sent to the SOT
AppSettings.Mps.defaultAcqBoxSize = 120; % default search box size (arcsec) when forcing an acq star 
AppSettings.Mps.orKeeperFields = {'duration','roll','ForceAcisBias','StartTime'}; % Fields to keep from an original OR when replacing with final OR

% large dither workaround
AppSettings.Mps.LargeDitherAmp = 30; % arcsec dither amp (y or z) above which "large dither" work arounds are required
AppSettings.Mps.LargeDitherDisableBackoff = 60; % sec, disable dither this far before the end of the maneuver to the large dither target
AppSettings.Mps.LargeDitherDelay = 60*7; % sec, command large dither this long after the end of the maneuver to the large dither target
AppSettings.Mps.LargeDitherEndPad = 60*3; % sec, recommand nominal dither this long before end of large dither target

% monitor window workaround
AppSettings.Mps.MonStarDitherDisableBackoff = 60; % sec, disable dither this far before maneuver end time for obs with monitor star 
AppSettings.Mps.MonStarATS = 'A_MON_WIN';
AppSettings.Mps.MonStarDitherEnableDelay = 7*60; % sec, re-enable dither this long after maneuver end time for obs with monitor star - 5 min + 2 min delta on ATS

% DOT settings
AppSettings.Mps.DotProcessing.ShortEclipseATS='ECLIPSE_NPM_SHORT';
AppSettings.Mps.DotProcessing.ShortEclipseBoundary=20*60; %eclipses shorter than this are "short" (sec)
AppSettings.Mps.DotProcessing.MediumEclipseATS='ECLIPSE_NPM_NEW';
AppSettings.Mps.DotProcessing.MomDumpATS='P_MOMPR_VDEB';
AppSettings.Mps.DotProcessing.CommATS='COMSET';

% Momentum dump dwell mode on/off timing per P_MOMPR_VDEB.ATS
AppSettings.Mps.DwellModeOnTimeBeforeDump = 34.0; % sec
AppSettings.Mps.DwellModeOffTimeAfterDump = 2.0+2.0+1.0+1.0+1.0+2.0+1.0; % sec

% Momentum dump AOMUNLGR Delta timing per P_MOMPR_VDEB.ATS
AppSettings.Mps.pre_AUMUNLGR_cmd_delta = 8; % sec
AppSettings.Mps.AOMUNLGR_dt = 0.0; % sec
% SCS 120 completion time after AOMUNLGR, used to re-disable thruster if
% needed
AppSettings.Mps.thruster_DS_AOMUNLGR_delay = 4015.0; % sec

% Maneuver Momentum Monitor AOPCADSE=21 Delta timing per
% MANVR.ATS (6 min 30 sec) -> A_ENAB_SCMOM_MON.ATS (1 min)
AppSettings.Mps.thruster_DS_Manvr_AOPCADSE_21_dt = 450; % sec

% SPM Command Delta timing per A_SPM_CTRL.ATS
AppSettings.Mps.cmd_delta.SPM_CTRL.SPM_DISA = -60; % sec
AppSettings.Mps.cmd_delta.SPM_CTRL.SCS98_ENAB = -1.025; % sec
AppSettings.Mps.cmd_delta.SPM_CTRL.SPM_ENAB = -60; % sec
AppSettings.Mps.cmd_delta.SPM_CTRL.SCS98_DISA = -1.025; % sec

% HRC Command Delta timing per HRCOBS.ATS
AppSettings.Mps.cmd_delta.HRCOBS.x215PCAON = 0; % sec (215pcast_off = 1)
AppSettings.Mps.cmd_delta.HRCOBS.x2S2HVON = 2; % sec (2s2onst_on = 1)
AppSettings.Mps.cmd_delta.HRCOBS.COACTS1_92 = 80.150; % sec (2imonst_on = 1)
AppSettings.Mps.cmd_delta.HRCOBS.COACTS1_93 = 80.150; % sec (2sponst_on = 1)
AppSettings.Mps.cmd_delta.HRCOBS.start = 0;
AppSettings.Mps.cmd_delta.HRCOBS.duration = 294;
% HRC Command Delta timing per HRCDET.ATS
AppSettings.Mps.cmd_delta.HRCDET.x215PCAON = 0; % sec (215pcast_off = 1)
AppSettings.Mps.cmd_delta.HRCDET.x224PCAON = 1; % sec (224pcast_off = 1)
AppSettings.Mps.cmd_delta.HRCDET.x2IMHVOF = 2; % sec (2imonst_on = 0)
AppSettings.Mps.cmd_delta.HRCDET.x2SPHVOF = 3; % sec (2sponst_on = 0)
AppSettings.Mps.cmd_delta.HRCDET.x224PCAOF = 94; % sec (224pcast_off = 0)
AppSettings.Mps.cmd_delta.HRCDET.start = 0;
% set to AppSettings.Mps.HrcDetectorSwapDelay (96 seconds) to provide a
% small gap to ensure commands complete and not overlap
AppSettings.Mps.cmd_delta.HRCDET.duration = AppSettings.Mps.HrcDetectorSwapDelay;
% HRC Command Delta timing per HRCOBSEND.ATS
AppSettings.Mps.cmd_delta.HRCOBSEND.x2SPHVOF = -15; % sec (2sponst_on = 0)
AppSettings.Mps.cmd_delta.HRCOBSEND.x2IMHVOF = -14; % sec (2imonst_on = 0)
AppSettings.Mps.cmd_delta.HRCOBSEND.x2S2HVOF = -5; % sec (2s2onst_on = 0)
AppSettings.Mps.cmd_delta.HRCOBSEND.x215PCAOF = -2; % sec (215pcast_off = 0)
AppSettings.Mps.cmd_delta.HRCOBSEND.start = -16;
AppSettings.Mps.cmd_delta.HRCOBSEND.duration = 14;
% Momentum Dump Command Delta timing per P_MOMPR_VDEB.ATS
AppSettings.Mps.cmd_delta.P_MOMPR_VDEB.thrusterDS_1 = -8;
AppSettings.Mps.cmd_delta.P_MOMPR_VDEB.thrusterDS_2 = -7;
AppSettings.Mps.cmd_delta.P_MOMPR_VDEB.thrusterDS_3 = -6;
AppSettings.Mps.cmd_delta.P_MOMPR_VDEB.thrusterDS_4 = -5;
AppSettings.Mps.cmd_delta.P_MOMPR_VDEB.AOMUNLGR = 0;
AppSettings.Mps.cmd_delta.P_MOMPR_VDEB.AOPCADSE_21 = 9; % + TIME_DELAY
AppSettings.Mps.cmd_delta.P_MOMPR_VDEB.Dwell_Mode_delay = 2;
AppSettings.Mps.cmd_delta.P_MOMPR_VDEB.thrusterEN_1 = 1; % + TIME_DELAY + Dwell_Mode?
AppSettings.Mps.cmd_delta.P_MOMPR_VDEB.thrusterEN_2 = 1; % + TIME_DELAY + Dwell_Mode? + thrusterEN_1?
AppSettings.Mps.cmd_delta.P_MOMPR_VDEB.thrusterEN_3 = 1; % + TIME_DELAY + Dwell_Mode? + thrusterEN_1? + thrusterEN_2?
AppSettings.Mps.cmd_delta.P_MOMPR_VDEB.thrusterEN_4 = 1; % + TIME_DELAY + Dwell_Mode? + thrusterEN_1? + thrusterEN_2? + thrusterEN_3?

% ER list outout settings
AppSettings.Mps.RadER.SIR_pad = 21600; % window range for SIR to help OFLS scheduling
AppSettings.Mps.RadER.SIR_MinDuration = 10;
AppSettings.Mps.RadER.SIR_MaxDuration = 50000;
AppSettings.Mps.RadER.TE_MinDuration = 10; % minimum duration (sec) for T_E target cal 
AppSettings.Mps.RadER.TE_MaxDuration = 60; % maximum duration (sec) for T_E target cal 
AppSettings.Mps.RadER.TX_MinDuration = 10; % minimum duration (sec) for T_X target cal 
AppSettings.Mps.RadER.TX_MaxDuration = 60; % maximum duration (sec) for T_X target cal 
AppSettings.Mps.RadER.GG_pad         = [0 120]; % pad on windows for gravity gradient attitudes - [start end]

% Dark Current Calibration (DCC) settings
AppSettings.Mps.DarkCurrent.DatAddress = 'https://cxc.cfa.harvard.edu/mta/ASPECT/dark_attitudes/dark_attitudes.dat'; % server location for the list of DCCs 
AppSettings.Mps.DarkCurrent.DefaultDuration = '10.0'; % default duration of each DCC OR
AppSettings.Mps.DarkCurrent.DefaultDither = 'ON,0.002222,0.360000,0.000000,0.002222,0.509100,0.000000'; % default dither parameters for DCCs
AppSettings.Mps.DarkCurrent.DefaultReplicaNum = '5'; % default number of DCC replicas

% Single Replica Dark Currents (SRDC)
AppSettings.Mps.SRDC.ATS='SRDC';
AppSettings.Mps.SRDC.CommPads=[8*60 20*60]; % [minimum time after comm start (sec), min time before EOT (sec)]
AppSettings.Mps.SRDC.NPMPads=[950 1866]; % Minimum pad times for NPM [sec after transition, sec before man]
AppSettings.Mps.SRDC.MUNLPads=[50 966]; % Minimum pad times for momentum unload [sec after dump end, sec before dump start]
AppSettings.Mps.SRDC.EclPads=[1866 1200]; % Minimum pad times for eclipse [sec before eclipse start, sec after eclipse end]
AppSettings.Mps.SRDC.PerigeePads=[2466 666]; % Minimum pad times for perigee [keepout start sec before perigee start, keepout end sec before perigee start]
AppSettings.Mps.SRDC.BlackoutStd = [5 10]; % [Start of EST blackout period in UTC hours, End of EST blackout period in UTC hours]
AppSettings.Mps.SRDC.BlackoutDst = [4 9]; % [Start of EDT blackout period in UTC hours, End of EDT blackout period in UTC hours]
AppSettings.Mps.SRDC.AcceptableCats = {'1A1'}; % Strings to search for in the DSN work category section. Only schedule SRDCs during comms containing these strings.

% Graphical OR display settings (Timeline & Remaining ORs)
AppSettings.Mps.Scheduler.MinimumSize=[180 42];

%Patch colors and positions for each instrument
AppSettings.Mps.Timeline.SI.names     = {  'ACIS-I', 'ACIS-S',   'HRC-I',   'HRC-S',  'NONE'};
AppSettings.Mps.Timeline.SI.color     = {  [0 0 1], [0.5 0.5 1], [1 0 0], [1 0.6 0.6],[1 1 1]};
AppSettings.Mps.Timeline.SI.textcolor = {0.8*[1 1 1], [0 0 0],   [0 0 0],   [0 0 0],  [0 0 0]};
AppSettings.Mps.Timeline.SI.yval      = .5;
AppSettings.Mps.Timeline.SI.barwidth  = 0.35;

%Patch color and positions for CTIs
AppSettings.Mps.Timeline.cti.color    = [1 1 0];
AppSettings.Mps.Timeline.cti.yval     = .3;
AppSettings.Mps.Timeline.cti.barwidth = 0.07;

%Patch color and positions for each grating
AppSettings.Mps.Timeline.grating.names    = {'LETG', 'HETG'};
AppSettings.Mps.Timeline.grating.color    = {[0 0 0], [1 1 1]};
AppSettings.Mps.Timeline.grating.yval     = .4;
AppSettings.Mps.Timeline.grating.barwidth = 0.06;

%Colors for gyro-hold targets
AppSettings.Mps.Timeline.gyro.color    = [0 0 0];
AppSettings.Mps.Timeline.gyro.yval     = .89;
AppSettings.Mps.Timeline.gyro.barwidth = .05;

%Colors for HRC regions
AppSettings.Mps.Timeline.hrc_region.allowed.color = [0, 0.65, 0];
AppSettings.Mps.Timeline.hrc_region.keepout.color = [1, 0.00, 0];
AppSettings.Mps.Timeline.hrc_region.allowed.yval = 0.675;
AppSettings.Mps.Timeline.hrc_region.keepout.yval = 0.4;
AppSettings.Mps.Timeline.hrc_region.barwidth = 0.275;

%Colors for single and segmented maneuvers
AppSettings.Mps.Timeline.manvr.colors = {[0 0 0],[0.4 0.4 0.4]};
AppSettings.Mps.Timeline.manvr.sunVioMarker = 'y*';
AppSettings.Mps.Timeline.acq.color = [.4 .8 .4];

%Colors for Manstart_delay
AppSettings.Mps.Timeline.manstart_delay.colors = {[.4, .32, .1],[1, .49, 0]};

%Set up orbit and radiation display
AppSettings.Mps.Timeline.rad.yval   = .05;
AppSettings.Mps.Timeline.rad.barwidth=.9;
AppSettings.Mps.Timeline.rad.color=[0 0 0];
AppSettings.Mps.Timeline.crm.color=[0 0 1];
AppSettings.Mps.Timeline.hrc_pad.color=[1 0 0];

AppSettings.Mps.Timeline.OE.names={'EAPOGEE','EPERIGEE',...
    'EEF1000','XEF1000','EERADpad',...
    'EQF003M','EQF013M', 'XQF003M','XQF013M',...
    'EQF003M','EQF013M', 'XQF003M','XQF013M',... % in twice to allow superimposed + and o
    'PENTRY','EONIGHT','EODAY','PEXIT','LENTRY','LEXIT',...
    'LSPENTRY','LSNIGHT','LSDAY','LSPEXIT'};
AppSettings.Mps.Timeline.OE.char={'k^','kv',...   % how are the items listed in names displayed
    'r*','g*','m*',...
    'r+','r+','g+','g+',...
    'ro','ro','go','go',...
    'ko','ko','yo','yo','yo','yo'...
    'ko','ko','yo','yo','yo','yo'}; 
AppSettings.Mps.Timeline.OE.yval = 0.1;

% set up comm display
AppSettings.Mps.Timeline.comm.marker='gx-';
AppSettings.Mps.Timeline.comm.yval=0.1;

% set up window displays
AppSettings.Mps.Timeline.windowMarker.color='y';
AppSettings.Mps.Timeline.windowMarker.yval=.9;

%set up constraint violation markers
AppSettings.Mps.Timeline.windowMarker.out='rx:';
AppSettings.Mps.Timeline.badStarMarker='pk';
AppSettings.Mps.Timeline.minDurationMarker='r>';
AppSettings.Mps.Timeline.maxDurationMarker='k<';
AppSettings.Mps.Timeline.maxManAngMarker='r<';
AppSettings.Mps.Timeline.momentumOut='cx';
AppSettings.Mps.Timeline.boresightOut='bx';
AppSettings.Mps.Timeline.spmOut='yx';
AppSettings.Mps.Timeline.thermalOut='mx';

% set up markers for ACTs or custom times events
AppSettings.Mps.Timeline.timedEvent.char='bd-.';
AppSettings.Mps.Timeline.timedEvent.yval=.2;

% set up markers for Comms 
AppSettings.Mps.Timeline.dsnComm.char='m.-';
AppSettings.Mps.Timeline.dsnComm.yval=.2;

% set up z-order for Timeline
% Stacking order (what's drawn on top of what, where higher
% numbers are on top)
AppSettings.Mps.Timeline.z_order.rad_zones = 0;
AppSettings.Mps.Timeline.z_order.hrc_pad = 0;
AppSettings.Mps.Timeline.z_order.acis_pad = 0.25;
AppSettings.Mps.Timeline.z_order.cti = 0.5;
AppSettings.Mps.Timeline.z_order.oe_markers = 0;
AppSettings.Mps.Timeline.z_order.custom_time_events = 2;
AppSettings.Mps.Timeline.z_order.start_end_times = 0;
AppSettings.Mps.Timeline.z_order.maneuvers = 1;
AppSettings.Mps.Timeline.z_order.ors = 1;
AppSettings.Mps.Timeline.z_order.sun_violations = 2;
AppSettings.Mps.Timeline.z_order.acquisitions = 0;
AppSettings.Mps.Timeline.z_order.acis_bias_box = 2;
AppSettings.Mps.Timeline.z_order.obsid_text = 1.25;
AppSettings.Mps.Timeline.z_order.sim_moves = 1;
AppSettings.Mps.Timeline.z_order.grating_moves = 0;
AppSettings.Mps.Timeline.z_order.out_of_win = 0;
AppSettings.Mps.Timeline.z_order.star_markers = 2.25;
AppSettings.Mps.Timeline.z_order.constraint_markers = 1;
AppSettings.Mps.Timeline.z_order.dsnComm = 1;
AppSettings.Mps.Timeline.z_order.gyro = 0.5;
AppSettings.Mps.Timeline.z_order.hrc_allowed = -1;
AppSettings.Mps.Timeline.z_order.hrc_keepout = -0.75;
AppSettings.Mps.Timeline.z_order.manstart_delay = 2;
% older settings
% AppSettings.Mps.Timeline.z_order.acis_pad = 0;
% AppSettings.Mps.Timeline.z_order.cti = 0;
% AppSettings.Mps.Timeline.z_order.oe_markers = 0;
% AppSettings.Mps.Timeline.z_order.acquisitions = -1;
% AppSettings.Mps.Timeline.z_order.obsid_text = 10;
% AppSettings.Mps.Timeline.z_order.star_markers = 2;
% AppSettings.Mps.Timeline.z_order.constraint_markers = 0;
% AppSettings.Mps.Timeline.z_order.dsnComm = 1;

% set up pool target display
AppSettings.Mps.PoolTargets.color=[.45 .62 .45];
AppSettings.Mps.DarkCurTargets.color=[.3 .3 .3];
AppSettings.Mps.PoolTargets.NormalSunTol=20;  % how close to 90 must a target stay to be "always bad"
AppSettings.Mps.PoolTargets.NormalSunColor=[0 1 0];
AppSettings.Mps.PoolTargets.marker='.';
AppSettings.Mps.PoolTargets.lpColor=[1 0 1];
AppSettings.Mps.PoolTargets.cctColor=[0 0 1];
if ispc
    AppSettings.Mps.PoolTargets.markerSize=14;
else
    AppSettings.Mps.PoolTargets.markerSize=16;
end
AppSettings.Mps.PoolFilter.Grating='NONE';
AppSettings.Mps.PoolFilter.FilterGrating=0;
AppSettings.Mps.PoolFilter.SI='ACIS-S';
AppSettings.Mps.PoolFilter.FilterSI=0;
AppSettings.Mps.PoolFilter.PitchMin=45;
AppSettings.Mps.PoolFilter.PitchMax=170;
AppSettings.Mps.PoolFilter.FilterPitch=0;
AppSettings.Mps.PoolFilter.TargetRA=0;
AppSettings.Mps.PoolFilter.TargetDec=0;
AppSettings.Mps.PoolFilter.TargetHalfWidth=3;
AppSettings.Mps.PoolFilter.FilterTarget=0;
AppSettings.Mps.PoolFilter.DurationMin=0;
AppSettings.Mps.PoolFilter.DurationMax=180000;
AppSettings.Mps.PoolFilter.FilterDuration=0;
AppSettings.Mps.PoolFilter.FilterSeqNum=0;
AppSettings.Mps.PoolFilter.SeqNum=0;
AppSettings.Mps.PoolFilter.FilterID=0;
AppSettings.Mps.PoolFilter.ID=0;
AppSettings.Mps.PoolFilter.FilterSImode=0;
AppSettings.Mps.PoolFilter.SImode='';
AppSettings.Mps.PoolFilter.FilterPrevSched=0;
AppSettings.Mps.PoolFilter.DegreesCCT=15;
AppSettings.Mps.PoolFilter.NumberCCT=10;

% set up constraints
AppSettings.Mps.Constraints.Stars.UpdateRadius = 0.001; % [deg] a move larger than this requires a new star cat
AppSettings.Mps.Constraints.Stars.Gui.MinPerMag = 9; 
AppSettings.Mps.Constraints.Stars.Gui.MinMagFull = 10.0; % min mag to be consider to get counted as 1 good star
AppSettings.Mps.Constraints.Stars.Gui.MinMag75 = 10.2; % min mag to be consider to get counted as 0.75 good star
AppSettings.Mps.Constraints.Stars.Gui.MinMagHalf = 10.3; % min mag to be consider to get counted as 0.5 good star
AppSettings.Mps.Constraints.Stars.Gui.MinNPer = 3.0; % minimum number of "good" stars for a perigee att
AppSettings.Mps.Constraints.Stars.Gui.MinNOR = 4.0; % minimum number of "good" stars for an OR
AppSettings.Mps.Constraints.Stars.Gui.MinNER = 6.0; % minimum number of "good" stars for an ER
AppSettings.Mps.Constraints.Stars.Acq.MinPerMag = 9; 
AppSettings.Mps.Constraints.Stars.Acq.MinMagFull = 10.0; % min mag to be consider to get counted as 1 good star
AppSettings.Mps.Constraints.Stars.Acq.MinMag75 = 10.2; % min mag to be consider to get counted as 0.75 good star
AppSettings.Mps.Constraints.Stars.Acq.MinMagHalf = 10.3; % min mag to be consider to get counted as 0.5 good star
AppSettings.Mps.Constraints.Stars.Acq.MinNPer = 3; % minimum number of "good" stars for a perigee att
AppSettings.Mps.Constraints.Stars.Acq.MinNOR = 4;  % minimum number of "good" stars for an OR
AppSettings.Mps.Constraints.Stars.Acq.MinNER = 5;  % minimum number of "good" stars for an ER
AppSettings.Mps.Constraints.Sun.color   = 'y';
AppSettings.Mps.Constraints.Earth.color = [0 0.8 0];
AppSettings.Mps.Constraints.Moon.color  = [0.7 0.3 0];
AppSettings.Mps.Constraints.Xray.color  = [.2 .2 .2];
AppSettings.Mps.Constraints.acis1.color = [1 .8 .5];
AppSettings.Mps.Constraints.acis2.color = [.85 .5 0];

% Colormap info
%  colormap - flip to get black high, white low for momentum map
AppSettings.Mps.Colormap_Info.colormap = [jet(64);flipud(bone(64))];
% AppSettings.Mps.Colormap_Info.mom_range =  ...
%         [length(AppSettings.Mps.Colormap_Info.colormap)/2+1 ...
%          length(AppSettings.Mps.Colormap_Info.colormap)];
AppSettings.Mps.Colormap_Info.mom_range =   ...
         [1 length(AppSettings.Mps.Colormap_Info.colormap)/2];
% AppSettings.Mps.Colormap_Info.gg_range =   ...
%         [length(AppSettings.Mps.Colormap_Info.colormap)/2+1 ...
%          length(AppSettings.Mps.Colormap_Info.colormap)];
 AppSettings.Mps.Colormap_Info.gg_range =   ...
         [1 length(AppSettings.Mps.Colormap_Info.colormap)/2];

AppSettings.Mps.Colormap_Info.star_range = ...
        [length(AppSettings.Mps.Colormap_Info.colormap)/2+1 ...
         length(AppSettings.Mps.Colormap_Info.colormap)];

% Star density map settings
AppSettings.Mps.Default_Star_Density_Map = 'mag_6.0_to_9.0_rad_0.7.fits';
AppSettings.Mps.Default_Min_Star_Density = 3.0;
AppSettings.Mps.Default_Star_Density_MeshStep = 0.2; % deg

AppSettings.Mps.transient_sched_fields = {'handles', 'Notifiers', ...
    'GUIsize', 'models', 'MCC_Plot', 'Preferences', 'Undo'};

% LIGER initial temps
AppSettings.Liger.Temps.Initial.Pline=70;
AppSettings.Liger.Temps.Initial.Momentum=10;
AppSettings.Liger.Temps.Initial.Pm1thv1t=140;
AppSettings.Liger.Temps.Initial.Pm2thv1t=140;

%Chandra low-power mode altitude threshold
AppSettings.dsn.lpmThreshold = 21050;

%DSN SOEs organized by data rates
AppSettings.dsn.soe.datarate.soeVals = {{'A','E','O','R'},...
    {'B','F','I','J','K','L','P','S'},...
    {'C','G','Q','T'}};
AppSettings.dsn.soe.datarate.dataRates = {1024, 512, 256};

%DSN SOEs organized separately by station number
AppSettings.dsn.soe.station.soeVals = {{'A','B','C','E','F','G','I','K'},...
    {'J','L','M','N','O','P','Q','R','S','T'}};
AppSettings.dsn.soe.station.dssNums = {[24 34 54], [15 26 36 56 65]};

%DSN config codes and the threshold for ranging (in minutes)
AppSettings.dsn.configCodes.nonRanging = 'N056';
AppSettings.dsn.configCodes.ranging = 'N064';
AppSettings.dsn.configCodes.rangingThreshold = 45;

%STK-box constants
AppSettings.stk.ipmain = '131.142.113.61';
AppSettings.stk.boxmain = 'MP';
AppSettings.stk.ipbackup = '131.142.113.62';
AppSettings.stk.boxbackup = 'Ops';
AppSettings.stk.socketnumber = '5001';
AppSettings.stk.socketname = 'STKSocket1';

%Default STK scenario
AppSettings.stk.defaultscenario = 'C:\Users\stkuser\Desktop\Scenarios\mission planning\Mission_Planning.sc';

%Comm GUI characteristics
AppSettings.CommGUI.spsRepoLocation = 'https://occweb.cfa.harvard.edu/occweb/FOT/operations/dsn_scheduling/sps_chdr_roving.txt';
AppSettings.CommGUI.schedDirWindows = '\\noodle\GRETA\mission\MissionPlanning\DSN\DSNweek';
AppSettings.CommGUI.schedDirGRETA = '/home/mission/MissionPlanning/DSN/DSNweek';
AppSettings.CommGUI.ifotWebBaseCFA = 'https://occweb.cfa.harvard.edu/occweb/web/webapps/ifot/ifot.php';
AppSettings.CommGUI.ifotWebBaseOCC = 'http://occweb.occ.harvard.edu/occweb/web/webapps/ifot/ifot.php';
AppSettings.CommGUI.spsWebBase = 'https://spsweb.fltops.jpl.nasa.gov/rest/ops/info/activity';
AppSettings.CommGUI.numFieldsTracked = 16;
AppSettings.CommGUI.defaultSubformat = 'NORM';

%approx man speed for use with proseco
AppSettings.Mps.EstManRate=0.075; % deg/sec

%Moving target characteristics
AppSettings.MTO.mtObjectTokens = {'JPL_HORIZONS_ID'}; % ORL token(s) for moving targets
AppSettings.MTO.decimalAccuracy = 6; % Decimal places to use when comparing ORV and JPL Horizons coordinates
AppSettings.MTO.hrzTimeoutSecs = 5; % Seconds before timing out the HTTP request to JPL Horizons

%Eclipse settings characteristics
AppSettings.eclSetting.eclipseBufferMins = 20; % Required eclipse attitude pad for either end of an eclipse (in minutes)

%FOT Request parameter characteristics
AppSettings.fotRequests.invalidParameters = {'/CMD','_SET','ACIS','SIMPKT','ACAPKT','EIOPKT'}; % Invalid FOT Request parameter blocks
AppSettings.fotRequests.validParameters = {'ATS'}; % Valid FOT Request parameter blocks
