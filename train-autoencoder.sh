#!/usr/bin/env bash

export CUDA_VISIBLE_DEVICES=0

/usr/bin/env python main.py \
        --base configs/autoencoder/autoencoder_kl_16x16x16.yaml \
        -t --gpus 0, \
        --max_epochs 1
