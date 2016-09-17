
* [series of tutorials](https://www.intorobotics.com/accelerometer-gyroscope-and-imu-sensors-tutorials/)
* [Open source IMU and AHRS algorithms](http://x-io.co.uk/open-source-imu-and-ahrs-algorithms/)
* [attitude and heading reference system (AHRS)](https://en.wikipedia.org/wiki/Attitude_and_heading_reference_system)
* [AHRS for Adafruit's 9-DOF, 10-DOF, LSM9DS0 Breakouts](https://learn.adafruit.com/ahrs-for-adafruits-9-dof-10-dof-breakout/introduction)
* [REAL-TIME ORIENTATION DISPLAY WITH THE MINIMU-9 V2](https://www.raspberrypi.org/blog/real-time-orientation-display-with-the-minimu-9-v2/)
* [ARDUINO MPU 6050 – BEST IMU SENSOR TUTORIAL](http://diyhacking.com/arduino-mpu-6050-imu-sensor-tutorial/)
* [IMU Data Fusing: Complementary, Kalman, and Mahony Filter](http://www.olliw.eu/2013/imu-data-fusing/)
* [Tutorial: Building an AHRS/Head-tracker using the "9DOF Razor IMU" or the "9DOF Sensor Stick" by SparkFun](http://www.electronicaembajadores.com/datos/manuales/ss/ssac/ssacim1.pdf)
* [The Design and Implementation of a Robust AHRS for Integration into a Quadrotor Platform](http://www.botched.co.uk/wp-content/uploads/2013/10/The-Design-and-Implementation-of-a-Robust-AHRS-for-Implementation-on-a-Quadrotor.pdf)
* [Adafruit 10-DOF IMU Breakout](https://cdn-learn.adafruit.com/downloads/pdf/adafruit-10-dof-imu-breakout-lsm303-l3gd20-bmp180.pdf)
* [A Guide To using IMU (Accelerometer and Gyroscope Devices) in Embedded Applications](http://www.starlino.com/imu_guide.html)
* [Accelerometer & Gyro Tutorial](http://www.instructables.com/id/Accelerometer-Gyro-Tutorial/)

* [Raspberry Pi I2C (Python)](http://www.instructables.com/id/Raspberry-Pi-I2C-Python/?ALLSTEPS)
* [GUIDE TO INTERFACING A GYRO AND ACCELEROMETER WITH A RASPBERRY PI](http://ozzmaker.com/guide-to-interfacing-a-gyro-and-accelerometer-with-a-raspberry-pi/)
* [RTIMULib2 - a versatile C++ and Python 9-dof, 10-dof and 11-dof IMU library](https://github.com/jeff-loughlin/RTIMULib2)
* [Accelerometer, Gyro and IMU Buying Guide](https://www.sparkfun.com/pages/accel_gyro_guide)
* [Guide to gyro and accelerometer with Arduino including Kalman filtering](http://www.instructables.com/id/Guide-to-gyro-and-accelerometer-with-Arduino-inclu/)
* [Stable Orientation – Digital IMU 6DOF + Arduino](http://bildr.org/2012/03/stable-orientation-digital-imu-6dof-arduino/)
* [FreeIMU: an Open Hardware Framework for Orientation and Motion Sensing](http://www.varesano.net/projects/hardware/FreeIMU)

* [How MEMS Accelerometer Gyroscope Magnetometer Work](https://www.youtube.com/watch?v=eqZgxR6eRjo)

Example Code
* [SparkFun](https://www.sparkfun.com/products/11028)

Sensor Fusion
* [How Sensor Fusion Works](http://www.allaboutcircuits.com/technical-articles/how-sensor-fusion-works/)
* [Affordable 9 DoF Sensor Fusion](https://github.com/kriswiner/MPU-6050/wiki/Affordable-9-DoF-Sensor-Fusion)
* [Using the MPU-6050](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=7&cad=rja&uact=8&ved=0ahUKEwjrwsOT2d_OAhUJL8AKHf6BAV8QFghIMAY&url=http%3A%2F%2Fwww.cs.unca.edu%2F~bruce%2FFall13%2F360%2FIMU_Wk8.pptx&usg=AFQjCNFtEwtGzTZE2aWzhBIfPi6YkmmY2w&sig2=O2jChpi6xXoKH9KYnM2xLg&bvm=bv.131286987,d.dmo)
* [A practical approach to Kalman filter and how to implement it](http://blog.tkjelectronics.dk/2012/09/a-practical-approach-to-kalman-filter-and-how-to-implement-it/)


[10-dof-imu!](http://www.alliedelec.com/images/products/Small/70460797.jpg)
A Inertial Measurement Unit (IMU) is a single unit in the electronics module
which collects angular velocity and linear acceleration data which is sent to the main processor.
The IMU housing actually contains multiple separate sensors.

Degrees of Freedom (DOF) refers to the movement of a rigid body inside space.
It is the different basic ways in which an object can move or be oriented in space.
How many DOF you have is dependent on the application
(e.g. some movements could be constrained by the application,
like a radio control car which can only move on a surface where an airplane can move in 3 dimensional space).
Here we will be looking at 10 DOF in total,
and these can be divide them into 4 different types: translation, rotation, orientation, and elevation:

* **Translation Movement** -  A body is free to translate in 3 degrees of freedom: forward/back, up/down, left/right.
* **Rotation Movement** - A body can also rotate with 3 degrees of freedom: pitch, yaw, and roll.
* **Orientation** - A body has 3 degrees of freedom to describe the direction it points relative to the earth
* **Elevation** - A body can move in 1 degree of freedom (up/down) relative to its position on the earth

I'm using Adafruit's 10-DOF IMU (10 Degrees of Freedom, Inertial Measurement Unit).
This board contains 3 seperate IMU chips, all rolled into to one printed circuit board:

[LSM303DLHC][01] - a 3-axis accelerometer (up to +/-16g) and a 3-axis magnetometer (up to +/- 8.1 gauss) on a single chip
[L3GD20][02] - a 3-axis gyroscope (up to +/-2000 dps)
[BMP180][03] - A barometric pressure sensor (300..1100 hPa) that can be used to calculate altitude, with an additional on-board temperature sensors for calibration

Any one of these individual sensors could be suitable for some applications,
but this unit with 10 DOF provides nearly all that you need.
The only thing missing is absolution position on earth obtainable
via the Global Positioning System (GPS).
In principle, with the GPS, you could eliminate the BMP180 and LSM303DLHC,
but these sensors can give you greater precision, and therefore,
still generally desirable to have for sensor fusion.

# Sensor Fusion
When using the IMU to calculate angles,
readings from both the gyro and accelerometer are needed, which are then combined.
This is because using either on their own will result in inaccurate readings.
Here is why;

* Gyros – A gyro measures the rate of rotation,
which has to be tracked over time to calculate the current angle.
This tracking causes the gyro to drift.
However, gyros are good at measuring quick sharp movements.
* Accelerometers – Accelerometers are used to sense both static (e.g. gravity)
and dynamic (e.g. sudden starts/stops) acceleration.
They don’t need to be tracked like a gyro and can measure the current angle at any given time.
Accelerometers however are very noisy and are only useful for tracking angles over a long period of time.

The data needs to be integrated together to make it useful.
[Sensor fusion][04] is combining of sensory data or data derived from disparate sources
such that the resulting information has less uncertainty than would be possible
when these sources were used individually.

* [Accelerometer & Gyro Tutorial](http://www.instructables.com/id/Accelerometer-Gyro-Tutorial/)

# Connecting with the Board
All of the sensors on the Adafruit 10DOF breakout board communicate via a two-pin I2C bus.

# Inter-Integrated Circuit (I2C)
The [Inter-Integrated Circuit or I2C][05] (pronounced as either I-squared-C or I-2-C)
is generically referred to as a "two-wire interface" or "2-wire serial bus".
It's a multi-master serial single-ended computer bus invented by Philips
that is used to attach low-speed peripherals to a
motherboard, embedded system, cellphone, or other electronic device.

I2C can be used to connect up to 127 nodes via a bus has two data wires, called SCL and SDA.
SCL is the clock line. It is used to synchronize all data transfers over the I2C bus.
SDA is the data line. Of course, there is a third wire being ground.
There may also be a 5 volt wire to distribute power to the devices.
Both SCL and SDA lines are "open drain" drivers.
What this means is that the chip can drive its output low,
but it cannot drive it high.
For the line to be able to go high you must provide pull-up resistors to the 5v supply.
There should be a resistor from the SCL line to the 5v line and another from the SDA line to the 5v line.
The value of the resistors is not critical.
Anything from 1800 ohms to 47K ohms used (1.8K, 47K and 10K are common values).
You only need one set of pull-up resistors for the whole I2C bus,
not for each device, as illustrated below:

<p style="text-align:center;">
    <a href="http://jeffskinnerbox.wordpress.com/2012/12/05/drive-a-16x2-lcd-with-the-raspberry-pi/i2c-diagram-and-description-2/#main" rel="attachment wp-att-906">
    <img class="aligncenter  wp-image-906" alt="I2C Diagram and Description" src="/images/i2c-diagram-and-description1.jpg" width="436" height="293" />
    </a>
</p>

In theory the I2C bus can support multiple masters, but most micro-controllers can’t.
A master is usually a microcontroller, although it doesn’t have to be.
Slaves can be ICs or microcontrollers.
When the master wishes to communicate with a slave it sends a
series of pulses down the SDA and SCL lines.
The data that is sent includes an address that identifies the slave
with which the master needs to interact.
Addresses take 7 bits out of a data byte;
the remaining bit specifies whether the master wishes to read
(get data from a slave) or write (send data to a slave).

Some devices have an address that is entirely fixed by the manufacturer;
others can be configured to take one of a range of possible addresses.
When a micro-controller is used as a slave it is normally possible to configure its address by software,
and for that address to take on any of the 127 possible values.
The address byte may be followed by one or more byes of data,
which may go from master to slave or from slave to master.

When data is being sent on the SDA line,
clock pulses are sent on the SCL line to keep master and slave synchronised.
Since the data is sent one bit at a time, the data transfer rate is one eighth of the clock rate.
The original standard specified a standard clock rate of 100KHz,
and most I2C chips and micro-controllers can support this.
Later updates to the standard introduced a fast speed of 400KHz
and a high speed of 1.7 or 3.4 MHz.
The Arduino and Raspberry Pi can support standard and fast speeds.

The fast rate corresponds to a data transfer rate of 50K bytes/sec
which is too slow for some control applications.
One option in that case is to use SPI instead of I2C.



[01]:http://www.st.com/content/ccc/resource/technical/document/datasheet/56/ec/ac/de/28/21/4d/48/DM00027543.pdf/files/DM00027543.pdf/jcr:content/translations/en.DM00027543.pdf
[02]:https://www.pololu.com/file/0J563/L3GD20.pdf
[03]:https://cdn-shop.adafruit.com/datasheets/BST-BMP180-DS000-09.pdf
[04]:https://en.wikipedia.org/wiki/Data_fusion
[05]:http://www.eeherald.com/section/design-guide/esmod11.html
[06]:
[07]:
[08]:
[09]:
[10]:
[11]:
[12]:
[13]:
[14]:
[15]:
[16]:
[17]:
[18]:
[19]:
[20]:
[21]:
[22]:
[23]:
[24]:
[25]:
[26]:
[27]:
[28]:
[29]:
[30]:
