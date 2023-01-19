# ds4b.materials

**This code is no longer maintained. No guarantees that anything works! File an issue or PR when something is borked.**

_Packaged up_ [Data Science for Biologists](https://sjspielman.github.io/datascience_for_biologists/) student resources, including shiny applications, learnr modules, and functions for students to download and check their HW.

Install this package with `remotes::install_github("sjspielman/ds4b.materials", force = TRUE)`. 
The `force = TRUE` argument is recommended since this repo is _very actively_ updated on the regular.

## How to use this package

#### Launch an app:

This will run a shiny app and/or set or learnr exercises.

+ `launch_app()` without arguments to see available apps to launch.
+ `launch_app("name of app to launch")` to launch a specific app


#### Launch an in-class activity:

This will _download and open_ a given in-class activity. *Function makes assumptions about local directory structure!* If activity has been downloaded already, we do not override - simply open the existing.
+ `launch_activity()` without arguments to see available activities to launch.
+ `launch_activity("name of activity to launch")` to launch a specific activity


#### Launch a homework:

This will _download and open_ a given homework.  *Function makes assumptions about local directory structure!* If homework has been downloaded already, we do not override - simply open the existing.
+ `launch_homework(the number for which homework to launch)` to launch a given homework. (TBD: The only checkable homeworks are 2 and 4-11.)

#### Check a homework:

This will _check_ whether a given Rmd or R script has _errors_. It will not comprehensively check for bugs, but it will notify you if there is a CRITICAL bug of some kind that prevents the code from knitting/running.
+ `check_homework(the number for which homework to check)` to check a given homework. (TBD: The only checkable homeworks are 2 and 4-11.)

