"Load Xija Model Spec"
import json
import os
from astropy.io import ascii

__all__ = ['get_xija_model_spec', 'get_pline_guidelines']

FILEPATH = os.path.dirname(__file__)


def get_xija_model_spec(model_name):
    """
    Load Xija model parameters for the specified `model_name` string.

    Example::

      >>> model_spec = chandra_models.get_xija_model_spec('acisfp')
      >>> model = xija.XijaModel(model_spec=model_spec)

    :param model_name: name of model

    :returns: dict of Xija model spec
    """

    model_name = model_name.lower()
    filename = os.path.join(FILEPATH, 'xija', model_name,
                            '{}_spec.json'.format(model_name))
    model_spec = json.load(open(filename, 'r'))

    return model_spec


def get_pline_guidelines():
    """
    Load pline guidelines

    Example::

      >>> pline = chandra_models.get_pline_guidelines()
      >>> print pline
      warm_dwell warm_pitch_max dwell_156_162 dwell_156_166 dwell_156_170 dwell_170_180
      ---------- -------------- ------------- ------------- ------------- -------------
              30             80          9:20          7:50          4:20          0:00
              12             90          7:00          5:30          3:00          0:00
              10             90          6:15          5:10          2:40          0:00
               8             90          5:15          4:20          2:15          0:00
               8            110          5:00          4:15          2:00          0:00
               0            180          0:00          0:00          0:00          0:00


    :returns: Table of pline guidelines
    """
    filename = os.path.join(FILEPATH, 'pline', 'pline_guidelines.dat')
    dat = ascii.read(filename)

    return dat
