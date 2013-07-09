"Load Xija Model Spec"
import json
import os


filepath = os.path.dirname(__file__)


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
    filename = os.path.join(filepath, 'xija', model_name,
                            '{}_spec.json'.format(model_name))
    model_spec = json.load(open(filename, 'r'))

    return model_spec
