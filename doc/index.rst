.. chandra_models documentation master file, created by
   sphinx-quickstart on Wed Jul 10 13:53:48 2013.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Documentation for Chandra Models
================================

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
    >>> model_spec = chandra_models.get_xija_model_spec('acisfp')
    >>> model = xija.XijaModel(model_spec=model_spec)


Retrieving PLINE Guidelines
---------------------------
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


.. Indices and tables
.. ==================
.. 
.. * :ref:`genindex`
.. * :ref:`modindex`
.. * :ref:`search`

