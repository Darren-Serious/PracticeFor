#!/bin/bash

build_path=build

cmake -B $build_path
cmake --build $build_path

