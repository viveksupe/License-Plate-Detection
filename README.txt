Our Presentation Slides:

https://prezi.com/0vrlpdgdyx_7/license-plate-detection-system/

ABSTRACT


In the last couple of decades, the number of vehicles has increased drastically. With this increase, it is becoming difficult to keep track of each vehicle for the purpose of law enforcement and traffic management. Licence Plate Detection System is being used increasingly nowadays for automatic toll collection, maintaining traffic activities and law enforcement. 

Our project has been divided into 4 phases: 
1.	Location Phase: This is the first phase where we try to identify the location of the licence plate in an image of the car. 
2.	Cleaning Phase: Here, we remove all the small group of black pixels which maybe dirt spots, bolts etc. This is noise and it affects character recognition and hence is a very essential phase.  
3.	Optical Character Recognition Phase: We use the Tesseract OCR to extract the text from a given image.
4.	Information Extraction Phase: Here we use the output obtained from OCR to query the database and obtain retrieve information about the vehicle and its owner. 

We have implemented our project in MATLAB and SQL. 

Constraints:
Due to the limited amount of time we have, a set of constraints have been placed on our system to make the project more manageable, they are as follows:

• Image of the vehicle taken from fixed angle.
• Image of the vehicle taken from fixed distance.
• Vehicle is stationary when the image was taken.
