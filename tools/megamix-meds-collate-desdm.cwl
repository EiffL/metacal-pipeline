#!/usr/bin/env cwl-run

class: CommandLineTool
id: "megamix-meds-collate-medsdm"
label: "Megamixer collate script"
cwlVersion: v1.0

doc: |
  Combine and formats ngmix outputs into a single file

requirements:
  InitialWorkDirRequirement:
    listing:
     - entryname: file_list.txt
       entry: |
          $(inputs.message)

hints:
  - class: DockerRequirement
    dockerPull: 'eiffl/metacal:latest'

inputs:
  config:
    type: File
    doc: "Configuration file"
    inputBinding:
      position: 0

  infiles:
    type: File[]
    doc: "Files to collate"

  file_list:
    type: File
    doc: "list of files to collate"
    default: file_list.txt
    inputBinding:
      position: 1

  collated_file:
    type: string
    doc: "path to the collated output file"
    inputBinding:
      position: 2

  noblind:
    type: boolean?
    doc: "don't blind the catalog"
    inputBinding:
      prefix: '--noblind'

  clobber:
    type: boolean?
    doc: "clobber existing catalog, else skip over"
    inputBinding:
      prefix: '--clobber'

  skip-errors:
    type: boolean?
    doc: "skip over errors"
    inputBinding:
      prefix: '--skip-errors'

outputs:
  ngmix_cat:
    doc: "Collated ngmix file"
    type: File
    outputBinding:
      glob: $(inputs.collated_file)

baseCommand: "megamix-meds-collate-desdm"
