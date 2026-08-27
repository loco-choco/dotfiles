#!/bin/sh
play $1/$(ls $1 | shuf -n 1)
