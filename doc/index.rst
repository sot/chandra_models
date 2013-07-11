.. chandra_models documentation master file, created by
   sphinx-quickstart on Wed Jul 10 13:53:48 2013.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Documentation for Chandra Models
================================

Provides a consolidated home for Chandra model specifications, and in particular the
flight-approved Xija thermal models.  This package has the actual model specification
files and a simple accessor method to get the spec by name.

The intent is to remove duplication and potential for mismatches in model versions that
are being used.  Xija models are currently used in revision controlled code for:

- FOT MCC thermal checks
- SOT thermal checks
- Pyger calculations
- Xija itself (in the models/ directory)

This package provides a mechanism to migrate all of those codes away from using "private"
versions of the models to the common flight-approved versions contained here.

.. Contents:

.. toctree::
   :maxdepth: 2


Chandra Model Definitions
=========================

Xija
----
ACIS Focal Plane
    :Description: Thermal model of the ACIS focal plane.
    :Model Name: 'acisfp'
    :MSIDs: FPTEMP_11
ACIS DEA
    :Description: Thermal model of the ACIS DEA unit.
    :Model Name: 'dea'
    :MSIDs: 1DEAMZT
ACIS DPA
    :Description: Thermal model of the ACIS DPA unit.
    :Model Name: 'dpa'
    :MSIDs: 1DPAMZT
ACIS PSMC
    :Description: Thermal model of the ACIS PSMC, located on the -Z side of the ISIM, facing the +X direction
    :Model Name: 'psmc'
    :MSIDs: 1PDEAAT
Minus-YZ
    :Description: Thermal model of several locations on the -Z side of the spacecraft module.
    :Model Name: 'minusyz'
    :MSIDs: TEPHIN, TCYLAFT6, PMTANK3T, TMZP_MY
IPS Fuel Tank
    :Description: Thermal model of a location on the center of the IPS Fuel Tank.
    :Model Name: 'pftank2t'
    :MSIDs: PFTANK2T

PLINE
-----

Propulsion Fuel Lines
    :Description: Guidelines for ensuring adequate heating of the -Z propulsion fuel lines prior to dwells aft of 156 degrees pitch to prevent these lines from freezing.


Examples
========

Retrieving and Using Xija Model Spec
------------------------------------
To use the installed flight models::

  >>> import chandra_models
  >>> import xija
  >>> model_spec = chandra_models.get_xija_model_file('acisfp')
  >>> model = xija.XijaModel('acisfp', model_spec=model_spec,
                             start='2012:001', stop='2012:010')
  >>> model.make()
  >>> model.calc()

Migrating code to use chandra_models
--------------------------------------

SOT check tools
^^^^^^^^^^^^^^^^^^^

The SOT thermal check tools generally have a ``--model-spec`` option
that specifies the default spec file name.  For instance::

    parser.add_option("--model-spec",
                      default=os.path.join(TASK_DATA, 'acisfp_spec.json'),
                       help="ACIS FOCAL PLANE model specification file")

The updated version would look like::

    parser.add_option("--model-spec",
                      default=chandra_models.get_xija_model_file('acisfp'),
                       help="ACIS FOCAL PLANE model specification file")

No command line options
^^^^^^^^^^^^^^^^^^^^^^^^^

A code like ``pyger`` doesn't have any command line option to specify particular
model spec files, it's hardwired::

  class ConstraintTank(ConstraintModel):
      def __init__(self, sim_inputs, limits, max_dwell_ksec):
          model_spec = os.path.join(pkg_dir, 'pftank2t_model_spec.json')

The new version would look like::

  class ConstraintTank(ConstraintModel):
      def __init__(self, sim_inputs, limits, max_dwell_ksec):
          model_spec = chandra_models.get_xija_model_file('pftank2t')

So how do you override the flight-approved versions for testing development models?
Assume you maintain your git repositories in ``$HOME/git``.  You would first clone the
``chandra_models`` repo as follows::

  % cd ~/git
  % git clone https://github.com/sot/chandra_models.git
  % cd chandra_models/chandra_models/xija

Then you modify the model file of interest, perhaps by running Xija `gui_fit.py`
or something similar.

To use that file to test your application (for instance ``pyger.py``)
you would then do::

  % setenv PYTHONPATH $HOME/git/chandra_models
  % cd ~/git/pyger
  % ./pyger.py ...

It's a very good idea in this case to have some debug logging output that
gives the actual name of the model spec file that was used.  In fact this
is a good idea for every thermal check tool.

Note that a power Python-user would use a virtualenv instead of ``PYTHONPATH``, but
that's another story.

Retrieving PLINE Guidelines
---------------------------
::

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


API documentation
===================

.. automodule:: chandra_models.get_model_spec
   :members:
