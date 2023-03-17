s.options.sampleRate = 44100;
s.options.numBuffers = 1024*4;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;å
s.options.outputStreamsEnabled.postln
s.options.device_("USB Sound Device");
s.record(numChannels:10) ;

({Out.ar(2,SoundIn.ar(0))}.play;
s.record(numChannels:10)

s.options.numWireBufs = 1024*4;
ServerOptions.devices
s.options.numOutputBusChannels=102;/////////////40tet1 +40tet2 +
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*16;
s.waitForBoot
s.maxNodes
s.reboot;

~p1 = Buffer.read(s,"/Users/petrostatsiopoulos/Dokuments/PROJECT  FILES/Suco/lam/audio files/2/l lmd.wav")
~p2 = Buffer.read(s,"/Users/petrostatsiopoulos/Dokuments/PROJECT  FILES/Suco/lam/audio files/2/r lmd.wav")


(
SynthDef.new(\t, {

	var env,gain,duration,face1,face2,face3,face4,face5,face6,face7,face8,face9,
	    face10,face11,face12,face13,face14,face15,face16,face17,face18,face19,face20;
	var edge1a,edge1b,edge1c,edge2a,edge2b,edge2c;
	var edge3a,edge3b,edge3c,edge4a,edge4b,edge4c;
	var edge5a,edge5b,edge5c,edge6a,edge6b,edge6c;
	var edge7a,edge7b,edge7c,edge8a,edge8b,edge8c;
	var edge10a,edge10b,edge10c,edge9a,edge9b,edge9c;
	var v3a,v3b,v3c,v3d,v3e,v3f;
	var v4a,v4b,v4c,v4d,v4e,v4f;
	var v2a,v2b,v2c,v2d,v2e,v2f;
	var v1a,v1b,v1c,v1d,v1e,v1f;
	var v5a,v5b,v5c,v5d,v5e,v5f;
	var v6a,v6b,v6c,v6d,v6e,v6f;
	var v7a,v7b,v7c,v7d,v7e,v7f;
	var v8a,v8b,v8c,v8d,v8e,v8f;
	var v9a,v9b,v9c,v9d,v9e,v9f;
	var v10a,v10b,v10c,v10d,v10e,v10f;
	var azimuth1, azimuth2;

	duration=340;
	gain=1;

	env = EnvGen.ar(Env.new([0,1,1,0],[1,340,1],gain), doneAction: 2);
////////////////////////////////////////////////////////////////////////////	////////
	azimuth1 = Out.ar(10,LeakDC.ar(PlayBuf.ar(1,0,BufRateScale.kr(0),inf),mul:env));

	azimuth2 = Out.ar(11,LeakDC.ar(PlayBuf.ar(1,1,BufRateScale.kr(0),inf),mul:env));
	/////////////////////////////////////////////////////////

	face1 = Out.ar(12,PanAz.ar(3,LeakDC.ar(InFeedback.ar(10)),LFNoise1.ar(3/4),env,width:2));

	face2 = Out.ar(15,PanAz.ar(3,LeakDC.ar(InFeedback.ar(11)),LFNoise1.ar(3/4),env,width:2));

	face3 = Out.ar(18,PanAz.ar(3,LeakDC.ar(InFeedback.ar(10)),LFNoise1.ar(3/4),env,width:2));

	face4 = Out.ar(21,PanAz.ar(3,LeakDC.ar(InFeedback.ar(11)),LFNoise1.ar(3/4),env,width:2));

	face5 = Out.ar(24,PanAz.ar(3,LeakDC.ar(InFeedback.ar(10)),LFNoise1.ar(3/4),env,width:2));

	face6 = Out.ar(27,PanAz.ar(3,LeakDC.ar(InFeedback.ar(11)),LFNoise1.ar(3/4),env,width:2));

	face7 = Out.ar(30,PanAz.ar(3,LeakDC.ar(InFeedback.ar(10)),LFNoise1.ar(3/4),env,width:2));

	face8 = Out.ar(33,PanAz.ar(3,LeakDC.ar(InFeedback.ar(11)),LFNoise1.ar(3/4),env,width:2));

	face9 = Out.ar(36,PanAz.ar(3,LeakDC.ar(InFeedback.ar(10)),LFNoise1.ar(3/4),env,width:2));

	face10 = Out.ar(39,PanAz.ar(3,LeakDC.ar(InFeedback.ar(11)),LFNoise1.ar(3/4),env,width:2));

///////////////////////////////////////////////////////////////////////////////

	edge1a = Out.ar(42,Pan2.ar(InFeedback.ar(24),LFNoise1.ar(3/4),env));
	edge1b = Out.ar(44,Pan2.ar(InFeedback.ar(25),LFNoise1.ar(3/4),env));
	edge1c = Out.ar(46,Pan2.ar(InFeedback.ar(26),LFNoise1.ar(3/4),env));

	edge2a = Out.ar(48,Pan2.ar(InFeedback.ar(27),LFNoise1.ar(3/4),env));
	edge2b = Out.ar(50,Pan2.ar(InFeedback.ar(28),LFNoise1.ar(3/4),env));
	edge2c = Out.ar(52,Pan2.ar(InFeedback.ar(29),LFNoise1.ar(3/4),env));

	edge3a = Out.ar(54,Pan2.ar(InFeedback.ar(30),LFNoise1.ar(3/4),env));
	edge3b = Out.ar(56,Pan2.ar(InFeedback.ar(31),LFNoise1.ar(3/4),env));
	edge3c = Out.ar(58,Pan2.ar(InFeedback.ar(32),LFNoise1.ar(3/4),env));

	edge4a = Out.ar(60,Pan2.ar(InFeedback.ar(33),LFNoise1.ar(3/4),env));
	edge4b = Out.ar(62,Pan2.ar(InFeedback.ar(34),LFNoise1.ar(3/4),env));
	edge4c = Out.ar(64,Pan2.ar(InFeedback.ar(35),LFNoise1.ar(3/4),env));

	edge5a = Out.ar(66,Pan2.ar(InFeedback.ar(36),LFNoise1.ar(3/4),env));
	edge5b = Out.ar(68,Pan2.ar(InFeedback.ar(37),LFNoise1.ar(3/4),env));
	edge5c = Out.ar(70,Pan2.ar(InFeedback.ar(38),LFNoise1.ar(3/4),env));

	edge6a = Out.ar(72,Pan2.ar(InFeedback.ar(39),LFNoise1.ar(3/4),env));
	edge6b = Out.ar(74,Pan2.ar(InFeedback.ar(40),LFNoise1.ar(3/4),env));
	edge6c = Out.ar(76,Pan2.ar(InFeedback.ar(41),LFNoise1.ar(3/4),env));

	edge7a = Out.ar(78,Pan2.ar(InFeedback.ar(42),LFNoise1.ar(3/4),env));
	edge7b = Out.ar(80,Pan2.ar(InFeedback.ar(43),LFNoise1.ar(3/4),env));
	edge7c = Out.ar(82,Pan2.ar(InFeedback.ar(44),LFNoise1.ar(3/4),env));

	edge8a = Out.ar(84,Pan2.ar(InFeedback.ar(45),LFNoise1.ar(3/4),env));
	edge8b = Out.ar(86,Pan2.ar(InFeedback.ar(46),LFNoise1.ar(3/4),env));
	edge8c = Out.ar(88,Pan2.ar(InFeedback.ar(47),LFNoise1.ar(3/4),env));

	edge9a = Out.ar(90,Pan2.ar(InFeedback.ar(48),LFNoise1.ar(3/4),env));
	edge9b = Out.ar(92,Pan2.ar(InFeedback.ar(49),LFNoise1.ar(3/4),env));
	edge9c = Out.ar(94,Pan2.ar(InFeedback.ar(50),LFNoise1.ar(3/4),env));

	edge10a = Out.ar(96,Pan2.ar(InFeedback.ar(51),LFNoise1.ar(3/4),env));
	edge10b = Out.ar(98,Pan2.ar(InFeedback.ar(52),LFNoise1.ar(3/4),env));
	edge10c = Out.ar(100,Pan2.ar(InFeedback.ar(53),LFNoise1.ar(3/4),env));



////////////////////////////////////////////////////////////////////////////

	v1a = Out.ar(0,LeakDC.ar(InFeedback.ar(42))*env);
	v1b = Out.ar(0,LeakDC.ar(InFeedback.ar(43))*env);
	v1c = Out.ar(0,LeakDC.ar(InFeedback.ar(44))*env);
	v1d = Out.ar(0,LeakDC.ar(InFeedback.ar(45))*env);
	v1e = Out.ar(0,LeakDC.ar(InFeedback.ar(46))*env);
	v1f = Out.ar(0,LeakDC.ar(InFeedback.ar(47))*env);

	v2a = Out.ar(1,LeakDC.ar(InFeedback.ar(48))*env);
	v2b = Out.ar(1,LeakDC.ar(InFeedback.ar(49))*env);
	v2c = Out.ar(1,LeakDC.ar(InFeedback.ar(50))*env);
	v2d = Out.ar(1,LeakDC.ar(InFeedback.ar(51))*env);
	v2e = Out.ar(1,LeakDC.ar(InFeedback.ar(52))*env);
	v2f = Out.ar(1,LeakDC.ar(InFeedback.ar(53))*env);

	v3a = Out.ar(2,LeakDC.ar(InFeedback.ar(54))*env);
	v3b = Out.ar(2,LeakDC.ar(InFeedback.ar(55))*env);
	v3c = Out.ar(2,LeakDC.ar(InFeedback.ar(56))*env);
	v3d = Out.ar(2,LeakDC.ar(InFeedback.ar(57))*env);
	v3e = Out.ar(2,LeakDC.ar(InFeedback.ar(58))*env);
	v3f = Out.ar(2,LeakDC.ar(InFeedback.ar(59))*env);

	v4a = Out.ar(3,LeakDC.ar(InFeedback.ar(60))*env);
	v4b = Out.ar(3,LeakDC.ar(InFeedback.ar(61))*env);
	v4c = Out.ar(3,LeakDC.ar(InFeedback.ar(62))*env);
	v4d = Out.ar(3,LeakDC.ar(InFeedback.ar(63))*env);
	v4e = Out.ar(3,LeakDC.ar(InFeedback.ar(64))*env);
	v4f = Out.ar(3,LeakDC.ar(InFeedback.ar(65))*env);

	v5a = Out.ar(4,LeakDC.ar(InFeedback.ar(66))*env);
	v5b = Out.ar(4,LeakDC.ar(InFeedback.ar(67))*env);
	v5c = Out.ar(4,LeakDC.ar(InFeedback.ar(68))*env);
	v5d = Out.ar(4,LeakDC.ar(InFeedback.ar(69))*env);
	v5e = Out.ar(4,LeakDC.ar(InFeedback.ar(70))*env);
	v5f = Out.ar(4,LeakDC.ar(InFeedback.ar(71))*env);

	v6a = Out.ar(5,LeakDC.ar(InFeedback.ar(72))*env);
	v6b = Out.ar(5,LeakDC.ar(InFeedback.ar(73))*env);
	v6c = Out.ar(5,LeakDC.ar(InFeedback.ar(74))*env);
	v6d = Out.ar(5,LeakDC.ar(InFeedback.ar(75))*env);
	v6e = Out.ar(5,LeakDC.ar(InFeedback.ar(76))*env);
	v6f = Out.ar(5,LeakDC.ar(InFeedback.ar(77))*env);

	v7a = Out.ar(6,LeakDC.ar(InFeedback.ar(78))*env);
	v7b = Out.ar(6,LeakDC.ar(InFeedback.ar(79))*env);
	v7c = Out.ar(6,LeakDC.ar(InFeedback.ar(80))*env);
	v7d = Out.ar(6,LeakDC.ar(InFeedback.ar(81))*env);
	v7e = Out.ar(6,LeakDC.ar(InFeedback.ar(82))*env);
	v7f = Out.ar(6,LeakDC.ar(InFeedback.ar(83))*env);


	v8a = Out.ar(7,LeakDC.ar(InFeedback.ar(84))*env);
	v8b = Out.ar(7,LeakDC.ar(InFeedback.ar(85))*env);
	v8c = Out.ar(7,LeakDC.ar(InFeedback.ar(86))*env);
	v8d = Out.ar(7,LeakDC.ar(InFeedback.ar(87))*env);
	v8e = Out.ar(7,LeakDC.ar(InFeedback.ar(88))*env);
	v8f = Out.ar(7,LeakDC.ar(InFeedback.ar(89))*env);

	v9a = Out.ar(8,LeakDC.ar(InFeedback.ar(90))*env);
	v9b = Out.ar(8,LeakDC.ar(InFeedback.ar(91))*env);
	v9c = Out.ar(8,LeakDC.ar(InFeedback.ar(92))*env);
	v9d = Out.ar(8,LeakDC.ar(InFeedback.ar(93))*env);
	v9e = Out.ar(8,LeakDC.ar(InFeedback.ar(94))*env);
	v9f = Out.ar(8,LeakDC.ar(InFeedback.ar(95))*env);

	v10a = Out.ar(9,LeakDC.ar(InFeedback.ar(96))*env);
	v10b = Out.ar(9,LeakDC.ar(InFeedback.ar(97))*env);
	v10c = Out.ar(9,LeakDC.ar(InFeedback.ar(98))*env);
	v10d = Out.ar(9,LeakDC.ar(InFeedback.ar(99))*env);
	v10e = Out.ar(9,LeakDC.ar(InFeedback.ar(100))*env);
	v10f = Out.ar(9,LeakDC.ar(InFeedback.ar(101))*env);

}).add;
)

Synth.new(\t);

//blrfud