Data Acquisition
===

The application will turn around an Electron application. Electron works with
Javascript, but can call directly C, run shell command, or could call 
a Java/Python/anything server.


AHK
----

First part is to take pictures with AHK
We must move images into `electron/captures`.


Tesseract
----


Second part of the project is to transform pictures into text.
 
I have used a Javascript version of the Tesseract OCR which makes it easy to use
from Javascript. You can see the `tesseract-test` folder.
 
http://tesseract.projectnaptha.com/
 
I suggest that all test will be done with Notepad captures, so that we use the same tool.
I don't know what is the quality with Notepad, I've made my test under macOS.

* first iteration: read and put text in the `results` place
* second iteration: improve the recognition quality
* third iteration: improve the recognition speed



  
### Train datas


https://blog.cedric.ws/how-to-train-tesseract-301
http://vietocr.sourceforge.net/training.html


### Improve image quality

It can also be possible to improve quality of image for some images
by removing for example a grey background color. This might be done by AHK.


### Use C++

Then to improve performances
    - use C++ version of tesseract
    - call it from Javascript  




Concat-Stream
----

Last part is to gather texts pieces in a coherent text. I will do
most that job as I master javascript.





