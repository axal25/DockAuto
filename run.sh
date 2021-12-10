#!/bin/bash

run() {
  clear

  source "files.env"

  "$F_S_BuildAndRun"
}

run