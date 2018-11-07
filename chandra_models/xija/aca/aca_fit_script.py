# Licensed under a 3-clause BSD style license - see LICENSE.rst

import xija
import sys
from os.path import expanduser

home = expanduser("~")
addthispath = home + '/AXAFLIB/xijafit/'
sys.path.insert(0, addthispath)
import xijafit

stars = '*'*80
n = 0

newmodel = xijafit.XijaFit('aca_model_spec.json', start='2014:001', stop='2018:300',
    set_data_exprs=(u'aca0=12.0',), quiet=False, name='aacccdpt')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_param(u'heatsink__aca0__tau')
newmodel.thaw_param(u'heatsink__aca0__T')
newmodel.thaw_param(u'coupling__aacccdpt__aca0')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_p()
newmodel.thaw_param(u'coupling__aacccdpt__aca0__tau')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_param(u'solarheat__aca0__ampl')
# newmodel.thaw_solarheat_roll()
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_param(u'heatsink__aca0__tau')
newmodel.thaw_param(u'heatsink__aca0__T')
newmodel.thaw_param(u'coupling__aacccdpt__aca0')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_p()
newmodel.thaw_param(u'coupling__aacccdpt__aca0__tau')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_dp()
newmodel.thaw_param(u'solarheat__aca0__ampl')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_p()
newmodel.thaw_param(u'coupling__aacccdpt__aca0__tau')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_param(u'solarheat__aca0__ampl')
# newmodel.thaw_solarheat_roll()
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_param(u'heatsink__aca0__tau')
newmodel.thaw_param(u'heatsink__aca0__T')
newmodel.thaw_param(u'coupling__aacccdpt__aca0')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_dp()
newmodel.thaw_param(u'solarheat__aca0__ampl')
newmodel.fit(method='moncar')

newmodel.write_spec_file()
newmodel.write_snapshots_file()

newmodel = xijafit.XijaFit('aacccdpt_model_spec.json', start='2018:270', stop='2018:305',
    set_data_exprs=(u'aca0=-11.0',), quiet=False, name='aacccdpt')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_param(u'step_power__aca0__P')
newmodel.fit(method='moncar')

newmodel.write_spec_file()
newmodel.write_snapshots_file()

