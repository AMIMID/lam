////////////audio and buffer settings

s.options.numOutputBusChannels=2;
TempoClock.default.tempo_(120/120)
);
s.options.memSize = 8192*16;

~e.play
~e.numFrames;
e.numChannels;
e.duration;
numSamples = numFrames * numChannels
~e.numFrames * e.numChannels
e.sampleRate
s.sampleRate
e.query

////////////buffer from recording from granulator file
~e = Buffer.read(s,"/Users/petrostatsiopoulos/Dokuments/PROJECT  FILES/composition/#3/sc/ synth/audio files/gran wind modfreq2.wav")
);

//////////individual Synth Definitions which apply band pass filters in 30 individual tones to the noise recording from Granulator file, in stereo)
(

/////////////1st Lamdoma "octave" a=1 from y=(x+a)x where y is the interface tone (final audio)

(SynthDef.new(\wind1_1, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=1;a=0;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

(SynthDef.new(\wind2_1, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=1;a=1;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind3_2, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=2;a=1;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind4_3, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=3;a=1;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

/////////////2nd Lamdoma

(SynthDef.new(\wind3_1, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=1;a=2;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind4_2, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=2;a=2;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind5_3, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=3;a=2;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind6_4, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=4;a=2;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind7_5, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=5;a=2;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind8_6, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=6;a=2;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

/////////////3d Lamdoma

(SynthDef.new(\wind4_1, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=1;a=3;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind5_2, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=2;a=3;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind6_3, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=3;a=3;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind7_4, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=4;a=3;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind8_5, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=5;a=3;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind9_6, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=6;a=3;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind10_7, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=7;a=3;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind11_8, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=8;a=3;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind12_9, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=9;a=3;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

///////////////////////4th Lamdoma
(SynthDef.new(\wind5_1, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=1;a=4;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind6_2, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=2;a=4;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind7_3, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=3;a=4;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind8_4, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=4;a=4;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind9_5, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=5;a=4;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind10_6, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=6;a=4;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind11_7, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=7;a=4;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind12_8, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=8;a=3;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind13_9, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=9;a=4;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind14_10, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=10;a=4;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind15_11, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=11;a=4;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind16_12, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=12;a=4;fund=496;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);


////////////////////////2ND OCTAVE

(SynthDef.new(\windb1_1, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=1;a=0;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

(SynthDef.new(\windb2_1, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=1;a=1;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb3_2, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=2;a=1;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb4_3, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=3;a=1;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

/////////////2nd Lamdoma

(SynthDef.new(\windb3_1, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=1;a=2;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb4_2, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=2;a=2;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb5_3, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=3;a=2;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb6_4, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=4;a=2;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb7_5, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=5;a=2;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb8_6, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=6;a=2;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

/////////////3d Lamdoma

(SynthDef.new(\windb4_1, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=1;a=3;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb5_2, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=2;a=3;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb6_3, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=3;a=3;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb7_4, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=4;a=3;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb8_5, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=5;a=3;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb9_6, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=6;a=3;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb10_7, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=7;a=3;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb11_8, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=8;a=3;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb12_9, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=9;a=3;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

///////////////////////4th Lamdoma
(SynthDef.new(\windb5_1, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=1;a=4;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb6_2, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=2;a=4;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb7_3, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=3;a=4;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb8_4, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=4;a=4;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb9_5, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=5;a=4;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb10_6, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=6;a=4;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb11_7, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=7;a=4;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb12_8, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=8;a=3;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb13_9, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=9;a=4;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb14_10, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=10;a=4;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb15_11, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=11;a=4;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\windb16_12, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000/2;x=12;a=4;fund=496*2;pass=0.0001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
)
///////task that sequences the tones in series and in loop in random intervals

(
Tdef.new(\h,{loop({
Synth.new(\wind1_1);1.999.rand.wait;
Synth.new(\wind2_1);1.999.rand.wait;
Synth.new(\wind3_2);1.999.rand.wait;
Synth.new(\wind4_3);1.999.rand.wait;
Synth.new(\wind3_1);1.999.rand.wait;
Synth.new(\wind4_2);1.999.rand.wait;
Synth.new(\wind5_3);1.999.rand.wait;
Synth.new(\wind6_4);1.999.rand.wait;
Synth.new(\wind7_5);1.999.rand.wait;
Synth.new(\wind8_6);1.999.rand.wait;
Synth.new(\wind4_1);1.999.rand.wait;
Synth.new(\wind5_2);1.999.rand.wait;
Synth.new(\wind6_3);1.999.rand.wait;
Synth.new(\wind7_4);1.999.rand.wait;
Synth.new(\wind8_5);1.999.rand.wait;
Synth.new(\wind9_6);1.999.rand.wait;
Synth.new(\wind10_7);1.999.rand.wait;
Synth.new(\wind11_8);1.999.rand.wait;
Synth.new(\wind12_9);1.999.rand.wait;
Synth.new(\wind5_1);1.999.rand.wait;
Synth.new(\wind6_2);1.999.rand.wait;
Synth.new(\wind7_3);1.999.rand.wait;
Synth.new(\wind8_4);1.999.rand.wait;
Synth.new(\wind9_5);1.999.rand.wait;
Synth.new(\wind10_6);1.999.rand.wait;
Synth.new(\wind11_7);1.999.rand.wait;
Synth.new(\wind12_8);1.999.rand.wait;
Synth.new(\wind13_9);1.999.rand.wait;
Synth.new(\wind14_10);1.999.rand.wait;
Synth.new(\wind15_11);1.999.rand.wait;
Synth.new(\wind16_12);1.999.rand.wait;
}
)})
)

Tdef(\h).stop;
Tdef(\h).play;
Tdef(\h).clear;


/////////////////////intividual Synth definition tone triggers
Synth.new(\wind1_1);
Synth.new(\wind2_1);
Synth.new(\wind3_2);
Synth.new(\wind4_3);
Synth.new(\wind3_1);
Synth.new(\wind4_2);
Synth.new(\wind5_3);
Synth.new(\wind6_4);
Synth.new(\wind7_5);
Synth.new(\wind8_6);
Synth.new(\wind4_1);
Synth.new(\wind5_2);
Synth.new(\wind6_3);
Synth.new(\wind7_4);
Synth.new(\wind8_5);
Synth.new(\wind9_6);
Synth.new(\wind10_7);
Synth.new(\wind11_8);
Synth.new(\wind12_9);
Synth.new(\wind5_1);
Synth.new(\wind6_2);
Synth.new(\wind7_3);
Synth.new(\wind8_4);
Synth.new(\wind9_5);
Synth.new(\wind10_6);
Synth.new(\wind11_7);
Synth.new(\wind12_8);
Synth.new(\wind13_9);
Synth.new(\wind14_10);
Synth.new(\wind15_11);
Synth.new(\wind16_12);
Synth.new(\windb1_1);
Synth.new(\windb2_1);
Synth.new(\windb3_2);
Synth.new(\windb4_3);
Synth.new(\windb3_1);
Synth.new(\windb4_2);
Synth.new(\windb5_3);
Synth.new(\windb6_4);
Synth.new(\windb7_5);
Synth.new(\windb8_6);
Synth.new(\windb4_1);
Synth.new(\windb5_2);
Synth.new(\windb6_3);
Synth.new(\windb7_4);
Synth.new(\windb8_5);
Synth.new(\windb9_6);
Synth.new(\windb10_7);
Synth.new(\windb11_8);
Synth.new(\windb12_9);
Synth.new(\windb5_1);
Synth.new(\windb6_2);
Synth.new(\windb7_3);
Synth.new(\windb8_4);
Synth.new(\windb9_5);
Synth.new(\windb10_6);
Synth.new(\windb11_7);
Synth.new(\windb12_8);
Synth.new(\windb13_9);
Synth.new(\windb14_10);
Synth.new(\windb15_11);
Synth.new(\windb16_12);


//////////////////////////////midi interface osc (OpenSoundControl) where keys are a matrix pad, knob/slider1 is gain, knob/slider2 and knob/slider3 are Attack/Decay envelopes for the indiviual or grouped tones. Output is in stereo i.g. synth outputs spatialized audio.
////Extra knobs/sliders can be filters like low pass or high pass. The Lamdoma can be tuned to different fundamental frequences 496-880 Hz, this could be basic knob/slider4

MIDIClient.init;
MIDIIn.connectAll;
~note=Array.newClear(128);
~bend=8192;
~data=127;
~modul=127;

/////
(
MIDIdef.noteOn(\synhtone,{|val,num,chan,src|[val,num,chan,src].postln;
	if( num==38,{Synth.new(\wind1_1)});
	if( num==39,{Synth.new(\wind2_1)});
	if( num==50,{Synth.new(\wind3_2)});
	if( num==51,{Synth.new(\wind4_3)});
	if( num==52,{Synth.new(\wind3_1)});
	if( num==53,{Synth.new(\wind1_1)});
	if( num==53,{Synth.new(\wind1_1)});
	if( num==55,{Synth.new(\wind1_1)});
	if( num==56,{Synth.new(\wind1_1)});
	if( num==57,{Synth.new(\wind1_1)});
	if( num==58,{Synth.new(\wind1_1)});
	if( num==59,{Synth.new(\wind1_1)});
	if( num==60,{Synth.new(\wind1_1)});
	if( num==61,{Synth.new(\wind1_1)});
	if( num==62,{Synth.new(\wind1_1)});
	if( num==63,{Synth.new(\wind1_1)});
	if( num==63,{Synth.new(\wind1_1)});
	if( num==65,{Synth.new(\wind1_1)});
	if( num==52,{Synth.new(\wind1_1)});
	if( num==53,{Synth.new(\wind1_1)});
	if( num==53,{Synth.new(\wind1_1)});
	if( num==55,{Synth.new(\wind1_1)});
	if( num==56,{Synth.new(\wind1_1)});
	if( num==57,{Synth.new(\wind1_1)});
	if( num==58,{Synth.new(\wind1_1)});
	if( num==59,{Synth.new(\wind1_1)});
	if( num==60,{Synth.new(\wind1_1)});
	if( num==61,{Synth.new(\wind1_1)});
	if( num==62,{Synth.new(\wind1_1)});
	if( num==63,{Synth.new(\wind1_1)});
	if( num==63,{Synth.new(\wind1_1)});
	if( num==63,{Synth.new(\wind1_1)});
	if( num==38,{Synth.new(\wind1_1)});
	if( num==39,{Synth.new(\wind1_1)});
	if( num==50,{Synth.new(\wind1_1)});
	if( num==51,{Synth.new(\wind1_1)});
	if( num==52,{Synth.new(\wind1_1)});
	if( num==53,{Synth.new(\wind1_1)});
	if( num==53,{Synth.new(\wind1_1)});
	if( num==55,{Synth.new(\wind1_1)});
	if( num==56,{Synth.new(\wind1_1)});
	if( num==57,{Synth.new(\wind1_1)});
	if( num==58,{Synth.new(\wind1_1)});
	if( num==59,{Synth.new(\wind1_1)});
	if( num==60,{Synth.new(\wind1_1)});
	if( num==61,{Synth.new(\wind1_1)});
	if( num==62,{Synth.new(\wind1_1)});
	if( num==63,{Synth.new(\wind1_1)});
	if( num==63,{Synth.new(\wind1_1)});
	if( num==65,{Synth.new(\wind1_1)});
	if( num==52,{Synth.new(\wind1_1)});
	if( num==53,{Synth.new(\wind1_1)});
	if( num==53,{Synth.new(\wind1_1)});
	if( num==55,{Synth.new(\wind1_1)});
	if( num==56,{Synth.new(\wind1_1)});
	if( num==57,{Synth.new(\wind1_1)});
	if( num==58,{Synth.new(\wind1_1)});
	if( num==59,{Synth.new(\wind1_1)});
	if( num==60,{Synth.new(\wind1_1)});
	if( num==61,{Synth.new(\wind1_1)});
	if( num==62,{Synth.new(\wind1_1)});
	if( num==63,{Synth.new(\wind1_1)});
	if( num==63,{Synth.new(\wind1_1)});
})
)