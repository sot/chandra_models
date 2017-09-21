# Licensed under a 3-clause BSD style license - see LICENSE.rst
"""Sample code for calculating the ACIS FP Xija model.

This shows necessary inputs and runs without using the eng archive.
The model prediction is completely wrong because all values are
set to a constant in this example instead of the correct time-varying
values.
"""

import xija
import Ska.engarchive.fetch_eng as fetch_eng
from Ska.Matplotlib import plot_cxctime

start = '2012:001'
stop = '2012:005'

model = xija.XijaModel('psmc', model_spec='psmc_spec.json',
                       start=start, stop=stop)

## PREDICTED COMPONENTS

# Use MSID values from telemetry to initialize if available
model.comp['1pdeaat'].set_data(20.0)
model.comp['pin1at'].set_data(20.0)

## INPUT DATA COMPONENTS

# These initializations are used needed for predicting into the future.
# For analyzing back-orbit data, do not set any of these and let xija
# grab the right values from telemetry.

# All the usual values here
model.comp['pitch'].set_data(130)
model.comp['sim_z'].set_data(75000)
model.comp['ccd_count'].set_data(6)
model.comp['fep_count'].set_data(6)
model.comp['vid_board'].set_data(1)
model.comp['clocking'].set_data(1)
model.comp['dpa_power'].set_data(0.0)

# Detector housing heater.  Set to True for heater ON, False for heater OFF.
model.comp['dh_heater'].set_data(True)

model.make()
model.calc()

# Note the telemetry MSID is fptemp_11 but the Node name is fptemp
pdeaat = fetch_eng.Msid('1pdeaat', start, stop)  # DEGC

plot_cxctime(model.times, model.comp['1pdeaat'].mvals, 'r-')
plot_cxctime(pdeaat.times, pdeaat.vals, 'b-')
