from distutils.core import setup
import os

__version__ = open(os.path.join(os.path.dirname(__file__),
                                'chandra_models/VERSION')).read().strip()

setup(
    name='chandra_models',
    version='0.1',
    author='Matthew Dahmer',
    author_email='matthew.dahmer@gmail.com',
    packages=['chandra_models'],
    url='http://cxc.cfa.harvard.edu/mta/ASPECT/tool_doc/xija/',
    license='BSD',
    description='Repository for Chandra model parameter files.',
    long_description=open('README.txt').read(),
)