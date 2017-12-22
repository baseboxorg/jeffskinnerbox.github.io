
# Study Plan
1. [Make Your Own Neural Network](https://www.amazon.com/Make-Your-Own-Neural-Network-ebook/dp/B01EER4Z4G)
1. [Neural Networks and Deep Learning](http://neuralnetworksanddeeplearning.com/)
1. [Comparing Top Deep Learning Frameworks: Deeplearning4j, PyTorch, TensorFlow, Caffe, Keras, MxNet, Gluon & CNTK](https://deeplearning4j.org/compare-dl4j-tensorflow-pytorch#comparing-top-deep-learning-frameworks-deeplearning4j-pytorch-tensorflow-caffe-keras-mxnet-gluon--cntk)
1. [Getting Started with TensorFlow: A Machine Learning Tutorial](https://www.toptal.com/machine-learning/tensorflow-machine-learning-tutorial)
1. [From Solving Equations to Deep Learning: A TensorFlow Python Tutorial](https://www.toptal.com/machine-learning/tensorflow-python-tutorial)
1. [What is the TensorFlow machine intelligence platform?](https://opensource.com/article/17/11/intro-tensorflow)
1. [TensorFlow Workshops](https://github.com/tensorflow/workshops)


A [Vision Processing Unit (VPU)][12] is an emerging class of microprocessor,
specifically designed to accelerate machine vision tasks.
VPUs are distinct from video processing units (aka [Graphics Processing Unit or GPU][05])
(which are specialised for [video encoding and decoding][02])
in their suitability for running [machine vision][03] algorithms such as
CNN (convolutional neural networks),
SIFT (Scale-invariant feature transform), etc.
They are distinct from GPUs,
which contain specialised hardware for [rasterization][01] and [texture mapping][04] (for 3D graphics),
and whose memory architecture is optimised for manipulating bitmap images in off-chip memory
(reading textures, and modifying frame buffers, with random access patterns).

The Neural Compute Stick (NCS) lets developers bring trained neural networks
built on the Caffe framework to embedded apps running on a variety of Myriad 2 VPU-based devices.
These could include robots, as well as smart home, surveillance, and security devices.

The $79 stick plugs into the Pi via USB, and accelerates vision recognition tasks using the 12 specialized cores in its Myriad 2 Vision Processing Unit (VPU). The low-power processor is capable of 100 gigaflops and consumes a single watt, although the power draw for the stick may occasionally rise to 2.5W.

It’s a Movidius Neural Compute Stick that’s designed for low-powered Deep Learning applications.
Google Clips hands-free camera uses Movidius chip inside.
The specs are that it’s capable of 100 Gigaflops of capability with 1W power consumption.
This is a USB 3.0 compatible stick
(don’t try it on USB 2.0, it won’t work!)
that is meant only for inference.
This is a specialized Deep Learning ASIC that that’s designed for convolution networks.
Unlike the workhorse of Deep Learning (i.e. GPUs),
this device is designed for mobile and IoT workloads.
It is meant to be paired up with another system to perform Deep Learning training.
The The Movidius stick has a set of enhanced imaging/vision accelerators,
12 specialized vector VLIW processors called SHAVEs, and two RISC processors.
The device supports 8/16/32 bit integer and 16/32 bit floating point arithmetic.

Movidius Neural Compute SDK currently supports two Deep Learning frameworks:

* [Caffe][07] - a deep learning framework from Berkeley Vision Labs
* [TensorFlow][06] - a deep learning framework from Google
    * [TensorFlow Lite](https://hackaday.com/2017/11/23/smarter-phones-in-your-hacks-with-tensorflow-lite/)

What about other Deep Learning frameworks like
[PyTorch](http://pytorch.org/),
[Theano](http://deeplearning.net/software/theano/)
Deeplearning4j,
Keras,
[MxNet](https://mxnet.incubator.apache.org/),
Gluon, and
CNTK?
There are few neural network frameworks comparisons on the web
([here](https://deeplearning4j.org/compare-dl4j-tensorflow-pytorch))

There is an active user forum for the Neural Compute Stick at
[`https://ncsforum.movidius.com`](https://ncsforum.movidius.com)
where you can get help troubleshooting an issue or coding examples.
The forum is also monitored by Movidius engineers which provide solutions as well.
There is also a Github repository at
[`http://github.com/Movidius/ncappzoo`](http://github.com/Movidius/ncappzoo)
which is designed for developers to contribute networks
and applications written for the Neural Compute Stick to the NCS community.

* [Movidius Developer Site](https://developer.movidius.com/)
* [Movidius™ NC SDK 1.07.07 (with Raspberry Pi support)](https://ncsforum.movidius.com/discussion/118/movidius-nc-sdk-1-07-07-with-raspberry-pi-support)
* [Movidius Neural Compute Stick: Getting Started Guide](https://ncsforum.movidius.com/uploads/editor/0j/ln0nd3psmp6q.pdf)
* [Getting Started with Neural Compute Stick and Rasbperry Pi 3](https://www.youtube.com/watch?v=f39NFuZAj6s)


* [YOLO for Intel/Movidius Neural Compute Stick (NCS)](https://github.com/gudovskiy/yoloNCS)
* [Real-time object detection with YOLO](http://machinethink.net/blog/object-detection-with-yolo/)


* [AMD Vega training for Movidius Neural Compute Stick](https://medium.com/intuitionmachine/using-amds-vega-to-train-movidius-neural-compute-stick-9d19fef42c9)
* [Neural Compute Stick: Object Detection with Neural Networks](https://blog.codecentric.de/en/2017/10/object-detection-neural-compute-stick/)
* [Image classifier using Intel Movidius Neural Compute Stick with Raspberry Pi and (Pi Camera or USB Web Camera)](https://github.com/ibrahimsoliman97/Intel-Movidius-NCS-RPI)
* [How Pytorch gives the big picture with deep learning](https://medium.freecodecamp.org/how-pytoch-gives-the-big-picture-with-deep-learning-e4a0f372f4b6)

* [Google announces Movidius-powered AIY Vision Kit](http://www.bit-tech.net/news/tech/peripherals/google-announces-movidius-powered-aiy-vision-kit/1/)
* [How to give your Raspberry Pi 'state-of-the art computer vision' using Intel's Neural Compute Stick](https://www.techrepublic.com/article/how-to-give-your-raspberry-pi-state-of-the-art-computer-vision-using-intels-neural-compute-stick/)

# Step 1: Build Movidius NCS SDK
To quickly get going, check out the [Movidius NCS Quick Start Guide][08].
(**NOTE:** A more complete guide can be found [here][11].)
You find additional documentation [here][09].
First, install the Movidius Neural Compute software developer kit (NCSDK).
This build process will take several minutes and install Python packages,
TensorFlow, Caffe, etc.

################################################################################
Does the below install TensorFlow and TesorBoard?

* https://www.tensorflow.org/install/
* https://github.com/tensorflow
* https://github.com/tensorflow/tensorboard
################################################################################

```bash
# go to the directory you plan to develop your project
cd ~/src
mkdir movidius
cd movidius

# clone the movidius ncs developer kit
git clone https://github.com/movidius/ncsdk.git

# if already cloned, update with this
git pull origin master

# build the developer kit
cd ncsdk
make install
```

During the install,
the `PYTHONPATH` enviroment variable will be added to your `.bashrc` as required by Caffe.
In my case, it was changed from `/home/jeff/.local/bin`
to `/home/jeff/.local/bin:/opt/movidius/caffe/python`.

Now test the installation by running the built-in examples.
Plug the NCS to your system's USB port
and run these commands on a new terminal window:

```bash
# goto your working directory
cd ~/src/movidius/ncsdk

# build the examples
make examples
```

**NOTE:** If you ever wish to uninstall the SDK, use `make uninstall`.

There are additional examples called the
[Neural Compute Application Zoo (NC App Zoo)][10].
These are examples contributued by the Movidius NCS user community.
You can also install these examples.

```bash
# go to directory for storing examples
cd ~/src/movidius/ncsdk

# clone neural compute application zoo
git clone https://github.com/movidius/ncappzoo.git
```

# Step X: Training Neural Network
The training phase does not utilize the NCS hardware or SDK,
while the subsequent phases of “profiling, tuning and compiling” and “prototyping”
do require the NCS hardware and the accompanying Movidius™ Neural Compute SDK.



[01]:https://en.wikipedia.org/wiki/Rasterisation
[02]:https://en.wikipedia.org/wiki/Video_codec
[03]:https://en.wikipedia.org/wiki/Machine_vision
[04]:https://en.wikipedia.org/wiki/Texture_mapping
[05]:https://en.wikipedia.org/wiki/Graphics_processing_unit
[06]:https://www.tensorflow.org/
[07]:http://caffe.berkeleyvision.org/
[08]:https://developer.movidius.com/start
[09]:https://movidius.github.io/ncsdk/
[10]:https://github.com/movidius/ncappzoo
[11]:https://movidius.github.io/ncsdk/index.html
[12]:https://www.movidius.com/vision-processing-units
[13]:
[14]:
[15]:
[16]:
[17]:
[18]:
[19]:
[20]:

