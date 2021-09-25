Version: X 3.0.2
Enigma release #5.

# Application loopback API Capture Sample

This sample demonstrates the use of ActivateAudioInterfaceAsync Win32 API with a new initialization structure. 
The new data structure makes it possible to restrict captured audio data to that rendered by a specific 
process and any of its child processes. Windows 10 has always supported capturing all audio that is played on 
an audio endpoint (referred to as "system" loopback capture), which captures all audio from all apps that 
are playing sounds on the chosen audio endpoint. 

With the new structure, only audio from the specified process, and its children, will be captured. Audio rendered by
other processes will not be captured. A flag is also provided to reverse the behavior, capturing all system
audio *except* those from the the specified process (and its children). Furthermore, the capture is not tied to a 
specific audio endpoint, eliminating the need to create a separate IAudioClient to capture from each physical 
audio endpoint. 

If the processes whose audio will be captured does not have any audio rendering streams, then the capturing 
process receives silence.

To use this sample, obtain the process ID for the process tree you wish to capture or exclude from capture.
You can use Task Manager or the tlist program to get this ID. Run the sample with the process ID, the
desired capture mode (including the process tree or excluding it), and the output WAV file.


# Note that this sample requires Windows 10 build 20348 or later.
    
Project: Media Foundation - MFPack - Samples
Project location: https://github.com/FactoryXCode/MfPack
                  https://sourceforge.net/projects/MFPack

First release date: 20-08-2021
Final release date: 2021

Copyright © FactoryX. All rights reserved.