## Docker
This solution is best deployed via Docker using the attached `dockerfile`. Instructions below and for Windows and may need some finessing for other platforms.

### Requirements:
1. Docker Desktop
2. A CUDA compatible GPU with >20Gb of VRAM (i.e. an RTX 3080 or above; I use an RTX A4500)
3. Latest GFX card drives installer

### Build
First build the docker image by running the following command from the repo directory: `docker build -t <username>/llama-lora-tuner:hackdays .` (replace username with your docker hub user name if you have one, otherwise any other short value)

This will download and install all the requirements to run `https://github.com/zetavg/LLaMA-LoRA`

### Running
Once built, the docker container can be run using: `docker run -it --rm --gpus=all -p 7860:7860 -v ${PWD}/data:/data -v ${PWD}/cache:/LLaMA-LoRA-Tuner/cache -e PYTORCH_TRANSFORMERS_CACHE=/LLaMA-LoRA-Tuner/cache ibebbs/llama-lora-tuner:hackdays` (replace username with your docker hub user name if you have one, otherwise any other short value)

The first time you run this container, it will download a base model (decapoda/llama-7b) for evaluation/fine tuning to the local `cache` directory (so subsequent runs don't need to download it again). Once downloaded and initialized, a webserver will be started at "http://0.0.0.0:7860" which can be loaded in your browser by visiting "http://localhost:7860".

### Validating
One running, the app should have everything needed to perform inference. Simply enter a prompt (i.e. "Tell me about Alpacas") in the "Instrunction" box and click the "Generate" button. In 40-50 seconds (the first time is slow as it prepares the model for inference, subsequent calls should be much faster) you should see some text generated in the "Output" box.

### Restarting
Now everything is downloaded, you should be able to quickly restart the docker container without needing to re-download the model by using the same command above.