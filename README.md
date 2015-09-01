# SwiftBridge

Basic Integration of Fuel into a swift app.

Changes to the propellerSDK.a - in the build settings for propellerSDK lib set the build setting "Defines Modules" to yes.  

In the swift project you will need a way for the swift to talk to the objective C.  You need to create a bridge header file.
You need to do this one time. Add a new obj-C file to a swift project and xcode will ask you and create the bridge header for you.
You can then import the propellerSDK.h file here.


