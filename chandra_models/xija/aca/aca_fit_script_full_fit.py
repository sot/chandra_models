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

newmodel = xijafit.XijaFit('aca_spec_new.json', start='2018:001', stop='2022:100',
    set_data_exprs=(u'aca0=-10.0',), quiet=False, name='aacccdpt')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()

newmodel.thaw_solarheat_p()
newmodel.thaw_solarheat_dp()
newmodel.thaw_param(u'solarheat__aca0__ampl')

newmodel.thaw_param(u'heatsink__aca0__tau')
newmodel.thaw_param(u'heatsink__aca0__T')

newmodel.thaw_param(u'coupling__aacccdpt__aca0')

newmodel.thaw_param(u'fa6_enab__aca0')

newmodel.fit(method='moncar')

newmodel.write_spec_file('.aca_spec_new_mod.json')
newmodel.write_snapshots_file('./aca_spec_new_mod_snapshots.json')


