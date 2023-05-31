//////////////////////////////////synth server and audio settings
s.options.sampleRate = 44100;
s.options.numBuffers = 1024*8;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;
s.options.outputStreamsEnabled.postln
s.options.device_("USB Sound Device");
Server.killAll
({Out.ar(2,SoundIn.ar(0))}.play;
s.record(numChannels:4)
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.reboot

Buffer.freeAll
~b= Buffer.alloc(s,2048);
(
(
(
SynthDef.new(\oa, {
	arg  n=1, cutt=10000,decay=6;
	var detune1,detune2;
	var osc1,osc2;
	var freq1,freq2,freq3,freq4, env;
	var bank, angle1,angle2;
	var pitch,m=0,over=1;
	var cf=8, fund=(((4*2)-1)*((4*2)/2));
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!

	bank=24;
	angle1=0;
	pitch=2.pow(n/(2*6));


	freq1 = fund*4;
	freq1=freq1*(1/1);

env=EnvGen.ar(Env.perc(0.02,decay,1),doneAction:2);
	~amps = [1] ++ ({[0,exprand(0.01,1)].choose}!8);


~tf = Signal.sineFill(1025, ~amps,

	[-0.72231270791305,-1.4446254158261,
		2.2578096926769,1.5354969847638,
		0.81318427685075,-1.7675659218259,
		-2.4898786297389,1.212556478764]
);

~tf.plot;
~tfBuf=~b.loadCollection(~tf.asWavetableNoWrap);


	bank.do{



		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);



		osc1=Pan2.ar(LeakDC.ar(Shaper.ar(~tfBuf,SinOsc.ar((freq1)*pitch,mul:pitch.reciprocal*LFNoise1.kr(pitch.reciprocal),phase:detune1.theta))),SinOsc.ar(pitch,phase:detune1.real.degrad,mul:pitch.reciprocal));
		osc2=Pan2.ar(LeakDC.ar(Shaper.ar(~tfBuf,SinOsc.ar((freq1)*pitch,mul:pitch.reciprocal*LFNoise1.kr(pitch.reciprocal),phase:detune1.theta))),SinOsc.ar(pitch,phase:detune1.imag.degrad,mul:pitch.reciprocal));

		wrappedOut.value(out, LeakDC.ar(LPF.ar((osc1 * osc2 )* env, cutt)));

		//m = m+1;
		//over = over + (m+1)/1;

	};
}).add;
);
);

MIDIClient.init;
MIDIIn.connectAll;

/////

// MIDIdef.cc(\dataentry,{|val,chan,src|[val,chan,src].postln; ~a.set(\cutt,val.linlin(1,127,110,880))},7);
// ~a=Synth.new(\oa);
// ~a.set(\cutt,220)

MIDIdef.noteOn(\synhtone, { |val, num, chan, src|
	[val, num, chan, src].postln;
	if(num < 49) {
		num = num - 1
	};
	Synth(\oa, [n: num - 48, out: (0..1).rotate(2.rand)]);
}, noteNum: (36..96))
)


(
(
Pdef(\1, Pbind(\instrument, \oa,
	\dur,Pwrand([1/2,3/4,2/3],[100,10,10].normalizeSum,inf),
	\n,Prand([3,8,11,15,11,8,3,8,11,15,11,8,3,10,8,22,20,15,11,10,8,10,8,22,20,15,11,10,8,15,10,11,20,\rest,\rest,\rest,20,\rest,15,\rest,\rest,\rest,20,\rest],inf),
	//\cutt,Pbrown(220,880,10,inf),
	\decay,Pbrown(4,8,1,inf);
)).play;
);
(
Pdef(\2, Pbind(\instrument, \oa,
	\dur,Pwrand([1/2,3/4,2/3],[100,10,10].normalizeSum,inf),
	\n,Prand([20,\rest,\rest,\rest,20,\rest,15,\rest,\rest,\rest,20,\rest,15,3,8,11,15,11,8,3,8,11,15,11,8,3,10,8,22,20,15,11,10,8,10,8,22,20,15,11,10,8,15,10,11],inf),
//	\cutt,Pbrown(220,880,10,inf),
	\decay,Pbrown(4,8,1,inf);
)).play;
)
)


(
(
Pdef(\1, Pbind(\instrument, \oa,
	\dur,Pwrand([1/2,3/4,2/3],[100,10,10].normalizeSum,inf),
	\n,Pxrand([8,\rest,11,\rest,15],inf),
	//\cutt,Pbrown(220,880,10,inf),
	\decay,Pbrown(4,8,1,inf);
)).play;
);
(
Pdef(\2, Pbind(\instrument, \oa,
	\dur,Pwrand([1/2,3/4,2/3],[100,10,10].normalizeSum,inf),
	\n,Pxrand([18,20,22,23,25],inf),
//	\cutt,Pbrown(220,880,10,inf),
	\decay,Pbrown(4,8,1,inf);
)).play;
)
)