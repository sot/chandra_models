from distutils.core import setup

from chandra_models.version import __version__

setup(
    name='xija_models',
    version=__version__,
    author='Matthew Dahmer',
    author_email='matthew.dahmer@gmail.com',
    packages=['chandra_models'],
    url='http://cxc.cfa.harvard.edu/mta/ASPECT/tool_doc/xija/',
    license='BSD',
    description='Repository for Chandra model parameter files.',
    long_description=open('README').read(),
    package_data={'chandra_models': ['xija/*/*.json']},
)
