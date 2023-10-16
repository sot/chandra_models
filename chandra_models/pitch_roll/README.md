# Pitch-roll constraint file

The `pitch_roll_constraint.csv` file was derived from the table here:

https://chandramission.slack.com/archives/C01RQMDDB0B/p1677253910876059?thread_ts=1677090228.667049&cid=C01RQMDDB0B

This table is intended to be linearly interpolated to most closely match the pitch-roll
constraint implemented by MCC in ORviewer. Regions of stair-step constraints (pure
horizontal or vertical lines) are represented like below:
```
145.00000000000000000000,17.088
149.99999999999997157829,17.088
150.00000000000000000000,18.749
151.01999999999998181011,18.749
```

For pitch values outside the given range in the table, applications should extrapolate
the end value -1.000 for allowed off-nominal roll.

Applications checking for allowed off-nominal roll should use a less than or equal
comparison, i.e. `abs(computed_off_nom_roll) <= allowed_off_nom_roll`. The negative
`-1.000` values at the ends correspond to disallowed pitch regions.

The first and last pitch values correspond to the allowed *planning* range of pitch
angle (to within 3e-14 deg).

## Changes from original download on Slack

- Add an initial row with column names `pitch` and `off_nominal_roll`.
- Remove spaces from the original table.
- Remove redundant tail sun values with off-nominal roll of `18.749`.
- Add row `56.00020066210354500000,-1.000` to the beginning.
- Add rows `177.99999999999997157829,18.749` and `178.00000000000000000000,-1.000`.
- Remove the final `180.0,0.000` row.
