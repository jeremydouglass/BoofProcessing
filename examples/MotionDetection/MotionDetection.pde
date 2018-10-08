// Launches a webcam and searches for QR Codes, prints their message and draws their outline

import processing.video.*;
import boofcv.processing.*;
import java.util.*;

Capture cam;
SimpleMotionDetection detector;

void setup() {
  // Open up the camera so that it has a video feed to process
  initializeCamera(640, 480);
  surface.setSize(cam.width, cam.height);

  // Select which type of background model you wish to use and how they should
  // be configured

  detector = Boof.motionDetector(new ConfigBackgroundBasic(35, 0.005f));
  //detector = Boof.motionDetector(new ConfigBackgroundGmm());
}

void draw() {
  if (cam.available() == true) {
    cam.read();

    SimpleBinary binary = detector.segment(cam);

    image(binary.visualize(), 0, 0);
  }
}

void initializeCamera( int desiredWidth, int desiredHeight ) {
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    cam = new Capture(this, desiredWidth, desiredHeight);
    cam.start();
  }
}