#!/usr/bin/env cwl-run

class: CommandLineTool
id: "MEDSDM"
label: "MEDSDM maker"
cwlVersion: v1.0

doc: |
  Tool to extract meds cutouts from a given DM [tract, patch]

requirements:
  - class: DockerRequirement
    dockerPull: "eiffl/medsdm:latest"

inputs:
  repo:
    type: string
    doc: "Path to DM repository"
    inputBinding:
      position: 1

  tract:
    type: int
    doc: "Tract to process"
    inputBinding:
      position: 2

  patch:
    type: string
    doc: "patch to process"
    inputBinding:
      position: 3

  filter:
    type: string
    doc: "Filter to process"
    inputBinding:
      position: 4

outputs:
  meds:
    type: File
    outputBinding:
      glob: medsdm*
    doc: "Output MEDSDM file"

baseCommand: ["python", "-m", "medsdm.maker"]
