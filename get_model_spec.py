"Load Xija Model Spec"
import json
import asciitable


def get_model_spec(model_name):
    """ Load model parameters from the associated file in the local directory

    :param model_name: name of model input as a string, this must match the model name used in the
                       json filename

    :returns: dictionary of xija model parameters, or recarray of pline guidelines
    
    """

    model_name = model_name.lower()

    if model_name not 'pline':
        filename = './' + model_name + '/' + model_name + '_spec.json'
        model_spec = json.load(open(filename, 'r'))

    else:
        filename = './pline/pline_guidelines.dat'
        guidelines = asciitable.read(filename)

    return model_spec