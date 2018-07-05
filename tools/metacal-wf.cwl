#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
inputs:
  repo: string
  tracts: int[]
  patches: string[]
  filters: string[]
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
    out: [meds]
    scatter: [tract, patch, filter]
    scatterMethod: dotproduct
