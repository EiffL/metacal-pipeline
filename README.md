# metacal-pipeline
CWL based metacalibration pipeline to post-process DM outputs. The instructions below describe how to run the 
metacalibration pipeline at nersc on cori.

## How to run the pipeline on Cori

The workflow to produce the shape catalog is described using the Common Workflow Language [(CWL)](https://www.commonwl.org/) and executed using a CWL runner, called `cwl-parsl`, based on the [Parsl](http://parsl-project.org/) library and `cwltool`, the reference CWL implementation. 

To install `cwl-parsl`, do the following from cori login:
```
$ source /global/common/software/lsst/common/miniconda/setup_current_python.sh
$ pip install --user git+https://github.com/EiffL/cwl-parsl
```
Easy enough... The first line is there to load the shared DESC environment.

Now that `cwl-parsl` is installed, you can go ahead and clone this repo:
```
$ git clone git@github.com:EiffL/metacal-pipeline.git
$ cd metacal-pipeline
```

`cwl-parsl` provides the `outdir`, `cachedir`, and `basedir` options which define respectively:
  - the output directory of the final workflow products
  - a caching directory where each step will be cached to recover from a failure
  - the base working directory (to stage input/outputs for each pipeline step)

To run the metacalibration pipeline, use a command line similar to the following, adapting the paths the different
folders:
```bash
$ cwlparsl --parsl cori --shifter \
  --outdir=/global/cscratch1/sd/flanusse/metacal-pipeline \
  --cachedir=/global/cscratch1/sd/flanusse/workdir/cache/ \
  --basedir=/global/cscratch1/sd/flanusse/workdir/ \
  tools/metacal-wf.cwl config/metacal-wf-testing.yml
```
The `--parsl cori` tells `cwl-parsl` to run parsl on the cori slurm system, note that you can also use `--parsl cori-debug`, 
which will be use the debug queue instead (limited to 30 mins, but with faster access).


> Due to a Parsl bug (https://github.com/Parsl/parsl/issues/271), using `cwl-parsl` like this from the login node might leave some zombie processes behind, be aware of this and make sure to check for lingering `ippcontroler` processes after the workflow completes.
> The following alternative method is safer, but doesn't scale as much.

For debugging purposes, it's easier (and safer) to use an interactive session, like this:
```bash
$ salloc -N 1 -q interactive -C haswell -t03:00:00 -L SCRATCH
$ cwlparsl --shifter \
  --outdir=/global/cscratch1/sd/flanusse/metacal-pipeline \
  --cachedir=/global/cscratch1/sd/flanusse/workdir/cache/ \
  --basedir=/global/cscratch1/sd/flanusse/workdir/ \
  tools/metacal-wf.cwl config/metacal-wf-testing.yml
```
Note the missing `--parsl` flag, which means that the workflow will use a local thread executor on the interactive node,
instead of submiting jobs to slurm.
