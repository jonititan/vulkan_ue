# vulkan_docker_test
Simple docker image for running a Vulkan application in a docker container.

To run this example `cd` into the repo and run the following command:

```
xhost +local:docker && \
docker compose up --build
```

After that you should see `vkcube` popup along with info about the GPU printed to console.

If run on a machine accessed via ssh -X or -Y it errors.  However you can get around this by modifying the command:

```
export DISPLAY=:0 && xhost +local:docker && docker compose up --build
```
However this doesn't necessarily mean the window will appear on the machine you are using to reach the host via ssh.  It depends on whether everything is configured.
Use xlogo to check whether x11 forwarding is working correctly.


