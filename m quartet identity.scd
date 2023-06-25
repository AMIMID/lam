
s.record(numChannels:4)
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/240);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.reboot

Buffer.freeAll

(
(~tf=Array.fill(96,{
	var amps;
	amps = [1] ++ ({[exprand(0.1,1),exprand(0.1,1)].choose}!2);
	Signal.sineFill(1025, [1,1],[0.degrad,90.degrad]).asWavetableNoWrap;
});
);
~tBuf = Buffer.allocConsecutive(96,s,2048);

(
~tBuf.do({
	arg buf, i;
	buf.loadCollection(~tf[i]);
});
);
)
~tf.do({arg n,i; n.plot(~tBuf[i].bufnum.asString)});
(((4*2)-1)*((4*2)/2))
(
(
SynthDef.new(\oa, {
	arg  n=1, cutt=20000,decay=4;
	var amps,tf,tfBuf=0;
	var detune1, osc1;
	var freq1, env;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=10;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*6;
	freq1=freq1*(1/1);

	bank.do{

env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Dust.kr(0.1))),
			mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),
			phase:detune1.theta))),
		detune1.real.round(0.001),detune1.imag.round(0.001));


		tfBuf=tfBuf+1;

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env*2),cutt));
		trig = TDelay.ar(trig, 0.001);
	};
}).add;
);
(
SynthDef.new(\ob, {
	arg  n=1, cutt=20000,decay=4;
	var amps,tf,tfBuf=10;
	var detune1, osc1;
	var freq1, env;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=10;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*8;
	freq1=freq1*(1/1);

	bank.do{

env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Dust.kr(0.1))),
			mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),
			phase:detune1.theta))),
		detune1.real.round(0.001),detune1.imag.round(0.001));


		tfBuf=tfBuf+1;

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env*(3/2)),cutt));
		trig = TDelay.ar(trig, 0.001);
	};
}).add;
);
(
SynthDef.new(\oc, {
	arg  n=1, cutt=20000,decay=4;
	var amps,tf,tfBuf=20;
	var detune1, osc1;
	var freq1, env;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=10;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*9;
	freq1=freq1*(1/1);

	bank.do{

env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Dust.kr(0.1))),
			mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),
			phase:detune1.theta))),
		detune1.real.round(0.001),detune1.imag.round(0.001));


		tfBuf=tfBuf+1;

		wrappedOut.value(out, LPF.ar((osc1 )* env*(4/3)),cutt);
		trig = TDelay.ar(trig, 0.001);
	};
}).add;
);
(
SynthDef.new(\od, {
	arg  n=1, cutt=20000,decay=4;
	var amps,tf,tfBuf=30;
	var detune1, osc1;
	var freq1, env;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=10;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*12;
	freq1=freq1*(1/1);

	bank.do{

env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Dust.kr(0.1))),
			mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),
			phase:detune1.theta))),
		detune1.real.round(0.001),detune1.imag.round(0.001));

		tfBuf=tfBuf+1;

		wrappedOut.value(out, LPF.ar((osc1 )* env*1),cutt);
		trig = TDelay.ar(trig, 0.001);
	};
}).add;
);
(
SynthDef.new(\oe, {
	arg  n=1, cutt=20000,decay=4;
	var amps,tf,tfBuf=40;
	var detune1, osc1;
	var freq1, env;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=10;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*6;
	freq1=freq1*(1/1);

	bank.do{

//env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Dust.kr(0.1))),
			mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),
			phase:detune1.theta))),
		detune1.real.round(0.001),detune1.imag.round(0.001));


		tfBuf=tfBuf+1;

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env*(2)),cutt));
		trig = TDelay.ar(trig, 0.001);
	};
}).add;
);
(
SynthDef.new(\of, {
	arg  n=1, cutt=20000,decay=4;
	var amps,tf,tfBuf=50;
	var detune1, osc1;
	var freq1, env;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=10;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*8;
	freq1=freq1*(1/1);

	bank.do{

env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Dust.kr(0.1))),
			mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),
			phase:detune1.theta))),
		detune1.real.round(0.001),detune1.imag.round(0.001));


		tfBuf=tfBuf+1;

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env*(3/2)),cutt));
		trig = TDelay.ar(trig, 0.001);
	};
}).add;
);
(
SynthDef.new(\og, {
	arg  n=1, cutt=20000,decay=4;
	var amps,tf,tfBuf=60;
	var detune1, osc1;
	var freq1, env;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=10;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*9;
	freq1=freq1*(1/1);

	bank.do{

//env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Dust.kr(0.1))),
			mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),
			phase:detune1.theta))),
		detune1.real.round(0.001),detune1.imag.round(0.001));


		tfBuf=tfBuf+1;

		wrappedOut.value(out, LPF.ar((osc1 )* env*(4/3)),cutt);
		trig = TDelay.ar(trig, 0.001);
	};
}).add;
);
(
SynthDef.new(\oh, {
	arg  n=1, cutt=20000,decay=4;
	var amps,tf,tfBuf=70;
	var detune1, osc1;
	var freq1, env;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=10;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*12;
	freq1=freq1*(1/1);

	bank.do{

//env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*(pitch+TExpRand.ar(0.001,0.01,Dust.kr(0.1))),
			mul:LFNoise1.kr(TExpRand.ar(0.1,1,Dust.kr(0.1))),
			phase:detune1.theta))),
		detune1.real.round(0.001),detune1.imag.round(0.001));


		tfBuf=tfBuf+1;

		wrappedOut.value(out, LPF.ar((osc1 )* env*(1)),cutt);
		trig = TDelay.ar(trig, 0.001);
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
	Synth(\oa, [n: num - 48, out: (0..3).rotate(4.rand)]);
	//Synth(\ob, [n: num - 48, out: (0..3).rotate(4.rand)]);
	//Synth(\oc, [n: num - 48, out: (0..3).rotate(4.rand)]);
	//Synth(\od, [n: num - 48, out: (0..3).rotate(4.rand)]);
	//Synth(\oe, [n: num - 48, out: (0..3).rotate(4.rand)]);
	//Synth(\of, [n: num - 48, out: (0..3).rotate(4.rand)]);
	//Synth(\og, [n: num - 48, out: (0..3).rotate(4.rand)]);
	//Synth(\oh, [n: num - 48, out: (0..3).rotate(4.rand)]);
}, noteNum: (36..96))
)

s.record(numChannels:4);
(
(
Pdef(\1, Pbind(\instrument, \oa,
		\dur,Pbrown(1/4,2,1/2,inf),
	//\dur,Pseq([1,1/2,2,1,1,1/2,1/4,1/2,1/4,1,1/2,1,1/4,1/2,2,1],2),
\n,Prand([12,17,19,24],inf),
	//\cutt,Pbrown(440,10000,1000,4),
	\decay,Pbrown(2,6,1,inf);
)).play;
);
(
Pdef(\2, Pbind(\instrument, \ob,
	\dur,Pbrown(1/4,2,1/2,inf),
	///\dur,Pseq([1,1/2,2,1,1,1/2,1/4,1/2,1/4,1,1/2,1,1/4,1/2,2,1],2),
	\n,Prand([12,17,19,24],inf),
	//\cutt,Pbrown(440,10000,1000,4),
	\decay,Pbrown(2,6,1,inf);
)).play;
);
(
Pdef(\3, Pbind(\instrument, \oc,
		\dur,Pbrown(1/4,2,1/2,inf),
	//\dur,Pseq([1,1/2,2,1,1,1/2,1/4,1/2,1/4,1,1/2,1,1/4,1/2,2,1],2),
	\n,Prand([12,17,19,24],inf),
	//\cutt,Pbrown(440,10000,1000,4),
	\decay,Pbrown(2,6,1,inf);
)).play;
);
(
Pdef(\4, Pbind(\instrument, \od,
		\dur,Pbrown(1/4,2,1/2,inf),
	//\dur,Pseq([1,1/2,2,1,1,1/2,1/4,1/2,1/4,1,1/2,1,1/4,1/2,2,1],2),
	\n,Prand([12,17,19,24],inf),
	//\cutt,Pbrown(440,10000,1000,4),
	\decay,Pbrown(2,6,1,inf);
)).play;
);
(
Pdef(\5, Pbind(\instrument, \oe,
		\dur,Pbrown(1/4,2,1/2,inf),
	//\dur,Pseq([1,1/2,2,1,1,1/2,1/4,1/2,1/4,1,1/2,1,1/4,1/2,2,1],2),
	\n,Prand([12,17,19,24],inf),
	//\cutt,Pbrown(440,10000,1000,4),
	\decay,Pbrown(2,6,1,inf);
)).play;
);
(
Pdef(\6, Pbind(\instrument, \of,
		\dur,Pbrown(1/4,2,1/2,inf),
	//\dur,Pseq([1,1/2,2,1,1,1/2,1/4,1/2,1/4,1,1/2,1,1/4,1/2,2,1],2),
	\n,Prand([12,17,19,24],inf),
	//\cutt,Pbrown(440,10000,1000,4),
	\decay,Pbrown(2,6,1,inf);
)).play;
);
(
Pdef(\7, Pbind(\instrument, \og,
		\dur,Pbrown(1/4,2,1/2,inf),
	//\dur,Pseq([1,1/2,2,1,1,1/2,1/4,1/2,1/4,1,1/2,1,1/4,1/2,2,1],2),
	\n,Prand([12,17,19,24],inf),
	//\cutt,Pbrown(440,10000,1000,4),
	\decay,Pbrown(2,6,1,inf);
)).play;
);
(
Pdef(\8, Pbind(\instrument, \oh,
		\dur,Pbrown(1/4,2,1/2,inf),
	//\dur,Pseq([1,1/2,2,1,1,1/2,1/4,1/2,1/4,1,1/2,1,1/4,1/2,2,1],2),
	\n,Prand([12,17,19,24],inf),
	//\cutt,Pbrown(440,10000,1000,4),
	\decay,Pbrown(2,6,1,inf);
)).play;
);
)



///\n,Prand([12,17,19,24],inf),
//[8,20,23,11,25,15,23,22,8,20,23,11,22,15,18,20]