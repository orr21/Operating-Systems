# Business driver

## Instructions

Write a run_jobs script that finds all jobs in the current path and subpaths and executes them.

Valid jobs are bash scripts named according to the scheme 'job_<name>.sh'. The name can be any string that is part of a valid collection name (eg it can contain spaces, but cannot contain the / character). Each job must first have a comment saying that these are bash scripts: '#!/bin/bash'.

Jobs don't have the run bit set, we have to run them explicitly with the bash command.

The launch of an individual job should be carried out within its path. You can accomplish this by remembering the starting job path, then navigating to the destination job path, running it, then navigating back to the starting job path.

The output of an individual transaction should be written in 'job_<name>.out' in the same path as the transaction itself. If this collection already exists, the content should be overwritten.

Each transaction will print 'Ok' on the standard output in the last line when the transaction was executed successfully or 'Fail' when it did not. The script should output a list of failed trades at the end.
## Examples of startups

An example of a simple run and output:

```bash
$ find .
.
./A
./A/posel_p2.sh
./posel_p1.sh
$ bash ../scripts/pozeni_posle.sh
neuspesni posli:
./A/posel_p2.sh
$ find .
.
./posel_p1.out
./A
./A/posel_p2.sh
./A/posel_p2.out
./posel_p1.sh
```

## Functionality of the solution


+ finding jobs to start
    + may not select jobs whose name does not match the prescribed format
    + it must not select folders whose name matches the format
    + may not select trades whose first line does not contain an appropriate comment
    + job names can have spaces
    + paths can have spaces
+ startup
    + startup within the job path
    + output the job to the appropriate output file
    + checking job output
+ listing of failed jobs



