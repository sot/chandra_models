# Licensed under a 3-clause BSD style license - see LICENSE.rst
import numpy as np
import matplotlib.pyplot as plt

import xija
from Chandra.Time import DateTime
from kadi import events

start = '2014:200'
stop = '2015:150'

model = xija.XijaModel('acisfp', model_spec='acisfp_dh_spec.json',
                       start=start, stop=stop)
model.make()

shcb = model.comp['solarheat__1cbat']
fptemp = model.comp['fptemp']
dh = model.comp['dh_heater']

# Calculate model with best fit dh_heater bias
model.calc()
dt_best = (fptemp.dvals - fptemp.mvals)

# Force bias to 0
shcb.dh_heater_bias = 0.0
model.calc()
dt_zero = (fptemp.dvals - fptemp.mvals)

science_times = (~events.rad_zones(pad=3600)).intervals(start, stop)
science = np.zeros(len(dt_best), dtype=bool)
for date0, date1 in science_times:
    t0, t1 = DateTime([date0, date1]).secs
    i0, i1 = np.searchsorted(model.times, [t0, t1])
    science[i0:i1] = True

off_heater = fptemp.dvals > -119.0

ok0 = science & off_heater & dh.dvals
ok1 = science & off_heater & ~dh.dvals
bins = np.arange(-3, 3, 0.1)

print('Mean for DH heater bias = 0 when heater ON  = {:.2f}'.format(dt_zero[ok0].mean()))
print('Mean for best fit DH heater bias when heater ON  = {:.2f}'.format(dt_best[ok0].mean()))
print('Mean for best fit DH heater bias when heater OFF = {:.2f}'.format(dt_zero[ok1].mean()))

print('1% for DH heater bias = 0 when heater ON  = {:.2f}'.format(np.percentile(dt_zero[ok0], 1)))
print('1% for best fit DH heater bias when heater ON  = {:.2f}'.format(np.percentile(dt_best[ok0], 1)))
print('1% for best fit DH heater bias when heater OFF = {:.2f}'.format(np.percentile(dt_zero[ok1], 1)))

print('99% for DH heater bias = 0 when heater ON  = {:.2f}'.format(np.percentile(dt_zero[ok0], 99)))
print('99% for best fit DH heater bias when heater ON  = {:.2f}'.format(np.percentile(dt_best[ok0], 99)))
print('99% for best fit DH heater bias when heater OFF = {:.2f}'.format(np.percentile(dt_zero[ok1], 99)))

plt.figure(1, figsize=(7, 9))
plt.clf()

plt.subplot(3, 1, 1)
plt.hist(dt_zero[ok0], bins=bins, facecolor='r')
plt.grid()
plt.title('Data-model for DH heater bias = 0 when heater ON')

plt.subplot(3, 1, 2)
plt.hist(dt_best[ok0], bins=bins, facecolor='b', alpha=0.5)
plt.grid()
plt.title('Data-model for best fit DH heater bias when heater ON')

plt.subplot(3, 1, 3)
plt.hist(dt_best[ok1], bins=bins, facecolor='g', alpha=0.5)
plt.grid()
plt.title('Data-model for best fit DH heater bias when heater OFF')
plt.tight_layout()
plt.savefig('acisfp_dh_resid_hist.png')

plt.figure(2, figsize=(7, 9))
plt.clf()

plt.subplot(3, 1, 1)
plt.plot(fptemp.dvals[ok0], dt_zero[ok0], 'r.', alpha=0.3)
plt.grid()
plt.title('Data-model vs data for DH heater bias = 0 when heater ON')
plt.ylim(-2.5, 2.5)

plt.subplot(3, 1, 2)
plt.plot(fptemp.dvals[ok0], dt_best[ok0], 'b.', alpha=0.3)
plt.grid()
plt.title('Data-model vs data for best fit DH heater bias when heater ON')
plt.ylim(-2.5, 2.5)

plt.subplot(3, 1, 3)
plt.plot(fptemp.dvals[ok1], dt_best[ok1], 'g.', alpha=0.3)
plt.grid()
plt.title('Data-model vs data for best fit DH heater bias when heater OFF')
plt.xlabel('FPTEMP_11 (C)')
plt.ylim(-2.5, 2.5)

plt.tight_layout()
plt.savefig('acisfp_dh_resid_scat.png')
