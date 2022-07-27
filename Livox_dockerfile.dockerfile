###############################################################################
# Reference link: 
# https://github.com/PJLab-ADG/Livox-Mapping#23-docker

# Build instruction: Run following command in the directory where the dockerfile is located.
# docker build -f Danny_dockerfile -t danny_livox .

# when you want to mount new folder please remember to add it at docker run command

# to Run the docker image with terminal open:
# docker run -it --rm -p 3316:22 --group-add video -v "LOCAL_PC_FOLDER_PATH" -w "CONTAINER_FOLDER_PATH" danny_livox /bin/bash

# To allow the RVIZ in Docker to run in the host PC. In the local machine:
# xhost +

# Inside the container, run following command:
# roslaunch livox_mapping livox_mapping.launch save_path:="PATH_TO_SAVE_SLAM_POSE_RESULT"

FROM siyuanhuang95/livox_slam:release 

RUN apt-get update

RUN cd /

RUN mkdir catkin_ws && mkdir catkin_ws/src

RUN cd catkin_ws/src

RUN git clone https://github.com/Livox-SDK/livox_ros_driver.git /catkin_ws/src/ws_livox/src

RUN /bin/bash -c 'source /opt/ros/melodic/setup.bash; cd /catkin_ws/src/ws_livox; catkin_make'

RUN /bin/bash -c 'source /catkin_ws/src/ws_livox/devel/setup.sh'

RUN cd catkin_ws/src && git clone https://github.com/PJLab-ADG/Livox-Mapping.git 

RUN /bin/bash -c 'source /opt/ros/melodic/setup.sh; cd /catkin_ws; catkin_make'

RUN /bin/bash -c 'source /catkin_ws/devel/setup.sh'

#EOF