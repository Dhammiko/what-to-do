# what-to-do
a rails app to find events near a zip code that have a non rainy weather forecast

KNOWN BUGS:
  EventBrite API will occasionally return a city far from the intended zipcode.

TODOS:

  Add a javascript validator for zip code.

  Add a user checkbox to enable google maps support (instead of a config option).

  Investigate speed increases through use of ActiveModel for object caching.

  Expose more granular weather choices to the user, like letting them set what % of rain is okay, or only prefer completely clear skies no clouds.

  HTML5 geolocation to automatically fill the users zipcode. 

  A link to add an event to your calendar.

  Styling by someone who is good at styling

NOTES: 

  eager loading and class caching is enabled so you have to restart the server if you change some things
