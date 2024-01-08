---
title: "Recording and upgraded video calls under Windows 10"
date: 2020-08-30 12:00:00
categories:
  - "Computing"
  - "Configuration"
tags:
draft: true
---

Just recording:

 * ASIO drivers low latency
 * ...
 * Done

Upgrading your video calls:

 * Internal routing with VoiceMeeter Potato (or Banana)

Reaper routing:

 * ASIO interface driver
 * Routing:
     - 1/2 -> Mon 1/2
     - 1/2 -> DAW 7/8

Focusrite routing:

 * Mix 1 (L/R) -> Monitor Output 1/2 (speakers)
 * Mix 1 (L/R) -> Line Output 3/4 (headphones)
 * Daw 7/8     -> Loop Back 1/2

Voicemeeter Potato routing:

 * A1 - A5 hardware out: I configure A1 to Focusrite USB ASIO
 * By default, input channels A1 - A5 (renamable) map the ASIO inputs, which from the Scarlett is Mic 1+2, Line 3+4, Loop 1+2 and (presumably) SPDIF 1+2 (eg the 8i in 8i6)

 * Virtual inputs are mapped (virtual audio device to input channel label):
     - Voicemeeter Input       --> "Voicemeeter VAIO"
     - Voicemeeter Aux Input   --> "Voicemeeter AUX"
     - Voicemeeter VAIO3 Input --> "VAIO 3"

 * Virtual outputs are mapped (output channel label to virtual audio device):
     - B1 --> Voicemeeter Output
     - B2 --> Voicemeeter Aux Output
     - B3 --> Voicemeeter VAIO3 Output

ASIO - low latency, direct hardware access, bypasses windows audio but doesn't share nicely.
WDM - actually means WASAPI and means running the audio interface in exclusive mode.
KS - kernel streaming, or Windows Driver Model (WDM), released in Win98. Most applications drive audio through this.
MME - native audio driver, oldest, released in Win 3.1.