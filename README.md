# what-to-do
what to do in your area

known bugs:
  sometimes the API will return a city that is really far away, like colorado once in a while for 90210.  this would require a bit of effort to fix and slow things down so I've left it.

  the api's return good data 99% of the time but in some rare instances their json response will be missing elements and the app does not gracefully handle these yet.  it's rare enough that I didn't try to mitigate it.

  if you get a circular reference error just stop and restart.  this is an oddness with the threading and I didn't have time to track it down but it's pretty rare.

todo:
  currently the flash messages only display on root and errors are redirected to root for display.  there's no real reason this has to be this way and it'd be nice to add a javascript validator for the zipcode and have the flash messages on all the pages

  I put some rough google maps support in but it'd be nice to have it as a checkbox rather than a hidden feature

  activemodel could be used with aggressive expiration to speed things up a tiny bit.  the apis are so lightweight and fast this was not a priority.

  currently any forecast with the word 'rain' in it is excluded.  the API has more granular distinction between the weather types and that could be exposed to the user

  I would like to use HTML5 geolocation to automatically fill the users zipcode. 

  a link to add the event to your calendar would be cool too

  a styling pass by someone who actually has a sense of style wouldn't hurt.  I try but without a mockup ......

notes:
  you can turn google map embeds on by adding enable_google_maps=true  to the url.  I didn't like the look or speed of this so I didn't make it formal but it might actually be useful so I'm leaving it in as an easter egg.
  ignoring these cops: Style/LineLength,Style/ExpandPathArguments,Metrics/BlockLength,Style/DateTime

