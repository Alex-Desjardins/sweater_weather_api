# Sweater Weather

![](https://img.shields.io/badge/Ruby-2.5.3-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Rails-5.2.4.3-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)

### Jump To
- [Overview](#overview)
- [API's](#apis-consumed)
- [Setup](#setup)
- [Endpoints](#endpoints)
  - [Forecast](#forecast)
  - [Backgrounds](#backgrounds)
  - [Users](#users)
  - [Sessions](#sessions)
  - [Roadtrip](#roadtrip)
- [Technologies](#technologies)

## Overview

Sweater Weather is back-end Rails API designed to serve weather and trip information to a front-end app based off of these frontend [requirements and wireframes](https://backend.turing.io/module3/projects/sweater_weather/requirements). In this project, 4 different APIs were consumed and exposes data to help road-trippers plan for weather given a destination and estimated arrival time.

## APIS Consumed:
- [OpenWeather API](https://openweathermap.org/api/one-call-api) for weather forecasts and prediction data
- [MapQuest Geolocation API](https://developer.mapquest.com/documentation/geocoding-api/) for latitude & longitude of trip origin and destination inputs
- [MapQuest Directions API](https://developer.mapquest.com/documentation/directions-api/API ) for trip travel information
- [Pexel API](https://www.pexels.com/api/documentation/?#guidelines) for relevant photos of trip destination

## Setup
1. Fork & clone the repo
2. Run `bundle install`
3. Run `rails db:{create,migrate}`
4. Run `bundle exec figaro install`
5. Add your API keys to the newly created `config/application.yml` file.
  - `WEATHER_API_KEY: <your_key>` get your api key [here](https://openweathermap.org/api)
  - `MAPPING_API_KEY: <your_key>` get your api key [here](https://developer.mapquest.com/)
  - `IMAGE_API_KEY: <your_key>` get your api key [here](https://www.pexels.com/api/)
6. To run local test suite: `bundle exec rspec`
7. Run local server `rails s`

## Endpoints

All endpoints are built on this URL: ```https://sweater-weather-ad.herokuapp.com/```
<br><br>
### Forecast -- (*GET /forecast* - [Try it out](https://sweater-weather-ad.herokuapp.com/api/v1/forecast?location=denver)) <a name="forecast"></a>

Retrieve detailed weather information for a given city, including:
- Current weather conditions
- Hourly forecasts for next 8 hours
- Daily forecasts for next 5 days

Parameters:
| Name  |  Requirement | Type  |
|---|---|---|
| `location`  | required  | String  |
| `units`  | optional  | String  |

**Units default to imperial but can be changed to metric; resulting in Celcius and meters/second measurement changes.**

Sample Request: ```https://sweater-weather-ad.herokuapp.com/api/v1/forecast?location=Denver```
<details>
<summary>Sample Response</summary>

```json
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "location": {
                "coordinates": {
                    "lat": 39.738453,
                    "lng": -104.984853
                },
                "city": "Denver",
                "state": "CO",
                "country": "US"
            },
            "current": {
                "time": "2021-02-12T17:47:44.000+00:00",
                "sunrise": "2021-02-12T13:55:53.000+00:00",
                "sunset": "2021-02-13T00:32:39.000+00:00",
                "temp": 1.38,
                "feels_like": -8.55,
                "humidity": 85,
                "uvi": 2.86,
                "visibility": 10000,
                "conditions": "light snow",
                "icon": "http://openweathermap.org/img/wn/13d.png"
            },
            "hourly": [
                {
                    "time": "17:00:00",
                    "temp": 1.38,
                    "wind_speed": "6.31 mph",
                    "wind_direction": "from N",
                    "conditions": "overcast clouds",
                    "icon": "http://openweathermap.org/img/wn/04d.png"
                },
                {
                    "time": "18:00:00",
                    "temp": 9.32,
                    "wind_speed": "6.64 mph",
                    "wind_direction": "from N",
                    "conditions": "overcast clouds",
                    "icon": "http://openweathermap.org/img/wn/04d.png"
                },
                {
                    "time": "19:00:00",
                    "temp": 15.58,
                    "wind_speed": "7 mph",
                    "wind_direction": "from N",
                    "conditions": "broken clouds",
                    "icon": "http://openweathermap.org/img/wn/04d.png"
                },
                {
                    "time": "20:00:00",
                    "temp": 20.12,
                    "wind_speed": "6.93 mph",
                    "wind_direction": "from N",
                    "conditions": "broken clouds",
                    "icon": "http://openweathermap.org/img/wn/04d.png"
                },
                {
                    "time": "21:00:00",
                    "temp": 22.32,
                    "wind_speed": "7 mph",
                    "wind_direction": "from N",
                    "conditions": "broken clouds",
                    "icon": "http://openweathermap.org/img/wn/04d.png"
                },
                {
                    "time": "22:00:00",
                    "temp": 22.57,
                    "wind_speed": "8.19 mph",
                    "wind_direction": "from N",
                    "conditions": "broken clouds",
                    "icon": "http://openweathermap.org/img/wn/04d.png"
                },
                {
                    "time": "23:00:00",
                    "temp": 22.28,
                    "wind_speed": "8.14 mph",
                    "wind_direction": "from N",
                    "conditions": "broken clouds",
                    "icon": "http://openweathermap.org/img/wn/04d.png"
                },
                {
                    "time": "00:00:00",
                    "temp": 21.16,
                    "wind_speed": "8.84 mph",
                    "wind_direction": "from N",
                    "conditions": "broken clouds",
                    "icon": "http://openweathermap.org/img/wn/04d.png"
                }
            ],
            "daily": [
                {
                    "date": "02/12/21",
                    "sunrise": "13:55:53",
                    "sunset": "00:32:39",
                    "temp_high": 22.57,
                    "temp_low": 1.38,
                    "conditions": "broken clouds",
                    "icon": "http://openweathermap.org/img/wn/04d.png"
                },
                {
                    "date": "02/13/21",
                    "sunrise": "13:54:40",
                    "sunset": "00:33:50",
                    "temp_high": 18.27,
                    "temp_low": 7.54,
                    "conditions": "light snow",
                    "icon": "http://openweathermap.org/img/wn/13d.png"
                },
                {
                    "date": "02/14/21",
                    "sunrise": "13:53:26",
                    "sunset": "00:35:00",
                    "temp_high": 7.83,
                    "temp_low": 0.75,
                    "conditions": "light snow",
                    "icon": "http://openweathermap.org/img/wn/13d.png"
                },
                {
                    "date": "02/15/21",
                    "sunrise": "13:52:11",
                    "sunset": "00:36:11",
                    "temp_high": 20.79,
                    "temp_low": -2.29,
                    "conditions": "broken clouds",
                    "icon": "http://openweathermap.org/img/wn/04d.png"
                },
                {
                    "date": "02/16/21",
                    "sunrise": "13:50:55",
                    "sunset": "00:37:21",
                    "temp_high": 39.42,
                    "temp_low": 15.03,
                    "conditions": "clear sky",
                    "icon": "http://openweathermap.org/img/wn/01d.png"
                }
            ]
        }
    }
}
```
</details>
----

<br>

### Backgrounds -- (*GET /backgrounds* - [Try it out](https://sweater-weather-ad.herokuapp.com/api/v1/backgrounds?location=miami)) <a name="backgrounds"></a>

Retrieve a background image URL from Pexel for a given city.

Parameters:
| Name  |  Requirement | Type  |
|---|---|---|
| `location`  | required  | String  |

Sample Request: `https://sweater-weather-ad.herokuapp.com/api/v1/backgrounds?location=miami`
<details>
<summary>Sample Response</summary>

```json
{
  "data": {
      "id": null,
      "type": "image",
      "attributes": {
          "image": {
              "location": "miami",
              "image_url": "https://www.pexels.com/photo/high-rise-buildings-during-nighttime-421655/",
              "credit": {
                  "source": "pexels.com",
                  "photographer": "Elvis Vasquez",
                  "photographer_url": "https://www.pexels.com/@elvis-vasquez-136708"
              }
          }
      }
  }
}
```
</details>

----

<br>
### Users -- (*POST /users* - [![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/a4dcb92c04e4fe9981ab)) <a name="users"></a>

Submit an email, password, and password confirmation to register and create that user in the database. A unique API key will be generated for the user.

Request Body:
| Keys  |  Requirement | Type  |
|---|---|---|
| `email`  | required  | String  |
| `password`  | required  | String  |
| `password_confirmation`  | required  | String  |

Sample Request: `https://sweater-weather-ag.herokuapp.com/api/v1/users`
<details>
<summary>Sample Request Body</summary>

```json
{
  "email": "me@user.com",
  "password": "54321",
  "password_confirmation": "54321"
}
```
</details>

<details>
<summary>Sample Response</summary>

```json
{
  "data": {
    "id": "1",
    "type": "user",
    "attributes": {
      "email": "me@user.com",
      "api_key": "5a341ecd-2eac-461e-924a-f9257a609345"
    }
  }
}
```
</details>

----

<br>
### Sessions -- (*POST /sessions* - [![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/a4dcb92c04e4fe9981ab)) <a name="sessions"></a>

Authenticate an existing user's email and password. Receive user unique API key generated by the previous endpoint.

Request Body:
| Keys  |  Requirement | Type  |
|---|---|---|
| `email`  | required  | String  |
| `password`  | required  | String  |

Sample Request: `https://sweater-weather-ag.herokuapp.com/api/v1/sessions`
<details>
<summary>Sample Request Body</summary>

```json
{
  "email": "me@user.com",
  "password": "54321"
}
```
</details>

<details>
<summary>Sample Response</summary>

```json
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "email": "me@user.com",
            "api_key": "5a341ecd-2eac-461e-924a-f9257a609345"
        }
    }
}
```
</details>

----

<br>
### Road Trip -- (*POST /road_trip* - [![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/a4dcb92c04e4fe9981ab)) <a name="roadtrip"></a>

Submit an origin and a destination along with a user's API key and receive information on travel time and the temperature / weather upon arrival.

Request Body:
| Keys  |  Requirement | Type  |
|---|---|---|
| `origin`  | required  | String  |
| `destination`  | required  | String  |
| `api_key`  | required  | String  |
| `units`  | optional | String  |


Sample Request: `https://sweater-weather-ag.herokuapp.com/api/v1/road_trip`
<details>
<summary>Sample Request Body</summary>

```json
{
  "origin": "Miami,FL",
  "destination": "Denver,CO",
  "api_key": "5a341ecd-2eac-461e-924a-f9257a609345"
}
```
</details>

<details>
<summary>Sample Response</summary>

```json
{
    "data": {
        "id": null,
        "type": "road_trip",
        "attributes": {
            "origin": "Miami,FL",
            "destination": "Denver,CO",
            "travel_time": "30:12:30",
            "weather_at_eta": {
                "temperature": 17.02,
                "conditions": "overcast clouds"
            }
        }
    }
}
```
</details>

----

## Technologies

- Framework: Ruby on Rails
- Testing: RSpec
- JSON Serializer: FastJsonAPI
- 3rd Party APIs:
  - OpenWeather API
  - MapQuest Geolocation API
  - MapQuest Direction API
  - Pexel API
- Response Caching: VCR & Webmock
- Test Coverage: SimpleCov
