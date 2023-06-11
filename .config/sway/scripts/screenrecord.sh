#!/bin/bash

printf "Recording in " && for n in {0..4}; do printf "$((5 - $n)) " sleep 1 ;done

wf-recorder -g "$(slurp)" -f ~/Videos/mov-$(date +"%Y-%m-%d--%H-%M-%S.mp4")
