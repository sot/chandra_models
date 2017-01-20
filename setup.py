from setuptools import setup

from chandra_models import __version__

setup(
    name='chandra_models',
    version=__version__,
    author='Matthew Dahmer',
    author_email='matthew.dahmer@gmail.com',
    packages=['chandra_models'],
    url='http://cxc.cfa.harvard.edu/mta/ASPECT/tool_doc/chandra_models/',
    license='BSD',
    description='Repository for Chandra model specification files',
    long_description=open('README').read(),
    package_data={'chandra_models': ['xija/*/*.json']},
)
