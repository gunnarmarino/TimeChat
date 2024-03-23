#!/bin/bash

# Set the ckpt path variable
ckpt_path="/workspace/TimeChat/ckpt"
git lfs install
# Create the main directory if it doesn't exist
if [ ! -d "$ckpt_path" ]; then
  mkdir -p $ckpt_path
fi

# Download and save the pre-trained Image Encoder (EVA ViT-g) if it doesn't exist
if [ ! -f "$ckpt_path/eva-vit-g/eva_vit_g.pth" ]; then
  mkdir -p $ckpt_path/eva-vit-g
  wget https://storage.googleapis.com/sfr-vision-language-research/LAVIS/models/BLIP2/eva_vit_g.pth -P $ckpt_path/eva-vit-g/
fi

# Download and save the pre-trained Image Q-Former (InstructBLIP Q-Former) if it doesn't exist
if [ ! -f "$ckpt_path/instruct-blip/instruct_blip_vicuna7b_trimmed.pth" ]; then
  mkdir -p $ckpt_path/instruct-blip
  wget https://storage.googleapis.com/sfr-vision-language-research/LAVIS/models/InstructBLIP/instruct_blip_vicuna7b_trimmed.pth -P $ckpt_path/instruct-blip/
fi

# Clone the pre-trained Language Decoder (LLaMA-2-7B) and Video Encoder (Video Q-Former of Video-LLaMA) if they don't exist
if [ ! -d "$ckpt_path/Video-LLaMA-2-7B-Finetuned/llama-2-7b-chat-hf" ] || [ ! -f "$ckpt_path/Video-LLaMA-2-7B-Finetuned/VL_LLaMA_2_7B_Finetuned.pth" ]; then
  git clone https://huggingface.co/DAMO-NLP-SG/Video-LLaMA-2-7B-Finetuned $ckpt_path/Video-LLaMA-2-7B-Finetuned
  mv $ckpt_path/Video-LLaMA-2-7B-Finetuned/VL_LLaMA_2_7B_Finetuned.pth $ckpt_path/Video-LLaMA-2-7B-Finetuned/
  mv $ckpt_path/Video-LLaMA-2-7B-Finetuned/llama-2-7b-chat-hf $ckpt_path/Video-LLaMA-2-7B-Finetuned/
fi

# Clone the Instruct-tuned TimeChat-7B if it doesn't exist
if [ ! -f "$ckpt_path/timechat/timechat_7b.pth" ]; then
  git clone https://huggingface.co/ShuhuaiRen/TimeChat-7b $ckpt_path/timechat
  mv $ckpt_path/timechat/timechat_7b.pth $ckpt_path/timechat/
fi

# Remove empty directories
rm -rf $ckpt_path/timechat/.git
rm -rf $ckpt_path/Video-LLaMA-2-7B-Finetuned/.git

echo "File structure created and necessary files downloaded successfully!"