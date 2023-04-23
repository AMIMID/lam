(
~e1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms6.wav",channels:0);
~e2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms6.wav",channels:1);
~e3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms6.wav",channels:2);
~e4 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/ms6.wav",channels:3);
)
(
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:~e1.numFrames.rand,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,1,BufRateScale.kr(1),startPos:~e2.numFrames.rand,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,2,BufRateScale.kr(2),startPos:~e3.numFrames.rand,loop:inf),LFNoise1.ar(1),width:2))}.play;
{Out.ar(0,PanAz.ar(4,PlayBuf.ar(1,3,BufRateScale.kr(3),startPos:~e4.numFrames.rand,loop:inf),LFNoise1.ar(1),width:2))}.play;
)

s.record(numChannels:4) ;