#!/usr/bin/env python
# Licensed under a 3-clause BSD style license - see LICENSE.rst

"""
Compute and plot the PFTANK2T settling temperature as a function of pitch and time::

  usage: calc_settling_temp.py [-h] [--model_spec MODEL_SPEC]
                               [--start-year START_YEAR] [--stop-year STOP_YEAR]
                               [--dt-year DT_YEAR] [--plot-file PLOT_FILE]

  Calculate PFTANK2T model settling temperatures

  optional arguments:
    -h, --help            show this help message and exit
    --model_spec MODEL_SPEC
                          Input Xija model spec file
                          (default=pftank2t_spec.json)
    --start-year START_YEAR
                          Starting year (float, default=2014.0)
    --stop-year STOP_YEAR
                          Stop year (float, default=2016.0)
    --dt-year DT_YEAR     Delta year (float, default=0.5)
    --plot-file PLOT_FILE
                          Output plot file (default=None)
"""

import argparse

import numpy as np
import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt

import json
import xija
from Chandra.Time import DateTime


def get_opt():
    parser = argparse.ArgumentParser(description='Calculate PFTANK2T model settling temperatures')
    parser.add_argument('--model_spec',
                        default='pftank2t_spec.json',
                        type=str,
                        help='Input Xija model spec file (default=pftank2t_spec.json)')

    parser.add_argument('--start-year',
                        type=float,
                        default=2014.0,
                        help='Starting year (float, default=2014.0)')

    parser.add_argument('--stop-year',
                        type=float,
                        default=2016.0,
                        help='Stop year (float, default=2016.0)')

    parser.add_argument('--dt-year',
                        type=float,
                        default=0.5,
                        help='Delta year (float, default=0.5)')

    parser.add_argument('--plot-file',
                        help='Output plot file (default=None)')

    args = parser.parse_args()
    return args


def calc_model(start, pitch, model_spec):
    stop = DateTime(start) + 10
    model = xija.ThermalModel('pftank2t', start=start, stop=stop,
                              model_spec=model_spec)

    model.comp['eclipse'].set_data(False)
    model.comp['pitch'].set_data(pitch)
    model.comp['pf0tank2t'].set_data(35.0)
    model.comp['pftank2t'].set_data(35.0)

    model.make()
    model.calc()
    return model


def main():
    opt = get_opt()
    pitchs = list(range(45, 170, 5))
    model_spec = json.load(open(opt.model_spec, 'r'))

    plt.close(1)
    plt.figure(1, figsize=(6, 4))

    years = np.arange(opt.start_year, opt.stop_year + 0.0001, opt.dt_year)
    times = DateTime(years, format='frac_year').secs

    for tstart in times:
        pitch_temps = []
        for pitch in pitchs:
            model = calc_model(tstart, pitch, model_spec)
            pitch_temps.append(model.comp['pftank2t'].mvals[-1])
        pitch_temps = np.array(pitch_temps) * 1.8 + 32  # In degF
        label = '{}'.format(DateTime(tstart).date[:8])
        plt.plot(pitchs, pitch_temps, lw=1.5, label=label)

    plt.legend(loc='best')
    plt.grid('on')
    plt.ylabel('PFTANK2T (degF)')
    plt.title('Tank settling temperature')
    plt.tight_layout()
    plt.legend(loc='best')
    if opt.plot_file:
        plt.savefig(opt.plot_file)

if __name__ == '__main__':
    main()
