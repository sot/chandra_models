"Load Xija Model Spec"
import json
import os
import asciitable


filepath = os.path.dirname(__file__)

def get_model_spec(model_name):
    """ Load model parameters from the associated file in the local directory

    :param model_name: name of model input as a string, this must match the model name used in the
                       json filename

    :returns: dictionary of xija model parameters, or recarray of pline guidelines
    
    """

    model_name = model_name.lower()

    if model_name != 'pline':
        filename = model_name + '/' + model_name + '_spec.json'
        fullfilename = os.path.join(filepath, filename)
        model_spec = json.load(open(fullfilename, 'r'))

    else:
        filename = 'pline/pline_guidelines.dat'
        fullfilename = os.path.join(filepath, filename)
        model_spec = asciitable.read(fullfilename)

    return model_spec