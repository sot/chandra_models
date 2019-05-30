# Licensed under a 3-clause BSD style license - see LICENSE.rst

import xija
import sys
from os.path import expanduser
import re

home = expanduser("~")
addthispath = home + '/AXAFLIB/xijafit/'
sys.path.insert(0, addthispath)
import xijafit


class XijaFitPatched(xijafit.XijaFit):


    def thaw_solarheat_p(self, msid):
        """Thaw all solarheat "P" parameters.
        """
        p = 'solarheat__{}__P_\d+'.format(msid.lower())
        found = False
        for par in self.model.pars:
            if re.match(p, par.full_name):
                par['frozen'] = False
                found = True
        if not found:
            print('Solarheat "P" parameters not found')

    def thaw_solarheat_dp(self, msid):
        """Thaw all solarheat "dP" parameters.
        """
        p = 'solarheat__{}__dP_\d+'.format(msid.lower())
        found = False
        for par in self.model.pars:
            if re.match(p, par.full_name):
                par['frozen'] = False
                found = True
        if not found:
            print('Solarheat "dP" parameters not found')

stars = '*'*80
n = 0

newmodel = XijaFitPatched('tcylaft6_spec_mod.json', start='2016:001', stop='2019:142', set_data_exprs=(u'cc0=30.0',), quiet=False, name='tcylaft6')
# newmodel.zero_solarheat_dp()

#-----------------------------------------------------------------------------
# Initial Solarheat Fit


n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_param(u'heatsink__cc0__tau')
newmodel.thaw_param(u'heatsink__cc0__T')
newmodel.thaw_param(u'heatsink__tcylaft6__tau')
newmodel.thaw_param(u'heatsink__tcylaft6__T')
newmodel.thaw_param(u'coupling__tcylaft6__cc0')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_p('cc0')
newmodel.thaw_param(u'solarheat__cc0__ampl')
newmodel.thaw_param(u'coupling__tcylaft6__cc0')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_p('tcylaft6')
newmodel.thaw_param(u'solarheat__tcylaft6__ampl')
newmodel.thaw_param(u'coupling__tcylaft6__cc0')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_param(u'heatsink__cc0__tau')
newmodel.thaw_param(u'heatsink__cc0__T')
newmodel.thaw_param(u'heatsink__tcylaft6__tau')
newmodel.thaw_param(u'heatsink__tcylaft6__T')
newmodel.thaw_param(u'coupling__tcylaft6__cc0')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_p('cc0')
newmodel.thaw_param(u'solarheat__cc0__ampl')
newmodel.thaw_param(u'coupling__tcylaft6__cc0')
newmodel.thaw_param(u'solarheat_off_nom_roll__cc0__P_plus_y')
newmodel.thaw_param(u'solarheat_off_nom_roll__cc0__P_minus_y')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_p('tcylaft6')
newmodel.thaw_param(u'solarheat__tcylaft6__ampl')
newmodel.thaw_param(u'coupling__tcylaft6__cc0')
newmodel.thaw_param(u'solarheat_off_nom_roll__tcylaft6__P_plus_y')
newmodel.thaw_param(u'solarheat_off_nom_roll__tcylaft6__P_minus_y')
newmodel.fit(method='moncar')

#-----------------------------------------------------------------------------
# Initial DP Solarheat Fit

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_dp('cc0')
newmodel.thaw_param(u'solarheat__cc0__ampl')
newmodel.fit(method='moncar')

#-----------------------------------------------------------------------------
# Second Solarheat Fit

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_p('cc0')
newmodel.thaw_param(u'solarheat__cc0__ampl')
newmodel.thaw_param(u'coupling__tcylaft6__cc0')
newmodel.thaw_param(u'solarheat_off_nom_roll__cc0__P_plus_y')
newmodel.thaw_param(u'solarheat_off_nom_roll__cc0__P_minus_y')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_p('tcylaft6')
newmodel.thaw_param(u'solarheat__tcylaft6__ampl')
newmodel.thaw_param(u'coupling__tcylaft6__cc0')
newmodel.thaw_param(u'solarheat_off_nom_roll__tcylaft6__P_plus_y')
newmodel.thaw_param(u'solarheat_off_nom_roll__tcylaft6__P_minus_y')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_param(u'heatsink__cc0__tau')
newmodel.thaw_param(u'heatsink__cc0__T')
newmodel.thaw_param(u'heatsink__tcylaft6__tau')
newmodel.thaw_param(u'heatsink__tcylaft6__T')
newmodel.thaw_param(u'coupling__tcylaft6__cc0')
newmodel.fit(method='moncar')

#-----------------------------------------------------------------------------
# Second DP Solarheat Fit
n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_dp('cc0')
newmodel.thaw_param(u'solarheat__cc0__ampl')
newmodel.fit(method='moncar')

#-----------------------------------------------------------------------------
# Third DP Solarheat Fit

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_dp('cc0')
newmodel.thaw_param(u'solarheat__cc0__ampl')
newmodel.fit(method='moncar')

#-----------------------------------------------------------------------------
# Third Solarheat Fit

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_p('cc0')
newmodel.thaw_solarheat_roll()
newmodel.thaw_param(u'solarheat__cc0__ampl')
newmodel.thaw_param(u'coupling__tcylaft6__cc0')
newmodel.thaw_param(u'solarheat_off_nom_roll__cc0__P_plus_y')
newmodel.thaw_param(u'solarheat_off_nom_roll__cc0__P_minus_y')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_solarheat_p('tcylaft6')
newmodel.thaw_param(u'solarheat__tcylaft6__ampl')
newmodel.thaw_param(u'coupling__tcylaft6__cc0')
newmodel.thaw_param(u'solarheat_off_nom_roll__tcylaft6__P_plus_y')
newmodel.thaw_param(u'solarheat_off_nom_roll__tcylaft6__P_minus_y')
newmodel.fit(method='moncar')

n = n + 1
print('{}\nStep {}\n{}'.format(stars, n, stars))
newmodel.freeze_all()
newmodel.thaw_param(u'heatsink__cc0__tau')
newmodel.thaw_param(u'heatsink__cc0__T')
newmodel.thaw_param(u'heatsink__tcylaft6__tau')
newmodel.thaw_param(u'heatsink__tcylaft6__T')
newmodel.thaw_param(u'coupling__tcylaft6__cc0')
newmodel.fit(method='moncar')

# These changes were made in the Jupyter notebook:
#
# ind = names.index('solarheat__cc0__P_160')
# newmodel.model.pars[ind]['val'] = -0.25
# ind = names.index('solarheat__cc0__P_170')
# newmodel.model.pars[ind]['val'] = -0.4
# ind = names.index('solarheat__cc0__dP_170')
# newmodel.model.pars[ind]['val'] = 0.11

newmodel.write_spec_file()
newmodel.write_snapshots_file()


