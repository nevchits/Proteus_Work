Boom Controller Operation - How to demonstrate

for your demonstration, these are the important pin numbers to remember on the TL074 opamps:
UPPERMOST OPAMP:
	PIN 1 : Train on Bridge - Ground this pin to simulate a train on the bridge
	PIN 14: Train Approaching Bridge - Ground this to simulate a train approaching

LOWER OPAMP
	PIN 1 : Car on Bridge - Ground this Pin to Simulate the train on the bridge
	PIN 7 : Car Off the bridge - Ground this pin to simulate a car getting off the bridge
	PIN 8 : Train Off Bride - Ground this pin to simulate train getting off the bridge 

when you turn the system on for the first time, it will run a SELF-TEST procedure. during the process, it will write "*********", "BRIDGE TRAFFIC CONTROLLER".
it will then flash all the Traffic light LEDs once, and write "88" on the Seven segment displays. it will then write "No Train. Ready...". at this point in time, the system will be ready.
NOTE: the green timer LED will be flashing the whole time. 

There are 2 Basic Scenarios you can demonstrate: Train apporaching (normal) and Train approaching with Car on the Bridge.

1. TRAIN APPROACHING DEMO PROCEDURE
	a. Ground Pin 14 of the uppermost opamp (Train on bridge).
		- the system will write "Train Approaches." it'll then begin the 15-second 		  countdown.
	b. During the 15-second countdown, ground Pin 7 of the lower opamp for the duration of 	  	   the count down. this signifies the final cars getting off the bridge.
		- when the countdown completes, the traffic lights should go from green -> amber
		  -> Red. and the motor should turn to signify the boom gate closing.
	c. Release the ground on Pin 7 of the lower opamp.
	d. Ground pin 1 of the upper opamp to signify the presence of a train on the bridge.
		- the system will write "TRAIN ON BRIDGE" each time you ground Pin 1 of the upper
		  opamp.
	e. then to signify that the train has left the bridge, ground Pin 8 of the lower opamp.
		- the system will then write "Train Passed." then revert to "No Train. Ready..."

2. TRAIN APPROACHING WITH CAR ON BRIDGE
	a. Ground Pin 14 of the uppermost opamp (Train on bridge).
		- the system will write "Train Approaches." it'll then begin the 15-second 		  countdown.
	b. During the 15-second countdown, ground Pin 1 of the lower opamp for the duration of 	  	   the count down. this signifies that there's still a car on the bridge.
		- when the countdown completes, the system will write "There's a car on the 		  Bridge!" and the RED led that signifies the train stop will light up.
		- the traffic lights should go from green -> amber
		  -> Red. and the motor should turn to signify the boom gate closing.
		- The system will also write "Train Stopped."
	c. to signify the car finally getting off the bridge, ground pin 7 of the lower opamp.
		- the system LCD should go blank.
	d. Ground pin 1 of the upper opamp, to signify that the train is now on the bridge.
	e. Then gorund Pin 8 of the Lower opamp to signify that the train is off the bridge.
		- the system will then write "Train Passed." then revert to "No Train. Ready..."

NOTE: There are three pins that are unimplemented:
	PIN  7 on the upper opamp: it is the "Car approaches" sensor. it was meant to assist in controlling the boom closing procedure, but it is unimplemented because it introduced programming complications.
	PIN 8 on the upper opamp: it is the "Train approaches" sensor. it was replaced by PIN 14 on the upper opamp.
	PIN 14 on the lower opamp: this pin is Not connected to anything.


Please report any bugs that you may encounter, especially ones that may affect the outcome of your presentation.

All the Best!

