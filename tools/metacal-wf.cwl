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
  tmp_ngmix_filename: string

outputs:
  meds:
    type: File[]
    outputSource: medsdm/meds

  ngmixout:
    type: File[]
    outputSource: ngmixit/ngmixout

  ngmix_cat:
    type: File
    outputSource: megamix-collate/ngmix_cat

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

  ngmixit:
      run: ngmixit.cwl
      in:
        config: ngmixit_conf
        data_files: medsdm/meds
        out_file: tmp_ngmix_filename
      out: [ngmixout]
      scatter: data_files

  megamix-collate:
    run: megamix-meds-collate-desdm.cwl
    in:
      config: ngmixit_conf
      infiles: ngmixit/ngmixout
      collated_file: output_filename
    out: [ngmix_cat]
