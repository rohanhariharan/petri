# petri

Grow, observe, compare. *petri* instruments a Python program, records its
variable state over time, saves each execution as a run, and tells you what
actually changed between two experiments.

Single self-contained Python file, no dependencies, works with any Python 3.

## Install

```sh
curl -sL https://raw.githubusercontent.com/rohanhariharan/petri/main/petri \
  -o /usr/local/bin/petri
chmod +x /usr/local/bin/petri

# or, without sudo — drop it anywhere on your PATH
curl -sL https://raw.githubusercontent.com/rohanhariharan/petri/main/petri \
  -o ~/bin/petri && chmod +x ~/bin/petri
```

Or run the one-liner installer (defaults to `~/bin`, or `/usr/local/bin` under sudo):

```sh
curl -sL https://raw.githubusercontent.com/rohanhariharan/petri/main/install.sh | bash
```

Requires only a `python3` on your PATH.

## Usage

```sh
petri run main.py                # run once, record variables
petri batch main.py --times 10   # run N times (default 10)
petri runs                       # list saved runs
petri inspect 3                  # show run #3's variable history
petri compare 2 3                # diff what changed between two runs
petri wipe                       # delete all runs (confirm twice)
```

### Example

Given:

```python
x = 10
y = 5
z = x + y

x = 20
z = x + y
```

`petri` records:

```
x:    10 → 20
y:    5
z:    15 → 25
```

`petri compare 2 3` shows what actually changed across runs:

```
Changing Run #2 → Run #3

Changed variables
────────────────────────
x
  10 → 20

z
  15 → 25
```

## What it records

Top-level variables (assignments) with basic Python values:

integers · floats · strings · booleans · lists · dictionaries · tuples · `None`

Function locals, imports, and class bodies are left untracked for now. Arbitrary
objects are skipped rather than crash the run.

## How it works

`petri` rewrites top-level assignments using Python's standard `ast` module,
wrapping each with a recorder call, then executes the instrumented program
in-process. Runs are saved under `~/.petri/runs/` as JSON.

## Known limitations

- The program executes inside petri's own interpreter, so `if __name__ ==
  "__main__"` guards and calls like `quit()`/`os._exit()` behave slightly
  differently than running `python main.py` directly.
- Top-level only — functions aren't instrumented yet.

## License

[MIT](LICENSE)
