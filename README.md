# what-to-do
a web app to find events near a zip code that have a non rainy weather forecast

KNOWN BUGS:

  sometimes the EventBrite API will return a city that is really far away, like colorado once in a while for 90210.  this would require a bit of effort to fix and slow things down so I've left it.

  the EventBrite api's return good data 99% of the time but in some rare instances their json response will be missing elements and the app does not gracefully handle these yet.  it's rare enough that I didn't try to mitigate it.

  if you get a circular reference error just stop and restart.  this is an oddness with the threading and I didn't have time to track it down but it's pretty rare.

TODOS:

  sort out all the security vulnerabilities that github is mad about

  currently the flash messages only display on root.  it would be nice to add a javascript validator for the zipcode and have the flash messages on all the pages

  convert google maps support from a config option to a user checkbox

  activemodel could be used with aggressive expiration to speed things up a tiny bit.  the apis are so lightweight and fast this was not a priority.

  currently any forecast with the word 'rain' in it is excluded.  the API has more granular distinction between the weather types and that could be exposed to the user

  HTML5 geolocation to automatically fill the users zipcode. 

  a link to add the event to your calendar would be cool too

  a styling pass by someone who actually has a sense of style wouldn't hurt.

NOTES: 

  ignoring these cops: Style/LineLength,Style/ExpandPathArguments,Metrics/BlockLength,Style/DateTime
