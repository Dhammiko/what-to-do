# what-to-do
a rails app to find events near a zip code that have a non rainy weather forecast

KNOWN BUGS:

  EventBrite API will occasionally return a city far from the intended zipcode.

  EventBrite API will very rarely return malformed JSON.  Input like 99999 six months from now can cause this.

TODOS:

  Add the flash messages on the events index as well as home index.

  Add a javascript validator for zip code.

  Add a user checkbox to enable google maps support (instead of a config option).

  Investigate speed increases through use of ActiveModel for object caching.

  Expose more granular weather choices to the user, like letting them set what % of rain is okay, or only prefer completely clear skies no clouds.

  HTML5 geolocation to automatically fill the users zipcode. 

  A link to add an event to your calendar.

  Styling by someone who is good at styling

NOTES: 

  ignoring these rubocops: Style/LineLength,Style/ExpandPathArguments,Metrics/BlockLength,Style/DateTime
