#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: cat

inputs:
  message:
    type: string
    default: example.conf

requirements:
  InitialWorkDirRequirement:
    listing:
     - entryname: example.conf
       entry: |
          $(inputs.message)

outputs:
  classfile:
     type: File
     outputBinding:
        glob: "*.conf"
