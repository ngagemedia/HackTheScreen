#Hack the Screen
This repo contains code and examples for talking to the alpha version of the Ngage Media API.

## Documentation Ngage API.

This is an early draft of the documentation, so please bear with us.

### The Screen
The resolution of the screen will be 1280x640, with a pixel pitch of 3.75mm. This makes it 4.8 meters wide, and 2.4 meters high. Interaction will usually take place at around 4-10 meters from the screens, in a high traffic location, mainly commuters.

### The Interaction Bar
The Interaction Bar is located above the screen and communicates via OSC over UDP to a destination computer.
Our beta version contains blob tracking and facial tracking on basis of an RGB camera. You might wonder why no 3D camera (kinect)? Because the interaction area is usually situated about 4-10 meters from the screens, and often the locations have sunlight interfering with infrared sensors.


### The protocol

##### Connecting to server
A connection is made by registering your IP address at the server. This is done via the following OSC Command
/OSC/AddClientIP 123 123 123 123
The server IP address will be 192.168.7.5 and the port is 7004.
Where you have to send your IP as 4 separate integers.
For the coding jam the server is set up to send all data to the clients. In real life you are able to cherry pick the data you need for your app.

##### Receiving from server

The server is set up send the data to port number 7004 on your IP.


##### The /ImageProcessing/Blobs/BlobData data

Once connected the server sends many OSC messages to your port 7004. /ImageProcessing is the standard address where this goes.
Next is /Faces/FaceData for face detection and /Blobs/BlobData for blobtracking.

##### Face tracking

FaceData sends OSC messages containing the following information:
					0. int faceID
					1. int groupID (always 0)
					2: float CenterPos.x
					3: float CenterPos.y
					4: float Velocity.X
					5: float Velocity.y
					6: float BoundingBox.x
					7: float BoundingBox.y
					8: float BoundingBox.Width
					9: float BoundingBox.Height
					10: float Acceleration.x
					11:float Acceleration.y

##### Blob tracking

BlobData sends OSC messages containing the following data:
					0: int blobID
					1: int groupID
					2: float CenterPos.x
					3: float CenterPos.y
					4: float Velocity.X
					5: float Velocity.y
					6: float BoundingBox.x
					7: float BoundingBox.y
					8: float BoundingBox.Width
					9: float BoundingBox.Height
					10: float Acceleration.x
					11:float Acceleration.y
					12+:float contours.x contours.y

The type tag of the OSC message looks something like iiffffffffffff, with the amount of floats varying depending on the contour.           

##### Examples

As far as working with the data, we're working on writing some libraries/classes to put each blob into an object for a few basic languages/programs (OpenFrameWorks, Processing, vvvv).
You can find them (when they're done) in the examples folder.

##### Camera stream

We also have an IP camera for streaming images, of which the address will be shared on Saturday.