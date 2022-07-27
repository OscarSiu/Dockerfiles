#Build instruction:
# $ docker build -f Dockerfile -t carol_tensorflow_gpu_1 .

#when you want to mount new folder please remember to add it at docker run command

# to Run the docker image with terminal open:
# $ docker run -it --rm --gpus all -v $PWD/project/:/tmp -w /tmp/ carol_tensorflow_gpu_1 bash

#start container after run 
#docker container start carol_tensorflow_gpu

#FROM tensorflow/tensorflow:latest-devel-gpu 
FROM tensorflow/tensorflow:latest-gpu 

#USER "${h06610}"
#WORKDIR /tmp
#COPY tf tf/

RUN apt-get update && apt-get install -y git wget nano gedit vim ffmpeg libsm6 libxext6

RUN pip install Cython

#WORKDIR /tmp

RUN git clone https://github.com/tensorflow/models.git

RUN mkdir protoc && cd protoc

RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.19.3/protoc-3.19.3-linux-x86_64.zip

RUN unzip protoc-3.19.3-linux-x86_64.zip

RUN export PATH=${PATH}:/tmp/protoc/bin/

#RUN cp /tmp/bin/protoc /usr/local/bin/protoc

RUN cd ../models/research && protoc object_detection/protos/*.proto --python_out=.

#RUN cd /tmp/models/research/

#RUN protoc object_detection/protos/*.proto --python_out=.

RUN git clone https://github.com/cocodataset/cocoapi.git

RUN cd cocoapi/PythonAPI && make && cp -r pycocotools /models/research/

RUN cd /models/research && cp object_detection/packages/tf2/setup.py .

RUN cd /models/research && python -m pip install --use-feature=2020-resolver .

RUN cd /models/research && python setup.py build && python setup.py install

RUN pip install typeguard

##RUN rm /tmp/cocoapi /tmp/object_detection /tdockemp/setup.py

RUN rm -rf /var/lib/apt/lists/*

#WORKDIR /tmp/tf/workspace/training_demo/

#CMD ["python", "/tmp/tf/workspace/model_main_tf2.py", "--model_dir=/tmp/tf/workspace/models/myssd_resnet50_v1_fpn", "--pipeline_config_path=/tmp/tf/workspace/pipeline.config"]
