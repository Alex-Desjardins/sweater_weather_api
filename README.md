# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Assignment
You will build an endpoint that will retrieve the forecast for a location and nearby trails with the distance to each trail.
Your endpoint should follow this format:
GET /api/v1/trails?location=denver,co
Your API will return:
- current temperature and conditions for the start location (your location)
- name of the trail
- summary of each trail
- difficulty of each trail
- location of each trail
- estimated distance to each trail
Your response should be in the format below:
{
  "data": {
    "id": "null",
    "type": "trail",
    "attributes": {
      "location": "denver,co",
      "forecast": {
        "summary": "Cloudy with a chance of meatballs",
        "temperature": "83"
      },
      "trails": [
        {
          "name": "Boulder Skyline Traverse",
          "summary": "The classic long mountain route in Boulder."
          "difficulty": "black"
          "location": "Superior, Colorado"
          "distance_to_trail": "23.008"
        },
        {
          "name": "Bear Peak Out and Back",
          "summary": "A must-do hike for Boulder locals and visitors alike!"
          "difficulty": "black"
          "location": "Boulder, Colorado"
          "distance_to_trail": "30.098"
        },
        {...}
      ]
    }
  }
}
