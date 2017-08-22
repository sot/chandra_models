
import xija
from subprocess import Popen, PIPE

import xijafit

# The python Xija model conversion layer is used to ensure a clean model definition is used.
fueltank = xijafit.XijaFit('pftank2t_spec.json', set_data_exprs=(u'pf0tank2t=22.0',),
   quiet=False, name='pftank2t', start='2014:190', stop='2017:190')
fueltank.model.write('model_conversion.py')
print(Popen("python model_conversion.py pftank2t_spec_new.json", shell=True,
            stdout=PIPE))

# Fit the model
fueltank = xijafit.XijaFit('pftank2t_spec_new.json', set_data_exprs=(u'pf0tank2t=22.0',),
   quiet=False, name='pftank2t', start='2014:190', stop='2017:190')
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

fueltank.freeze_all()
fueltank.thaw_solarheat_dp()
fueltank.thaw_param(u'solarheat__pf0tank2t__ampl')
fueltank.fit(method='moncar')

fueltank.freeze_all()
fueltank.thaw_solarheat_p()
fueltank.thaw_solarheat_roll()
fueltank.thaw_param(u'coupling__pftank2t__pf0tank2t__tau')
fueltank.fit(method='moncar')

fueltank.write_spec_file(filename='pftank2t_model_spec_roll_2017202.json')
fueltank.write_snapshots_file(filename='pftank2t_snapshots_2017202.json')
