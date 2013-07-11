"""
Get Chandra model specifications
"""
import json
import os
from astropy.io import ascii

__all__ = ['get_xija_model_file', 'get_pline_guidelines']

FILEPATH = os.path.dirname(__file__)


def get_xija_model_file(model_name):
    """
    Get file name of Xija model specification for the specified ``model_name``.

    Supported model names are: ``'acisfp'``, ``'dea'``, ``'dpa'``,
    ``'psmc'``, ``'minusyz'``, and ``'pftank2t'``.

    Example::

      >>> import chandra_models
      >>> import xija
      >>> model_spec = chandra_models.get_xija_model_file('acisfp')
      >>> model = xija.XijaModel('acisfp', model_spec=model_spec,
                                   start='2012:001', stop='2012:010')
      >>> model.make()
      >>> model.calc()

    :param model_name: name of model
    :returns: file name of the corresponding Xija model specification
    """

    model_name = model_name.lower()
    file_name = os.path.abspath(os.path.join(FILEPATH, 'xija', model_name,
                                             '{}_spec.json'.format(model_name)))

    if not os.path.exists(file_name):
        raise ValueError('Model name {!r} ({!r}) does not exist'.format(model_name, file_name))

    return file_name


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
