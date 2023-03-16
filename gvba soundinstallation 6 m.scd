s.options.sampleRate = 44100;
s.options.numBuffers = 1024*4;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;å
s.options.outputStreamsEnabled.postln
s.options.device_("USB Sound Device");
s.record(numChannels:6) ;

({Out.ar(2,SoundIn.ar(0))}.play;
s.record(numChannels:6)

s.options.numWireBufs = 1024*4;

s.options.numOutputBusChannels=81;/////////////40tet1 +40tet2 +
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
s.reboot;

~p1 = Buffer.read(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/l/lamdoma keysl.wav")
~p2 = Buffer.read(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/l/lamdoma keysr.wav")


(
SynthDef.new(\t, {

	var env,gain,duration,face1,face2,face3,face4,face5,face6;
	var edge1a,edge1b,edge1c,edge2a,edge2b,edge2c;
	var edge3a,edge3b,edge3c,edge4a,edge4b,edge4c;
	var edge5a,edge5b,edge5c,edge6a,edge6b,edge6c;
	var edge1d,edge2d,edge3d,edge4d,edge5d,edge6d;
	var v3a,v3b,v3c,v3d,v3e,v3f,v3g,v3k;
	var v4a,v4b,v4c,v4d,v4e,v4f,v4g,v4k;
	var v2a,v2b,v2c,v2d,v2e,v2f,v2g,v2k;
	var v1a,v1b,v1c,v1d,v1e,v1f,v1g,v1k;
	var v5a,v5b,v5c,v5d,v5e,v5f,v5g,v5k;
	var v6a,v6b,v6c,v6d,v6e,v6f,v6g,v6k;
	var azimuth1, azimuth2;

	duration=340;
	gain=1;

	env = EnvGen.ar(Env.new([0,1,1,0],[1,340,1],gain), doneAction: 2);
////////////////////////////////////////////////////////////////////////////	////////
	azimuth1 = Out.ar(6,Pan2.ar(LeakDC.ar(PlayBuf.ar(1,0,BufRateScale.kr(0),inf),mul:env),pos:MouseX.kr(-1,1)));

	azimuth2 = Out.ar(8,Pan2.ar(LeakDC.ar(PlayBuf.ar(1,1,BufRateScale.kr(0),inf),mul:env),pos:MouseY.kr(-1,1)));
	/////////////////////////////////////////////////////////

	face1 = Out.ar(10,PanAz.ar(4,LeakDC.ar(InFeedback.ar(6)),SinOsc.ar(3/4),env,width:2));

	face2 = Out.ar(14,PanAz.ar(4,LeakDC.ar(InFeedback.ar(8)),SinOsc.ar(3/4),env,width:2));

	face3 = Out.ar(18,PanAz.ar(4,LeakDC.ar(InFeedback.ar(7)),SinOsc.ar(3/4),env,width:2));

	face4 = Out.ar(22,PanAz.ar(4,LeakDC.ar(InFeedback.ar(9)),SinOsc.ar(3/4),env,width:2));

	face5 = Out.ar(26,PanAz.ar(4,LeakDC.ar(InFeedback.ar([6,8],2)),SinOsc.ar(3/4),env,width:2));

	face6 = Out.ar(30,PanAz.ar(4,LeakDC.ar(InFeedback.ar([7,9],2)),SinOsc.ar(3/4),env,width:2));

///////////////////////////////////////////////////////////////////////////////

	edge1a = Out.ar(34,Pan2.ar(InFeedback.ar(10),SinOsc.ar(3/4),env));
	edge1b = Out.ar(36,Pan2.ar(InFeedback.ar(11),SinOsc.ar(3/4),env));
	edge1c = Out.ar(38,Pan2.ar(InFeedback.ar(12),SinOsc.ar(3/4),env));
	edge1d = Out.ar(40,Pan2.ar(InFeedback.ar(13),SinOsc.ar(3/4),env));

	edge2a = Out.ar(42,Pan2.ar(InFeedback.ar(14),SinOsc.ar(3/4),env));
	edge2b = Out.ar(44,Pan2.ar(InFeedback.ar(15),SinOsc.ar(3/4),env));
	edge2c = Out.ar(46,Pan2.ar(InFeedback.ar(16),SinOsc.ar(3/4),env));
	edge2d = Out.ar(48,Pan2.ar(InFeedback.ar(17),SinOsc.ar(3/4),env));

	edge3a = Out.ar(50,Pan2.ar(InFeedback.ar(18),SinOsc.ar(3/4),env));
	edge3b = Out.ar(52,Pan2.ar(InFeedback.ar(19),SinOsc.ar(3/4),env));
	edge3c = Out.ar(54,Pan2.ar(InFeedback.ar(20),SinOsc.ar(3/4),env));
	edge3d = Out.ar(56,Pan2.ar(InFeedback.ar(21),SinOsc.ar(3/4),env));

	edge4a = Out.ar(58,Pan2.ar(InFeedback.ar(22),SinOsc.ar(3/4),env));
	edge4b = Out.ar(60,Pan2.ar(InFeedback.ar(23),SinOsc.ar(3/4),env));
	edge4c = Out.ar(62,Pan2.ar(InFeedback.ar(24),SinOsc.ar(3/4),env));
	edge4d = Out.ar(64,Pan2.ar(InFeedback.ar(25),SinOsc.ar(3/4),env));

	edge5a = Out.ar(66,Pan2.ar(InFeedback.ar(26),SinOsc.ar(3/4),env));
	edge5b = Out.ar(68,Pan2.ar(InFeedback.ar(27),SinOsc.ar(3/4),env));
	edge5c = Out.ar(70,Pan2.ar(InFeedback.ar(28),SinOsc.ar(3/4),env));
	edge5d = Out.ar(72,Pan2.ar(InFeedback.ar(29),SinOsc.ar(3/4),env));

	edge6a = Out.ar(74,Pan2.ar(InFeedback.ar(30),SinOsc.ar(3/4),env));
	edge6b = Out.ar(76,Pan2.ar(InFeedback.ar(31),SinOsc.ar(3/4),env));
	edge6c = Out.ar(78,Pan2.ar(InFeedback.ar(32),SinOsc.ar(3/4),env));
	edge6d = Out.ar(80,Pan2.ar(InFeedback.ar(33),SinOsc.ar(3/4),env));

////////////////////////////////////////////////////////////////////////////

	v1a = Out.ar(0,LeakDC.ar(InFeedback.ar(34))*env);
	v1b = Out.ar(0,LeakDC.ar(InFeedback.ar(35))*env);
	v1c = Out.ar(0,LeakDC.ar(InFeedback.ar(36))*env);
	v1d = Out.ar(0,LeakDC.ar(InFeedback.ar(37))*env);
	v1e = Out.ar(0,LeakDC.ar(InFeedback.ar(38))*env);
	v1f = Out.ar(0,LeakDC.ar(InFeedback.ar(39))*env);
	v1g = Out.ar(0,LeakDC.ar(InFeedback.ar(40))*env);
	v1k = Out.ar(0,LeakDC.ar(InFeedback.ar(41))*env);

	v2a = Out.ar(1,LeakDC.ar(InFeedback.ar(45))*env);
	v2b = Out.ar(1,LeakDC.ar(InFeedback.ar(43))*env);
	v2c = Out.ar(1,LeakDC.ar(InFeedback.ar(44))*env);
	v2d = Out.ar(1,LeakDC.ar(InFeedback.ar(45))*env);
	v2e = Out.ar(1,LeakDC.ar(InFeedback.ar(46))*env);
	v2f = Out.ar(1,LeakDC.ar(InFeedback.ar(47))*env);
	v2g = Out.ar(1,LeakDC.ar(InFeedback.ar(48))*env);
	v2k = Out.ar(1,LeakDC.ar(InFeedback.ar(49))*env);

	v3a = Out.ar(2,LeakDC.ar(InFeedback.ar(50))*env);
	v3b = Out.ar(2,LeakDC.ar(InFeedback.ar(51))*env);
	v3c = Out.ar(2,LeakDC.ar(InFeedback.ar(52))*env);
	v3d = Out.ar(2,LeakDC.ar(InFeedback.ar(53))*env);
	v3e = Out.ar(2,LeakDC.ar(InFeedback.ar(54))*env);
	v3f = Out.ar(2,LeakDC.ar(InFeedback.ar(55))*env);
	v3g = Out.ar(2,LeakDC.ar(InFeedback.ar(56))*env);
	v3k = Out.ar(2,LeakDC.ar(InFeedback.ar(57))*env);

	v4a = Out.ar(3,LeakDC.ar(InFeedback.ar(58))*env);
	v4b = Out.ar(3,LeakDC.ar(InFeedback.ar(59))*env);
	v4c = Out.ar(3,LeakDC.ar(InFeedback.ar(60))*env);
	v4d = Out.ar(3,LeakDC.ar(InFeedback.ar(61))*env);
	v4e = Out.ar(3,LeakDC.ar(InFeedback.ar(62))*env);
	v4f = Out.ar(3,LeakDC.ar(InFeedback.ar(63))*env);
	v4g = Out.ar(3,LeakDC.ar(InFeedback.ar(64))*env);
	v4k = Out.ar(3,LeakDC.ar(InFeedback.ar(65))*env);

	v5a = Out.ar(4,LeakDC.ar(InFeedback.ar(66))*env);
	v5b = Out.ar(4,LeakDC.ar(InFeedback.ar(67))*env);
	v5c = Out.ar(4,LeakDC.ar(InFeedback.ar(68))*env);
	v5d = Out.ar(4,LeakDC.ar(InFeedback.ar(69))*env);
	v5e = Out.ar(4,LeakDC.ar(InFeedback.ar(70))*env);
	v5f = Out.ar(4,LeakDC.ar(InFeedback.ar(71))*env);
	v5g = Out.ar(4,LeakDC.ar(InFeedback.ar(72))*env);
	v5k = Out.ar(4,LeakDC.ar(InFeedback.ar(73))*env);

	v6a = Out.ar(5,LeakDC.ar(InFeedback.ar(74))*env);
	v6b = Out.ar(5,LeakDC.ar(InFeedback.ar(75))*env);
	v6c = Out.ar(5,LeakDC.ar(InFeedback.ar(76))*env);
	v6d = Out.ar(5,LeakDC.ar(InFeedback.ar(77))*env);
	v6e = Out.ar(5,LeakDC.ar(InFeedback.ar(78))*env);
	v6f = Out.ar(5,LeakDC.ar(InFeedback.ar(79))*env);
	v6g = Out.ar(5,LeakDC.ar(InFeedback.ar(80))*env);
	v6k = Out.ar(5,LeakDC.ar(InFeedback.ar(81))*env);




}).add;
)

Synth.new(\t);

//blrfud