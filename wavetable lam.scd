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
SynthDef.new(\oa, {
	arg  n=1, cutt=10000,decay=4;
	var amps,tf,tfBuf;
	var detune1,detune2;
	var osc1,osc2;
	var freq1,freq2,freq3,freq4, env;
	var bank, angle1,angle2;
	var pitch,m=0,over=1,ch;
	var cf=8, fund=(((4*2)-1)*((4*2)/2));
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!

	bank=64;
	angle1=0;
	pitch=2.pow(n/(2*6));


	freq1 = fund*2;
	freq1=freq1*(1/1);
	ch=TExpRand.ar(0.1,2,Dust.kr(10));

env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),doneAction:2);
//	env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);
amps = [1] ++ ({[exprand(0.01,1),exprand(0.01,1)].choose}!12);
//	tf=Env([-1,1],[1],[0]).asSignal(1025);

		tf = Signal.sineFill(1025, amps,

	[-0.72231270791305,-1.4446254158261,
		2.2578096926769,1.5354969847638,
		0.81318427685075,-1.7675659218259,
		-2.4898786297389,1.212556478764,
			0.49024377085098,-0.23206893706207,
			-2.8128191357387,2.7480534635278,
		]
);
//		tf=tf.normalize;
tf.plot;
tfBuf=~b.loadCollection(tf.asWavetableNoWrap);


	bank.do{



		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);


	osc1=Pan2.ar(LeakDC.ar(Shaper.ar(tfBuf,SinOsc.ar((freq1)*pitch,mul:LFNoise1.kr(ch),phase:detune1.theta))),detune1.real);
	osc2=	Pan2.ar(LeakDC.ar(Shaper.ar(tfBuf,SinOsc.ar((freq1)*pitch,mul:LFNoise1.kr(ch),phase:detune1.theta))),detune1.imag);

	wrappedOut.value(out, LeakDC.ar((osc1 )* env));
		wrappedOut.value(out, LeakDC.ar((osc2 )* env));
	};
}).add;
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
Pdef(\1, Pbind(\instrument, \oa,
	\dur,1/2,
	\n,Pseq([8,20,23,11,25,15,23,22,8,20,23,11,22,15,18,20],inf),
	\decay,Pbrown(2,4,1,inf);
)).play;
);

(
Pdef(\2, Pbind(\instrument, \ob,
	\dur,1/2,
	\n,Pseq([-5],inf),
	\decay,1/2
)).play;
);
(
Pdef(\3, Pbind(\instrument, \oc,
	\dur,1/4,
	\n,Pseq([24],inf),
	\decay,1/2
)).play;
)

(
SynthDef.new(\ob, {
	arg  n=1, cutt=880,decay=6;
	var amps,tf,tfBuf;
	var detune1,detune2;
	var osc1,osc2;
	var freq1,freq2,freq3,freq4, env;
	var bank, angle1,angle2;
	var pitch,m=0,over=1,ch;
	var cf=8, fund=(((4*2)-1)*((4*2)/2));
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!

	bank=32;
	angle1=0;
	pitch=2.pow(n/(2*6));


	freq1 = fund*2;
	freq1=freq1*(1/1);
	ch=TExpRand.ar(0.1,2,Dust.kr(10));

env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),doneAction:2);
	//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);
amps = [1] ++ ({[exprand(0.01,1),exprand(0.01,1)].choose}!12);
//	tf=Env([-1,1],[1],[0]).asSignal(1025);

		tf = Signal.sineFill(1025, amps,

	[-0.72231270791305,-1.4446254158261,
		2.2578096926769,1.5354969847638,
		0.81318427685075,-1.7675659218259,
		-2.4898786297389,1.212556478764,
			0.49024377085098,-0.23206893706207,
			-2.8128191357387,2.7480534635278,
		]
);
//		tf=tf.normalize;
tf.plot;
tfBuf=~b.loadCollection(tf.asWavetableNoWrap);


	bank.do{



		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);


	osc1=Pan2.ar(LeakDC.ar(Shaper.ar(tfBuf,SinOsc.ar((freq1)*pitch,mul:LFNoise1.kr(1),phase:detune1.theta))),detune1.real);
	osc2=	Pan2.ar(LeakDC.ar(Shaper.ar(tfBuf,SinOsc.ar((freq1)*pitch,mul:LFNoise1.kr(1),phase:detune1.theta))),detune1.imag);

		wrappedOut.value(out,LPF.ar( LeakDC.ar((osc1 )* env),cutt));
		wrappedOut.value(out,LPF.ar( LeakDC.ar((osc2 )* env),cutt));
	};
}).add;
)

(
SynthDef.new(\oc, {
	arg  n=1, cutt=10000,decay=6;
	var amps,tf,tfBuf;
	var detune1,detune2;
	var osc1,osc2;
	var freq1,freq2,freq3,freq4, env;
	var bank, angle1,angle2;
	var pitch,m=0,over=1,ch;
	var cf=8, fund=(((4*2)-1)*((4*2)/2));
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!

	bank=32;
	angle1=0;
	pitch=2.pow(n/(2*6));


	freq1 = fund*2;
	freq1=freq1*(1/1);
	ch=TExpRand.ar(0.1,2,Dust.kr(10));

env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),doneAction:2);
	//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);
amps = [1] ++ ({[exprand(0.01,1),exprand(0.01,1)].choose}!12);
//	tf=Env([-1,1],[1],[0]).asSignal(1025);

		tf = Signal.sineFill(1025, amps,

	[-0.72231270791305,-1.4446254158261,
		2.2578096926769,1.5354969847638,
		0.81318427685075,-1.7675659218259,
		-2.4898786297389,1.212556478764,
			0.49024377085098,-0.23206893706207,
			-2.8128191357387,2.7480534635278,
		]
);
//		tf=tf.normalize;
tf.plot;
tfBuf=~b.loadCollection(tf.asWavetableNoWrap);


	bank.do{



		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);


	osc1=Pan2.ar(LeakDC.ar(Shaper.ar(tfBuf,SinOsc.ar((freq1)*pitch,mul:LFNoise1.kr(1),phase:detune1.theta))),detune1.real);
	osc2=	Pan2.ar(LeakDC.ar(Shaper.ar(tfBuf,SinOsc.ar((freq1)*pitch,mul:LFNoise1.kr(1),phase:detune1.theta))),detune1.imag);

		wrappedOut.value(out,LPF.ar( LeakDC.ar((osc1 )* env),cutt));
		wrappedOut.value(out,LPF.ar( LeakDC.ar((osc2 )* env),cutt));
	};
}).add;
)