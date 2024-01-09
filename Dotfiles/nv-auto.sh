#!/usr/bin/env bash
echo "Before sleep"
sleep 10
echo "After sleep"

nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"



