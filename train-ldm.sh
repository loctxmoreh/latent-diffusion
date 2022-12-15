#!/usr/bin/env bash

export CUDA_VISIBLE_DEVICES=0

/usr/bin/env python main.py \
        --base configs/latent-diffusion/cin-ldm-vq-f8.yaml \
        -t --gpus 0, \
        --max_epochs 1
