
import xija
from subprocess import Popen as popen

import xijafit

# The python Xija model conversion layer is used to ensure a clean model definition is used.
fueltank = xijafit.XijaFit('pftank2t_spec_prod_roll.json', set_data_exprs=(u'pf0tank2t=22.0',),
   quiet=False, name='pftank2t', start='2013:300', stop='2016:300')
fueltank.model.write('model_conversion.py')
print popen("python model_conversion.py pftank2t_spec_prod_roll.json", shell=True,
   stdout=subprocess.PIPE)

# Fit the model
fueltank = xijafit.XijaFit('pftank2t_spec_prod_roll.json', set_data_exprs=(u'pf0tank2t=22.0',),
   quiet=False, name='pftank2t', start='2013:300', stop='2016:300')
fueltank.freeze_all()
fueltank.thaw_solarheat_p()
fueltank.thaw_solarheat_roll()
fueltank.thaw_param(u'coupling__pftank2t__pf0tank2t__tau')
fueltank.fit(method='moncar')

fueltank.freeze_all()
fueltank.thaw_param(u'solarheat__pf0tank2t__ampl')
fueltank.fit(method='moncar')

fueltank.freeze_all()
fueltank.thaw_solarheat_p()
fueltank.thaw_solarheat_roll()
fueltank.thaw_param(u'coupling__pftank2t__pf0tank2t__tau')
fueltank.fit(method='moncar')

pftank2t_model_spec_roll_2016322.json
fueltank.write_spec_file(filename='pftank2t_model_spec_roll_2016322.json')
fueltank.write_snapshots_file(filename='pftank2t_snapshots_2016322.json')