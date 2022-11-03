# Prepare

## Env
Modify existing `environment.yml`

## Data
Dataset: CelebA-HQ, FFHQ, LSUN (bedrooms, cats, churches), ImageNet
- FFHQ: Too big. `images1024x1024` is 89.1GB in size
- CelebA-HQ: Too big, is 89GB in size
- LSUN: Unavailable to download at the moment
- ImageNet: Use `imagenet_100cls`

### ImageNet
Assume `imagenet_100cls` is located at `/data/work/dataset/imagenet_100cls`

```bash
mkdir -p ~/.cache/autoencoders/data/ILSVRC2012_train/
mkdir -p ~/.cache/autoencoders/data/ILSVRC2012_validation/

ln -s /data/work/dataset/imagenet_100cls/train ~/.cache/autoencoders/data/ILSVRC2012_train/data
ln -s /data/work/dataset/imagenet_100cls/val ~/.cache/autoencoders/data/ILSVRC2012_validation/data
```

## Pretrained weights
5.7GB in disk size
```bash
mkdir -p ./models/ldm/text2img-large
wget -O ./model/ldm/text2tim-large/model.ckpt https://ommer-lab.com/files/latent-diffusion/nitro/txt2img-f8-large/model.ckpt
```

# Run

## txt2img using pretrained
```bash
python scripts/txt2img.py --prompt "<enter a description here>" --ddim_eta 0.0 --n_samples 4 --n_iter 4 --scale 5.0  --ddim_steps 50

# for example,
python scripts/txt2img.py --prompt "a virus monster is playing guitar, oil on canvas" --ddim_eta 0.0 --n_samples 4 --n_iter 4 --scale 5.0  --ddim_steps 50
```

## Train your own LDMs

### Train an autoencoder

### Train LDM
