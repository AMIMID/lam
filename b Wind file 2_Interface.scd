////////////audio and buffer settings

s.options.numOutputBusChannels=4;
TempoClock.default.tempo_(120/480)
);
s.options.memSize = 8192*16;

~e.play
~e2.numFrames;
e.numChannels;
e.duration;
numSamples = numFrames * numChannels
~e.numFrames * e.numChannels
e.sampleRate
s.sampleRate
e.query

////////////buffer from
~e = Buffer.read(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_230403_212201.wav")

//////////individual Synth Definitions which apply band pass filters in 30 individual tones to the noise recording from Granulator file, in stereo)
(

/////////////1st Lamdoma "octave" a=1 from y=(x+a)x where y is the interface tone (final audio)

(SynthDef.new(\1, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=1;a=0;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

(SynthDef.new(\2, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=2;a=1;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\3, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=3;a=1;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\4, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=4;a=1;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

(SynthDef.new(\5, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=5;a=2;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\6, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=5;a=2;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\7, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=6;a=2;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\8, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=7;a=2;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\9, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=8;a=2;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\10, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=9;a=2;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

(SynthDef.new(\11, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=10;a=3;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\12, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=11;a=3;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

////


(SynthDef.new(\13, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=13;a=0;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

(SynthDef.new(\14, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=14;a=1;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\15, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=15;a=1;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\16, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=16;a=1;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

(SynthDef.new(\17, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=17;a=2;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\18, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=18;a=2;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\19, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=19;a=2;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\20, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=20;a=2;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\21, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=21;a=2;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\22, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=22;a=2;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);

(SynthDef.new(\23, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=23;a=3;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\24, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=24;a=3;fund=880;pass=0.001;pitch=(2.pow(x/12));env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(4,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
)
///////task that sequences the tones in series and in loop in random intervals
(
(
Tdef.new(\h,{loop({
Synth.new(\wind1_1);1.999.rand.wait;

Synth.new(\wind4_3);1.999.rand.wait;
Synth.new(\wind3_1);1.999.rand.wait;

Synth.new(\wind5_2);1.999.rand.wait;

}
)})
);
(
Tdef.new(\q,{loop({
Synth.new(\wind1_1);1.999.rand.wait;

Synth.new(\wind4_3);1.999.rand.wait;
Synth.new(\wind3_1);1.999.rand.wait;

Synth.new(\wind5_2);1.999.rand.wait;

}
)})
);
(
Tdef.new(\p,{loop({
Synth.new(\wind1_1);1.999.rand.wait;

Synth.new(\wind4_3);1.999.rand.wait;
Synth.new(\wind3_1);1.999.rand.wait;

Synth.new(\wind5_2);1.999.rand.wait;

}
)})
))

Tdef(\h).stop;
Tdef(\h).play;
Tdef(\h).clear;
Tdef(\q).stop;
Tdef(\q).play;
Tdef(\q).clear;
Tdef(\p).stop;
Tdef(\p).play;
Tdef(\p).clear;
s.record(numChannels:4) ;
/////////////////////intividual Synth definition tone triggers
Synth.new(\wind1_1);

Synth.new(\wind4_3);
Synth.new(\wind3_1);

Synth.new(\wind5_2);


//////////////////////////////midi interface osc (OpenSoundControl) where keys are a matrix pad, knob/slider1 is gain, knob/slider2 and knob/slider3 are Attack/Decay envelopes for the indiviual or grouped tones. Output is in stereo i.g. synth outputs spatialized audio.
////Extra knobs/sliders can be filters like low pass or high pass. The Lamdoma can be tuned to different fundamental frequences 880-880 Hz, this could be basic knob/slider4

MIDIClient.init;
MIDIIn.connectAll;
~note=Array.newClear(1880);
~bend=8192;
~data=127;
~modul=127;

/////
(
MIDIdef.noteOn(\synhtone,{|val,num,chan,src|[val,num,chan,src].postln;
	if( num==38,{Synth.new(\1)});
	if( num==39,{Synth.new(\2)});
	if( num==50,{Synth.new(\3)});
	if( num==51,{Synth.new(\4)});
	if( num==52,{Synth.new(\5)});
	if( num==53,{Synth.new(\6)});
	if( num==53,{Synth.new(\7)});
	if( num==55,{Synth.new(\8)});
	if( num==56,{Synth.new(\9)});
	if( num==57,{Synth.new(\10)});
	if( num==58,{Synth.new(\11)});
	if( num==59,{Synth.new(\12)});
	if( num==60,{Synth.new(\13)});
	if( num==61,{Synth.new(\14)});
	if( num==62,{Synth.new(\15)});
	if( num==63,{Synth.new(\16)});
	if( num==63,{Synth.new(\17)});
	if( num==65,{Synth.new(\18)});
	if( num==52,{Synth.new(\19)});
	if( num==53,{Synth.new(\20)});
	if( num==53,{Synth.new(\21)});
	if( num==55,{Synth.new(\22)});
	if( num==56,{Synth.new(\23)});
	if( num==57,{Synth.new(\24)});
})
)