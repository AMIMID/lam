s.options.sampleRate = 44100;
s.options.numBuffers = 1024*4;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;å
s.options.outputStreamsEnabled.postln
s.options.device_("USB Sound Device");
s.record(numChannels:4) ;

({Out.ar(2,SoundIn.ar(0))}.play;
s.record(numChannels:4)

s.options.numWireBufs = 1024*4;

s.options.numOutputBusChannels=43;/////////////40tet1 +40tet2 +
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
s.reboot;

~p1 = Buffer.read(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/lamkeysl.wav")
~p2 = Buffer.read(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/lamkeysr.wav")


(
SynthDef.new(\t, {

	var env,gain,duration,face1,face2,face3,face4;
	var edge1a,edge1b,edge1c,edge2a,edge2b,edge2c;
	var edge3a,edge3b,edge3c,edge4a,edge4b,edge4c;
	var v3a,v3b,v3c,v3d,v3e,v3f;
	var v4a,v4b,v4c,v4d,v4e,v4f;
	var v2a,v2b,v2c,v2d,v2e,v2f;
	var v1a,v1b,v1c,v1d,v1e,v1f;
	var azimuth1, azimuth2;

	duration=340;
	gain=2;

	env = EnvGen.ar(Env.new([0,1,1,0],[1,340,1],gain), doneAction: 2);
////////////////////////////////////////////////////////////////////////////	////////
	azimuth1 = Out.ar(3,Pan2.ar(LeakDC.ar(PlayBuf.ar(1,0,BufRateScale.kr(0),inf),mul:env),pos:MouseX.kr(-1,1)));

	azimuth2 = Out.ar(5,Pan2.ar(LeakDC.ar(PlayBuf.ar(1,1,BufRateScale.kr(0),inf),mul:env),pos:MouseY.kr(-1,1)));
	/////////////////////////////////////////////////////////

	face1 = Out.ar(7,PanAz.ar(3,LeakDC.ar(InFeedback.ar(3)),SinOsc.ar(3/4),env,width:2));

	face2 = Out.ar(10,PanAz.ar(3,LeakDC.ar(InFeedback.ar(4)),SinOsc.ar(3/4),env,width:2));

	face3 = Out.ar(14,PanAz.ar(3,LeakDC.ar(InFeedback.ar(5)),SinOsc.ar(3/4),env,width:2));

	face4 = Out.ar(17,PanAz.ar(3,LeakDC.ar(InFeedback.ar(6)),SinOsc.ar(3/4),env,width:2));
///////////////////////////////////////////////////////////////////////////////

	edge1a = Out.ar(19,Pan2.ar(InFeedback.ar(7),SinOsc.ar(3/4),env));
	edge1b = Out.ar(21,Pan2.ar(InFeedback.ar(8),SinOsc.ar(3/4),env));
	edge1c = Out.ar(23,Pan2.ar(InFeedback.ar(9),SinOsc.ar(3/4),env));

	edge2a = Out.ar(25,Pan2.ar(InFeedback.ar(10),SinOsc.ar(3/4),env));
	edge2b = Out.ar(27,Pan2.ar(InFeedback.ar(11),SinOsc.ar(3/4),env));
	edge2c = Out.ar(29,Pan2.ar(InFeedback.ar(12),SinOsc.ar(3/4),env));

	edge3a = Out.ar(31,Pan2.ar(InFeedback.ar(13),SinOsc.ar(3/4),env));
	edge3b = Out.ar(33,Pan2.ar(InFeedback.ar(14),SinOsc.ar(3/4),env));
	edge3c = Out.ar(35,Pan2.ar(InFeedback.ar(15),SinOsc.ar(3/4),env));

	edge4a = Out.ar(37,Pan2.ar(InFeedback.ar(16),SinOsc.ar(3/4),env));
	edge4b = Out.ar(39,Pan2.ar(InFeedback.ar(17),SinOsc.ar(3/4),env));
	edge4c = Out.ar(41,Pan2.ar(InFeedback.ar(18),SinOsc.ar(3/4),env));

////////////////////////////////////////////////////////////////////////////

	v1a = Out.ar(0,LeakDC.ar(InFeedback.ar(19))*env);
	v1b = Out.ar(0,LeakDC.ar(InFeedback.ar(20))*env);
	v1c = Out.ar(0,LeakDC.ar(InFeedback.ar(21))*env);
	v1d = Out.ar(0,LeakDC.ar(InFeedback.ar(22))*env);
	v1e = Out.ar(0,LeakDC.ar(InFeedback.ar(23))*env);
	v1f = Out.ar(0,LeakDC.ar(InFeedback.ar(24))*env);

	v2a = Out.ar(1,LeakDC.ar(InFeedback.ar(25))*env);
	v2b = Out.ar(1,LeakDC.ar(InFeedback.ar(26))*env);
	v2c = Out.ar(1,LeakDC.ar(InFeedback.ar(27))*env);
	v2d = Out.ar(1,LeakDC.ar(InFeedback.ar(28))*env);
	v2e = Out.ar(1,LeakDC.ar(InFeedback.ar(29))*env);
	v2f = Out.ar(1,LeakDC.ar(InFeedback.ar(30))*env);

	v3a = Out.ar(2,LeakDC.ar(InFeedback.ar(31))*env);
	v3b = Out.ar(2,LeakDC.ar(InFeedback.ar(32))*env);
	v3c = Out.ar(2,LeakDC.ar(InFeedback.ar(33))*env);
	v3d = Out.ar(2,LeakDC.ar(InFeedback.ar(34))*env);
	v3e = Out.ar(2,LeakDC.ar(InFeedback.ar(35))*env);
	v3f = Out.ar(2,LeakDC.ar(InFeedback.ar(36))*env);

	v4a = Out.ar(3,LeakDC.ar(InFeedback.ar(37))*env);
	v4b = Out.ar(3,LeakDC.ar(InFeedback.ar(38))*env);
	v4c = Out.ar(3,LeakDC.ar(InFeedback.ar(39))*env);
	v4d = Out.ar(3,LeakDC.ar(InFeedback.ar(40))*env);
	v4e = Out.ar(3,LeakDC.ar(InFeedback.ar(41))*env);
	v4f = Out.ar(3,LeakDC.ar(InFeedback.ar(42))*env);


}).add;
)

Synth.new(\t);

