# Licensed under a 3-clause BSD style license - see LICENSE.rst
import xijafit

newmodel = xijafit.XijaFit('tcylaft6_model_spec_roll_base.json', set_data_exprs=(u'tcylaft6_0=22.0',),
   start='2014:300', stop='2016:300', quiet=False, name='tcylaft6')

newmodel.freeze_all()
newmodel.thaw_solarheat_p()
newmodel.thaw_solarheat_roll()
newmodel.thaw_param(u'coupling__tcylaft6__tcylaft6_0__tau')
newmodel.thaw_param(u'solarheat__tcylaft6_0__ampl')
newmodel.fit(method='moncar')

newmodel.freeze_all()
newmodel.thaw_param(u'heatsink__tcylaft6_0__T')
newmodel.thaw_param(u'heatsink__tcylaft6_0__tau')
newmodel.fit(method='moncar')

newmodel.freeze_all()
newmodel.set_range('solarheat__tcylaft6_0__dP_45', -0.5, 0.5)
newmodel.set_range('solarheat__tcylaft6_0__dP_60', -0.5, 0.5)
newmodel.set_range('solarheat__tcylaft6_0__dP_80', -0.5, 0.5)
newmodel.set_range('solarheat__tcylaft6_0__dP_90', -0.5, 0.5)
newmodel.set_range('solarheat__tcylaft6_0__dP_100', -0.5, 0.5)
newmodel.set_range('solarheat__tcylaft6_0__dP_110', -0.5, 0.5)
newmodel.set_range('solarheat__tcylaft6_0__dP_120', -0.5, 0.5)
newmodel.set_range('solarheat__tcylaft6_0__dP_130', -0.5, 0.5)
newmodel.set_range('solarheat__tcylaft6_0__dP_140', -0.5, 0.5)
newmodel.set_range('solarheat__tcylaft6_0__dP_150', -0.5, 0.5)
newmodel.set_range('solarheat__tcylaft6_0__dP_160', -0.5, 0.5)
newmodel.set_range('solarheat__tcylaft6_0__dP_180', -0.5, 0.5)
newmodel.thaw_solarheat_dp()
newmodel.thaw_param(u'solarheat__tcylaft6_0__ampl')
newmodel.fit(method='moncar')

newmodel.update_fit_times(start='2013:300', stop='2016:300')
# The next three lines were run but are redundant with the following group of fitting commands.
newmodel.freeze_all()
newmodel.thaw_solarheat_p()
newmodel.fit(method='moncar')

newmodel.freeze_all()
newmodel.thaw_solarheat_p()
newmodel.thaw_solarheat_roll()
newmodel.thaw_param(u'coupling__tcylaft6__tcylaft6_0__tau')
newmodel.fit(method='moncar')

newmodel.freeze_all()
newmodel.thaw_solarheat_dp()
newmodel.fit(method='moncar')

newmodel.write_spec_file()
newmodel.write_snapshots_file()