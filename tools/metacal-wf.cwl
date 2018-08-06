#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

inputs:
  repo: string
  tracts: int[]
  patches: string[]
  filters: string[]
  config_file: File
  output_filename: string

outputs:
  meds:
    type: File[]
    outputSource: medsdm/meds

  ngmixout:
    type: File
    outputSource: ngmixit/ngmixout

requirements:
  - class: ScatterFeatureRequirement

steps:
  medsdm:
    run: medsdm.cwl
    in:
      repo: repo
      tract: tracts
      patch: patches
      filter: filters
    out: [meds]
    scatter: [tract, patch, filter]
    scatterMethod: flat_crossproduct

  ngmixit:
      run: ngmixit.cwl
      in:
        config_file: config_file
        data_files: medsdm/meds
        out_file: output_filename
      out: [ngmixout]
