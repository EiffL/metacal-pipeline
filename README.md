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


