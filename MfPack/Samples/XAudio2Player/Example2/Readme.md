# XAudio2Player Sample 2

Version: X 3.1.6

Description:
  This sample demonstrates how to use XAudio2 to render different file formats like WAV, FLAC, MP3 etc.
  The samples uses the IMFSourceReader to decode the format suitable for playing in XAudio2.
  XAudio2 is the long-awaited replacement for DirectSound. It addresses several outstanding issues and feature requests, like
  low latency etc.
  
This sample shows you how to implement the IXAudio2VoiceCallback.
The sample uses the MfPeakMeter component. This requires that you install the MfComponents.
In your projectsettings you must add ..MfPack\Samples\MfComponents in the project options searchpath.  
It also have a pitch control. 

NOTES:
 - This release is updated for compiler version 17 up to 34.
 - SDK version 10.0.22621.0 (Win 11)
 - Requires Windows 10 or later.
 - Minimum supported MfPack version: 3.1.6

Project: Media Foundation - MFPack - Samples
Project location: https://github.com/FactoryXCode/MfPack
                  https://sourceforge.net/projects/MFPack

First release date: 02-04-2024
Final release date: 02-04-2024

Copyright © FactoryX. All rights reserved.