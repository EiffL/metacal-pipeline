#!/usr/bin/env cwl-run

class: CommandLineTool
id: "ngmixit"
label: "NGMIX runner"
cwlVersion: v1.0

doc: |
  Process the input meds file through ngmix.

hints:
  - class: DockerRequirement
    dockerPull: 'eiffl/metacal:latest'

inputs:
  config:
    type: File
    doc: "Configuration file"
    inputBinding:
      position: 0

  out_file:
    type: string
    doc: "Output filename"
    inputBinding:
      position: 1

  data_files:
    type: 'File[]'
    doc: "Meds files to process"
    inputBinding:
      position: 2

  fof-range:
    type: 'int[]?'
    doc: 'Inclusive, zero-offset range of FoFs to process'
    inputBinding:
      prefix: '--fof-range='
      separate: false
      itemSeparator: ','

  fof-file:
    type: File?
    doc: "File with FoF definitions."
    inputBinding:
      prefix: '--fof-file='
      separate: false

  seed:
    type: int?
    doc: "random seed"
    inputBinding:
      prefix: '--seed='
      separate: false

  nbrs-file:
    type: File?
    doc: "File with the neighbors of each object"
    inputBinding:
      prefix: '--nbrs-file='
      separate: false

  mof-file:
    type: File?
    doc: "file with the MOF fit data for doing nbrs subtraction"
    inputBinding:
      prefix: '--mof-file='
      separate: false

  models-file:
    type: File?
    doc: 'File with outputs of a separate ngmixer run, for forced photometry'
    inputBinding:
      prefix: '--models-file='
      separate: false

  psf-file:
    type: File?
    doc: "File with PSF images"
    inputBinding:
      prefix: '--psf-file='
      separate: false

  psf-map:
    type: File?
    doc: "File with mapping between image filename and local psf map"
    inputBinding:
      prefix: '--psf-map='
      separate: false

  obj-flags:
    type: File?
    doc: "File with flags for each object; flags != 0 are ignored"
    inputBinding:
      prefix: '--obj-flags='
      separate: false

outputs:
  ngmixout:
    doc: "Output ngmix file"
    type: File
    outputBinding:
      glob: $(inputs.out_file)

arguments: ['--work-dir=', $(runtime.outdir)]

baseCommand: "ngmixit"
