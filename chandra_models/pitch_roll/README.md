# Pitch-roll constraint file

The `pitch_roll_constraint.csv` file was derived from the table here:

https://chandramission.slack.com/archives/C01RQMDDB0B/p1677253910876059?thread_ts=1677090228.667049&cid=C01RQMDDB0B

This table is intended to be linearly interpolated to most closely match the pitch-roll
constraint implemented by MCC in ORviewer. Regions of stair-step constraints (pure
horizontal or vertical) are represented like below:
```
145.00000000000000000000,17.088
149.99999999999997157829,17.088
150.00000000000000000000,18.749
151.01999999999998181011,18.749
```

## Changes from original download on Slack

- An entry `179.9999999999999,18.749` was included just before the final `180.0,0`. This
  ensures that linear interpolation throughout the table gives the correct answer.
- Spaces were removed from the original table.
- An initial row with column names `pitch` and `off_nominal_roll` was added.
