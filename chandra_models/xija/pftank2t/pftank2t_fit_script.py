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

newmodel = xijafit.XijaFit('pftank2t_model_spec.json', start='2014:001', stop='2018:200',
    set_data_exprs=(u'pf0tank2t=30.0',), quiet=False, name='pftank2t')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_param(u'heatsink__pf0tank2t__tau')
newmodel.thaw_param(u'heatsink__pf0tank2t__T')
newmodel.thaw_param(u'coupling__pftank2t__pf0tank2t')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_p()
newmodel.thaw_param(u'coupling__pftank2t__pf0tank2t__tau')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_param(u'solarheat__pf0tank2t__ampl')
newmodel.thaw_solarheat_roll()
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_param(u'heatsink__pf0tank2t__tau')
newmodel.thaw_param(u'heatsink__pf0tank2t__T')
newmodel.thaw_param(u'coupling__pftank2t__pf0tank2t')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_p()
newmodel.thaw_param(u'coupling__pftank2t__pf0tank2t__tau')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_dp()
newmodel.thaw_param(u'solarheat__pf0tank2t__ampl')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_p()
newmodel.thaw_param(u'coupling__pftank2t__pf0tank2t__tau')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_param(u'solarheat__pf0tank2t__ampl')
newmodel.thaw_solarheat_roll()
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_param(u'heatsink__pf0tank2t__tau')
newmodel.thaw_param(u'heatsink__pf0tank2t__T')
newmodel.thaw_param(u'coupling__pftank2t__pf0tank2t')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_dp()
newmodel.thaw_param(u'solarheat__pf0tank2t__ampl')
newmodel.fit(method='moncar')

newmodel.write_spec_file()
newmodel.write_snapshots_file()

