# LoopbackCapture Sample 2

Version: X 3.1.5

Description:
Demonstrates how to capture system audio either from a specific process tree or for all process except a process tree and
the use of ActivateAudioInterfaceAsync Win32 API with a new initialization structure. 
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

It also demonstrates how to get a processes by using the tlhelp32 API, to list a snapshot of running processes and be able to pick one.
The application is provided with a dialog to select a running process from the process tree you want to pick and has
a button to get the current PID of your application.

NOTES: 
 - This release is updated for compiler version 17 up to 34.
 - SDK version 10.0.22621.0 (Win 11)
 - Requires Windows 10 build 20348 or later.
 - Minimum supported MfPack version: 3.1.4

Project: Media Foundation - MFPack - Samples
Project location: https://github.com/FactoryXCode/MfPack
                  https://sourceforge.net/projects/MFPack

First release date: 02-04-2023
Final release date: 05/05/2023

Copyright © FactoryX. All rights reserved.