# what-to-do
what to do in your area

known bugs:
  the api's return good data 99% of the time but in some rare instances their json response will be missing elements and the app does not gracefully handle these.  
  sometimes the API will return a city that is really far away, like colorado once in a while for 90210.  this would require a bit of effort to fix and slow things down so I've left it.

todo:
  the current version uses no ActiveModel.  I thought it would be useful and originally set things up with mysql, but in the end there didn't seem to be much benefit.  That said, a fast expiry cache could speed this app up and reduce API key usage and a little bandwidth so it would be towards the top of internal feature improvements.

  currently any forecast with the word 'rain' in it is excluded.  the API has more granular distinction between the weather types and that could be exposed to the user

  I would like to use HTML5 geolocation to automatically fill the users zipcode. 

  Google maps inline with the events would be pretty cool

  a link to add the event to your calendar would be cool too

notes:
  ignoring these cops: Style/LineLength,Style/ExpandPathArguments,Metrics/BlockLength,Style/DateTime
