// Please check http://ubaa.net/shared/processing/opencv/ for OPENCV 4 Processing installation instructions
// - Ca3rine
import hypermedia.video.*;
import java.awt.Rectangle;

OpenCV opencv;

// contrast/brightness values
int contrast_value    = 0;
int brightness_value  = 0;

boolean debug = true;


void setup() {

    size( 320, 240 );

    opencv = new OpenCV( this );
    opencv.capture( width, height );                   // open video stream
    opencv.cascade( OpenCV.CASCADE_FRONTALFACE_ALT );  // load detection description, here-> front face detection : "haarcascade_frontalface_alt.xml"



}


public void stop() {
    opencv.stop();
    super.stop();
}



void draw() {
    println(faceDetection());
}



boolean faceDetection(){
  // grab a new frame
  // and convert to gray
  opencv.read();
  opencv.convert( GRAY );
  opencv.contrast( contrast_value );
  opencv.brightness( brightness_value ); 
   // proceed detection
  Rectangle[] faces = opencv.detect( 1.2, 2, OpenCV.HAAR_DO_CANNY_PRUNING, 40, 40 );
  if(debug){
    // display the image
    image( opencv.image(), 0, 0 );
  
    // draw face area(s)
    noFill();
    stroke(255,0,0);
    for( int i=0; i<faces.length; i++ ) {
        rect( faces[i].x, faces[i].y, faces[i].width, faces[i].height ); 
    }
  }
  
 return (faces.length > 0)? true: false;
  
}


