# Goals


## Sane defaults for various modes

* login vs non-login shell
* interactive vs non-interactive shell

Only load the parts that I need. Why define colors on a non-interactive shell?

## Work "everywhere"

Figure out what Host and OS I'm running on, and configure yourself 
accordingly. Things live in different places in each OS. At a minimum, we 
need to suport Linux and Mac OS. Maybe Solaris too. What about various
flavors of Linux? Are they similar enough?

## Be "modular"

For me, "modular" implies a few similar but distinct properties.

### Separate config management from useful bits

It's all useful, of course, but some bits are just to make the modular 
config work, while others are the bits we actually use. Some are both.

Examples:

* `sortip()` is a useful function in its own right. It's something
you'd call from the command line regularly.
* `build_prefix()` sets up the structure of the $PREFIX dir, and is probably
only useful to the bash config itself.
* `path_prepend()` is probably both, useful to the config, but also to 
the end user if they need to change the working environment.

### Each file should handle just one thing

Subsystem configuration should be in self-contained files. Those files should
begin with a test that determines if they're needed and exit quickly if not.
Things that aren't subsystems but have non-trivial configs (i.e. less) 
may want their own configuration files for clarity's sake. Again, these should
either have early-exit test, or a comment that indicates they always run.

Early-exit tests should not depend on login or interactive status. The files
should be named/filed in a way that allows us to select the correct subsets
of rc files to run based on status. Something like:

```bash
# non-interactive stuff above
# If not running interactively, don't do anything
[ -z "$PS1" ] && return
# ...
for file in $RC/*_interactive_*; do
    . $file
done
```

### 

## Have consistent, meaningful file structure