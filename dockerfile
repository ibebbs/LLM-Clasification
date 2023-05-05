FROM nvidia/cuda:11.6.2-base-ubuntu20.04

RUN apt update

ENV DEBIAN_FRONTEND=noninteractive

RUN apt install cuda=11.6.2-1 -y
RUN apt install nvidia-gds=11.6.2-1 -y

RUN apt install pip git -y

RUN mv /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1 /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.bak \
 && mv /usr/lib/x86_64-linux-gnu/libcuda.so.1 /usr/lib/x86_64-linux-gnu/libcuda.so.bak

RUN git clone https://github.com/zetavg/LLaMA-LoRA-Tuner.git

WORKDIR /LLaMA-LoRA-Tuner

RUN pip install -r requirements.lock.txt

ENTRYPOINT [ "python3", "app.py", "--data_dir='/data'", "--base_model='decapoda-research/llama-7b-hf'", "--server_name='0.0.0.0'" ]