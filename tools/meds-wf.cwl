#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

inputs:
  repo: string
  tracts: int[]
  patches: string[]
  filters: string[]
  medsdm_conf: File
  ngmixit_conf: File
  output_filename: string

outputs:
  meds:
    type: File[]
    outputSource: medsdm/meds

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
      config: medsdm_conf
    out: [meds]
    scatter: [tract, patch, filter]
    scatterMethod: flat_crossproduct

