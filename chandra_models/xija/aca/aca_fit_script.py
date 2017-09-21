# Licensed under a 3-clause BSD style license - see LICENSE.rst
import urllib
import json
from os.path import expanduser
import sys
import  pickle
from Ska.engarchive import fetch_eng as fetch
from xijafit import *
home = expanduser("~")
addthispath = home + '/AXAFLIB/fot_bad_intervals/'
sys.path.append(addthispath)
from fot_bad_intervals import get_keep_ind
import dashboard as dash

newmodel = XijaFit('./aacccdpt/aca_spec.json', set_data_exprs=(u'aca0=-14.0',), start='2014:001', stop='2017:001',
                   quiet=False, name='aacccdpt')

newmodel.set_param('solarheat__aca0__dP_45', 0.06)
newmodel.set_param('solarheat__aca0__dP_60', 0.06)
newmodel.set_param('solarheat__aca0__dP_75', 0.06)
newmodel.set_param('solarheat__aca0__dP_90', 0.06)
newmodel.set_param('solarheat__aca0__dP_110', 0.06)
newmodel.set_param('solarheat__aca0__dP_120', 0.06)
newmodel.set_param('solarheat__aca0__dP_130', 0.06)
newmodel.set_param('solarheat__aca0__dP_150', 0.06)
newmodel.set_param('solarheat__aca0__dP_170', 0.06)
newmodel.freeze_all()
newmodel.thaw_solarheat_p()
newmodel.fit(method='moncar')

newmodel.freeze_all()
newmodel.thaw_param(u'coupling__aacccdpt__aca0__tau')
newmodel.thaw_param(u'solarheat__aca0__ampl')
newmodel.fit(method='moncar')

newmodel.freeze_all()
newmodel.thaw_param(u'heatsink__aca0__T')
newmodel.thaw_param(u'heatsink__aca0__tau')
newmodel.fit(method='moncar')

newmodel.freeze_all()
newmodel.set_range('solarheat__aca0__dP_45', -0.5, 0.5)
newmodel.set_range('solarheat__aca0__dP_60', -0.5, 0.5)
newmodel.set_range('solarheat__aca0__dP_75', -0.5, 0.5)
newmodel.set_range('solarheat__aca0__dP_90', -0.5, 0.5)
newmodel.set_range('solarheat__aca0__dP_110', -0.5, 0.5)
newmodel.set_range('solarheat__aca0__dP_120', -0.5, 0.5)
newmodel.set_range('solarheat__aca0__dP_130', -0.5, 0.5)
newmodel.set_range('solarheat__aca0__dP_150', -0.5, 0.5)
newmodel.set_range('solarheat__aca0__dP_170', -0.5, 0.5)
newmodel.thaw_solarheat_dp()
newmodel.thaw_param(u'solarheat__aca0__ampl')
newmodel.fit(method='moncar')

newmodel.freeze_all()
newmodel.thaw_solarheat_p()
newmodel.thaw_param(u'coupling__aacccdpt__aca0__tau')
newmodel.fit(method='moncar')

newmodel.freeze_all()
newmodel.thaw_solarheat_dp()
newmodel.fit(method='moncar')

newmodel.write_spec_file()
newmodel.write_snapshots_file()



