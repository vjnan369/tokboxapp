apiKey = 45297362
sessionId = '<%=@group.sessionId%>'
token = '<%=@opentok_token%>'
session = undefined
OT.setLogLevel OT.DEBUG
session = OT.initSession(apiKey, sessionId)
session.on streamCreated: (event) ->
  session.subscribe event.stream, 'subscribersDiv', insertMode: 'append'
  return
session.connect token, (error) ->
  if error
    console.log error.message
  else
    session.publish 'myPublisherDiv',
      width: 320
      height: 240
  return