# Running latent-diffusion on Moreh framework
![](https://badgen.net/NVIDIA-A100/passed/green)

> [2022.12.15] Moreh's `torch` hasn't support `pytorch-lightning` yet. The
> following instructions are for A100 VMs.

## Prepare

### Environment
```bash
conda env create -f a100env.yml
conda activate ldm
```

### Data
This repo supports the following dataset: CelebA-HQ, FFHQ, LSUN (bedrooms,
cats, churches), ImageNet (ILSVRC2012)

> [2022.12.15] Currently, FFHQ, CelebA-HQ and LSUN are unavailable for
> download. The following instructions are for ILSVRC2012 dataset.


#### ILSVRC2012
First, download the ILSVRC2012 dataset (training & validation set) from
[ImageNet](https://www.image-net.org/). Then, assume the train & validation
set is located at `/path/to/train` and `/path/to/val`, symlink them to your
`$XDG_CACHE_HOME` (usually `$HOME/.cache`) like this:

```bash
mkdir -p ~/.cache/autoencoders/data/ILSVRC2012_train/
mkdir -p ~/.cache/autoencoders/data/ILSVRC2012_validation/

ln -s /path/to/train ~/.cache/autoencoders/data/ILSVRC2012_train/data
ln -s /path/to/val   ~/.cache/autoencoders/data/ILSVRC2012_validation/data
```
Eventually, it should have the following structure:
```
${XDG_CACHE_HOME}/autoencoders/data/ILSVRC2012_{split}/data/
├── n01440764
│   ├── n01440764_10026.JPEG
│   ├── n01440764_10027.JPEG
│   ├── ...
├── n01443537
│   ├── n01443537_10007.JPEG
│   ├── n01443537_10014.JPEG
│   ├── ...
├── ...
```

### Pretrained weights

#### Text2Img model
The model is 5.7GB in disk size.
```bash
mkdir -p ./models/ldm/text2img-large
wget -O ./model/ldm/text2tim-large/model.ckpt https://ommer-lab.com/files/latent-diffusion/nitro/txt2img-f8-large/model.ckpt
```

#### LDM first-stage model
Model spec: vq-f8
Disk size: 772MB (zip), 840MB (unzipped)
```bash
wget -O models/first_stage_models/vq-f8/model.zip https://ommer-lab.com/files/latent-diffusion/vq-f8.zip

# then, unzip
unzip -o model.zip
```

## Run

### txt2img using pretrained
Using the Text2Img model above, generate an image with any description:
```bash
python scripts/txt2img.py \
        --prompt "<enter a description here>" \
        --ddim_eta 0.0 --n_samples 4 --n_iter 4 --scale 5.0  --ddim_steps 50

# for example,
python scripts/txt2img.py \
        --prompt "a virus monster is playing guitar, oil on canvas" \
        --ddim_eta 0.0 --n_samples 4 --n_iter 4 --scale 5.0  --ddim_steps 50
```

### Train your own LDMs
These train scripts use the ILSVRC2012 dataset.

#### Train an autoencoder
```bash
./train-autoencoder.sh
```

#### Train LDM
```bash
./train-ldm.sh
```
