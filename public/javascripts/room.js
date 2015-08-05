 var apiKey = 45297362;
 var sessionId ="<%=@group.sessionId%>" ;
 var token = "<%=@opentok_token%>";
 var session;
 OT.setLogLevel(OT.DEBUG);
 	session = OT.initSession(apiKey,sessionId);
 	session.on
 	({
 		streamCreated: function(event)
 		{
 			session.subscribe(event.stream,'subscribersDiv',{insertMode: 'append'});
 		}
 	});
 	session.connect(token,function(error){
 		if(error)
 		{
 			console.log(error.message);
 		}
 		else{
 			session.publish('myPublisherDiv',{width: 320,height: 240});
 		}
 	});	
 	