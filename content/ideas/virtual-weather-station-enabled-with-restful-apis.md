
Some simple weather station setups:
* [Hyper-local Weather Dashboard: Wunderground + Pi Sense HAT](https://github.com/InitialState/wunderground-sensehat/wiki)
* [How to Monitor Room Temperature With a Raspberry Pi](https://www.jeremymorgan.com/tutorials/raspberry-pi/monitor-room-temperature-raspberry-pi/)
* [Make a Weather Station With a Raspberry Pi 2](https://www.jeremymorgan.com/tutorials/raspberry-pi/how-to-weather-station-raspberry-pi/?utm_source=feedburner&utm_medium=email&utm_campaign=Feed:+JeremyMorganTutorials+(Jeremy)
* [Mini weather station with Attiny85](http://www.instructables.com/id/Mini-weather-station-with-Attiny85/)
* [Home environment monitor](https://www.hackster.io/breakpointer/home-environment-monitor-e1173e?ref=newsletter&utm_source=Hackster.io+newsletter&utm_campaign=ea4231d547-2015_4_17_Top_projects4_16_2015&utm_medium=email&utm_term=0_6ff81e3e5b-ea4231d547-140225889)
* [ESP8266 weather station](http://dangerousprototypes.com/2015/11/30/esp8266-weather-station/)
* [PiClock: an all in one clock, weather forecast and radar map](https://blog.adafruit.com/2015/06/12/piclock-an-all-in-one-clock-weather-forecast-and-radar-map-piday-raspberrypi-raspberry_pi/)

* [Weather Font](http://www.dafont.com/weather.font)

[OpenWeatherMap](http://openweathermap.org/)

Gulp - http://gulpjs.com/
Mocha - http://mochajs.org/
Chai - http://chaijs.com/
Sinon - http://sinonjs.org/
Angular - https://angularjs.org/#!
Node API - http://coenraets.org/blog/2012/10/creating-a-rest-api-using-node-js-express-and-mongodb/
https://scotch.io/tutorials/build-a-restful-api-using-node-and-express-4
https://scotch.io/tutorials/setting-up-a-mean-stack-single-page-application,
Authenticate a Node API with Tokens - https://scotch.io/tutorials/authenticate-a-node-js-api-with-json-web-tokens
Sample Application with Backbone.js, Twitter Bootstrap, Node.js, Express, and MongoDB - http://coenraets.org/blog/2012/10/nodecellar-sample-application-with-backbone-js-twitter-bootstrap-node-js-express-and-mongodb/
[PiClock – Time and Weather Information Overload](http://hackaday.com/2015/06/10/piclock-time-and-weather-information-overload/)
[Weather Underground APIs](http://www.wunderground.com/weather/api)
[National Digital Forecast Database (NDFD) Simple Object Access Protocol (SOAP) Web Service](http://graphical.weather.gov/xml/)

I have considered purchasing or building my own home weather station.
I would make it part of my larger plan to instrument my home for automation and monitoring.
A some of the most sophisticated weather stations would have

* **Anemometer** is a device for measuring wind speed.
* **Wind vane** is a device that measures the direction of the wind.
* **Thermometer** is a device that measures temperature.
* **Hygrometer** is a device that measures relative humidity.
* **Barometer** is an instrument used to measure atmospheric pressure.
* **Rain gauge** is a device that measures liquid precipitation (rain), as opposed to solid precipitation (snow gauge) over a set period of time.
* **Solar radiation** sensor measures solar energy from the sun.
* **Ultraviolet sensor** (UV sensor) is a device that measures UV light from the Sun.
* **Leaf wetness sensor** detects the presence of surface moisture and is measured between 0 (dry) and 15 (saturated).
* **Soil moisture** sensor measures the quantity of water contained in a material, such as soil on a volumetric or gravimetric basis.
* **Soil temperature** sensor measures the temperature of the soil

So potential there are many expensive sensors,
then of course their is the user interface,
the installation, and continuing maintenance of the station.
Frankly, I'm not prepared to make this commitment.
I would like the data, but the cost and labor I would like to avoid.

My solution to this will be a vertual weather station.
No hardware mounted to my house,
just a Raspberry Pi making use of published API to get my local weather.
The vertual weather station will
itself be API emabled so that you can quere for realtime status, hsitoral data,
and support mutiple thypes of user interfaces
(e.g. web page, mobile app, or even a repurposed old Kindle).

# High Level Design
Within the Raspberry Pi, I will create an RESTful API service
using [Node.js][01],
also using [Express][02] web framework and its [Router][03],
[Mongoose][04] to interact with a [MongoDB][05] [NoSQL database][08],
and [body-parser][09] will let us pull POST content from our HTTP request.
We will also be testing our API using [Postman][06] in Chrome.

* Handle all the functions of create, read, update and delete (CRUD)
* Have a standard URL to access the weather data (`http://home.rpi/weather/api`)
* Use the proper HTTP verbs to make it RESTful (GET, POST, PUT, and DELETE)
* Return [JSON data][07]
* Log all requests to the console

For our file structure, we'll use the following
(I used `tree /home/jeff/src/vws`):

```
vws
├── node_modules        // created by npm, holds our dependencies/packages
└── weather_station     // weather station model



- app/
    ----- models/
    ---------- bear.js  // our bear model
    - node_modules/     // created by npm. holds our dependencies/packages
    - package.json      // define all our node app and dependencies
    - server.js         // configure our application and create routes
```

# Install Your Tools
I created the folder `/home/jeff/src/vws`.
Within this folder,
as with all of our Node projects,
I define the packages needed in `package.json`:

```jason
{
    "name": "vertual weather station",
    "description": "Simulates a home weather station by using data harvested from the web.",
    "version": "0.0.1",
    "private": true,
    "dependencies": {
        "express": "3.x"
    }
}
```

I then ran Node.js to create my development environment:

```bash
# Node package manager will create your development environment
npm install
```

A` node_modules` folder is created in the vws folder,
and the Express and other modules are installed in a subfolder of `node_modules`.

Open `server.js` and replace its content as follows:

```js
```


[01]:https://nodejs.org/
[02]:http://expressjs.com/
[03]:http://expressjs.com/4x/api.html#router
[04]:http://mongoosejs.com/
[05]:https://www.mongodb.org/
[06]:https://www.getpostman.com/
[07]:http://json.org/
[08]:http://en.wikipedia.org/wiki/NoSQL
[09]:https://github.com/expressjs/body-parser
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
