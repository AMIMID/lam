
s.record(numChannels:4)
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.reboot




(
(
SynthDef.new(\oa, {
	arg  n,decay=4;
	var detune1, osc1,osc2,envo;
	var freq1,freq2,freq3,freq4, env;
	var bank, angle1,detune2, angle2;
	var pitch,m=0,over=1,ch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!

	bank=32;
	angle1=0;
	angle2=0;
	pitch=2.pow(n/(2*6));


	freq1 = fund*8;
	freq1=freq1*(1/1);


detune2=(exp(Complex(0,1)*SinOsc.ar(1,mul:0.1)));

	bank.do{


		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);



		//env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),trig,doneAction:2);
	env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);


			osc1=Pan4.ar(
			SinOsc.ar((freq1+detune1.theta)*(pitch),
				phase:detune1.theta,mul:TExpRand.kr(trig:SinOsc.kr(0.1))),
				detune1.real.round(0.001).real.round(0.001),detune2.imag.round(0.001)+detune2.imag.round(0.001));


		wrappedOut.value(out, LeakDC.ar((osc1 )* env));

			m = m+1;
		over = over + m;

		trig = TDelay.ar(trig, 0);
	};
}).add;
);
(
SynthDef.new(\ob, {
	arg  n,decay=4;
	var detune1, osc1,osc2,envo;
	var freq1,freq2,freq3,freq4, env;
	var bank, angle1,detune2, angle2;
	var pitch,m=0,over=1,ch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!

	bank=32;
	angle1=0;
	angle2=0;
	pitch=2.pow(n/(2*6));


	freq1 = fund*8;
	freq1=freq1*(1/1);


detune2=(exp(Complex(0,1)*SinOsc.ar(1,mul:0.1)));

	bank.do{


		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);



		//env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),trig,doneAction:2);
	env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);


			osc1=Pan4.ar(
			SinOsc.ar((freq1+detune1.theta)*(pitch),
				phase:detune1.theta,mul:TExpRand.kr(trig:SinOsc.kr(0.1))),
				detune1.real.round(0.001).real.round(0.001),detune2.imag.round(0.001)+detune2.imag.round(0.001));


		wrappedOut.value(out, LeakDC.ar((osc1 )* env));

			m = m+1;
		over = over + m;

		trig = TDelay.ar(trig, 0);
	};
}).add;
);
(
SynthDef.new(\oc, {
	arg  n,decay=4;
	var detune1, osc1,osc2,envo;
	var freq1,freq2,freq3,freq4, env;
	var bank, angle1,detune2, angle2;
	var pitch,m=0,over=1,ch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!

	bank=32;
	angle1=0;
	angle2=0;
	pitch=2.pow(n/(2*6));


	freq1 = fund*8;
	freq1=freq1*(1/1);


detune2=(exp(Complex(0,1)*SinOsc.ar(1,mul:0.1)));

	bank.do{


		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);



		//env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),trig,doneAction:2);
	env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);


			osc1=Pan4.ar(
			SinOsc.ar((freq1+detune1.theta)*(pitch),
				phase:detune1.theta,mul:TExpRand.kr(trig:SinOsc.kr(0.1))),
				detune1.real.round(0.001).real.round(0.001),detune2.imag.round(0.001)+detune2.imag.round(0.001));


		wrappedOut.value(out, LeakDC.ar((osc1 )* env));

			m = m+1;
		over = over + m;

		trig = TDelay.ar(trig, 0);
	};
}).add;
);
(
SynthDef.new(\od, {
	arg  n,decay=4;
	var detune1, osc1,osc2,envo;
	var freq1,freq2,freq3,freq4, env;
	var bank, angle1,detune2, angle2;
	var pitch,m=0,over=1,ch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!

	bank=32;
	angle1=0;
	angle2=0;
	pitch=2.pow(n/(2*6));


	freq1 = fund*8;
	freq1=freq1*(1/1);


detune2=(exp(Complex(0,1)*SinOsc.ar(1,mul:0.1)));

	bank.do{


		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);



		//env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),trig,doneAction:2);
	env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);


			osc1=Pan4.ar(
			SinOsc.ar((freq1+detune1.theta)*(pitch),
				phase:detune1.theta,mul:TExpRand.kr(trig:SinOsc.kr(0.1))),
				detune1.real.round(0.001).real.round(0.001),detune2.imag.round(0.001)+detune2.imag.round(0.001));


		wrappedOut.value(out, LeakDC.ar((osc1 )* env));

			m = m+1;
		over = over + m;

		trig = TDelay.ar(trig, 0);
	};
}).add;
);
(
SynthDef.new(\oe, {
	arg  n,decay=4;
	var detune1, osc1,osc2,envo;
	var freq1,freq2,freq3,freq4, env;
	var bank, angle1,detune2, angle2;
	var pitch,m=0,over=1,ch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!

	bank=32;
	angle1=0;
	angle2=0;
	pitch=2.pow(n/(2*6));


	freq1 = fund*8;
	freq1=freq1*(1/1);


detune2=(exp(Complex(0,1)*SinOsc.ar(1,mul:0.1)));

	bank.do{


		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);



		//env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),trig,doneAction:2);
	env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);


			osc1=Pan4.ar(
			SinOsc.ar((freq1+detune1.theta)*(pitch),
				phase:detune1.theta,mul:TExpRand.kr(trig:SinOsc.kr(0.1))),
				detune1.real.round(0.001).real.round(0.001),detune2.imag.round(0.001)+detune2.imag.round(0.001));


		wrappedOut.value(out, LeakDC.ar((osc1 )* env));

			m = m+1;
		over = over + m;

		trig = TDelay.ar(trig, 0);
	};
}).add;
);
(
SynthDef.new(\of, {
	arg  n,decay=4;
	var detune1, osc1,osc2,envo;
	var freq1,freq2,freq3,freq4, env;
	var bank, angle1,detune2, angle2;
	var pitch,m=0,over=1,ch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!

	bank=32;
	angle1=0;
	angle2=0;
	pitch=2.pow(n/(2*6));


	freq1 = fund*8;
	freq1=freq1*(1/1);


detune2=(exp(Complex(0,1)*SinOsc.ar(1,mul:0.1)));

	bank.do{


		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);



		//env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),trig,doneAction:2);
	env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);


			osc1=Pan4.ar(
			SinOsc.ar((freq1+detune1.theta)*(pitch),
				phase:detune1.theta,mul:TExpRand.kr(trig:SinOsc.kr(0.1))),
				detune1.real.round(0.001).real.round(0.001),detune2.imag.round(0.001)+detune2.imag.round(0.001));


		wrappedOut.value(out, LeakDC.ar((osc1 )* env));

			m = m+1;
		over = over + m;

		trig = TDelay.ar(trig, 0);
	};
}).add;
);
(
SynthDef.new(\og, {
	arg  n,decay=4;
	var detune1, osc1,osc2,envo;
	var freq1,freq2,freq3,freq4, env;
	var bank, angle1,detune2, angle2;
	var pitch,m=0,over=1,ch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!

	bank=32;
	angle1=0;
	angle2=0;
	pitch=2.pow(n/(2*6));


	freq1 = fund*8;
	freq1=freq1*(1/1);


detune2=(exp(Complex(0,1)*SinOsc.ar(1,mul:0.1)));

	bank.do{


		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);



		//env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),trig,doneAction:2);
	env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);


			osc1=Pan4.ar(
			SinOsc.ar((freq1+detune1.theta)*(pitch),
				phase:detune1.theta,mul:TExpRand.kr(trig:SinOsc.kr(0.1))),
				detune1.real.round(0.001).real.round(0.001),detune2.imag.round(0.001)+detune2.imag.round(0.001));


		wrappedOut.value(out, LeakDC.ar((osc1 )* env));

			m = m+1;
		over = over + m;

		trig = TDelay.ar(trig, 0);
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
	Synth(\ob, [n: num - 48, out: (0..3).rotate(4.rand)]);
	Synth(\oc, [n: num - 48, out: (0..3).rotate(4.rand)]);
	Synth(\od, [n: num - 48, out: (0..3).rotate(4.rand)]);
	Synth(\oe, [n: num - 48, out: (0..3).rotate(4.rand)]);
	Synth(\of, [n: num - 48, out: (0..3).rotate(4.rand)]);
	Synth(\og, [n: num - 48, out: (0..3).rotate(4.rand)]);
}, noteNum: (36..96))
)


s.record(numChannels:4);
(
(
Pdef(\1, Pbind(\instrument, \oa,
	\dur,Pbrown(1/4,2,1/2,inf),
	\n,Prand([12,17,19,24,29,31,36],inf),
	//\cutt,Pbrown(440,10000,1000,inf),
	\decay,Pbrown(2,4,1,inf);
)).play;
);
(
Pdef(\2, Pbind(\instrument, \ob,
	\dur,Pbrown(1/4,2,1/2,inf),
	\n,Prand([12,17,19,24,29,31,36],inf),
	//\cutt,Pbrown(440,10000,1000,inf),
	\decay,Pbrown(2,4,1,inf);
)).play;
);
(
Pdef(\3, Pbind(\instrument, \oc,
	\dur,Pbrown(1/4,2,1/2,inf),
	\n,Prand([12,17,19,24,29,31,36],inf),
	//\cutt,Pbrown(440,10000,1000,inf),
	\decay,Pbrown(2,4,1,inf);
)).play;
);
(
Pdef(\4, Pbind(\instrument, \od,
	\dur,Pbrown(1/4,2,1/2,inf),
	\n,Prand([12,17,19,24,29,31,36],inf),
	//\cutt,Pbrown(440,10000,1000,inf),
	\decay,Pbrown(2,4,1,inf);
)).play;
);
(
Pdef(\5, Pbind(\instrument, \oe,
	\dur,Pbrown(1/4,2,1/2,inf),
	\n,Prand([12,17,19,24,29,31,36],inf),
	//\cutt,Pbrown(440,10000,1000,inf),
	\decay,Pbrown(2,4,1,inf);
)).play;
);
(
Pdef(\6, Pbind(\instrument, \of,
	\dur,Pbrown(1/4,2,1/2,inf),
	\n,Prand([12,17,19,24,29,31,36],inf),
	//\cutt,Pbrown(440,10000,1000,inf),
	\decay,Pbrown(2,4,1,inf);
)).play;
);
(
Pdef(\7, Pbind(\instrument, \og,
	\dur,Pbrown(1/4,2,1/2,inf),
	\n,Prand([12,17,19,24,29,31,36],inf),
	//\cutt,Pbrown(440,10000,1000,inf),
	\decay,Pbrown(2,4,1,inf);
)).play;
);
)



///\n,Prand([12,17,19,24,29,31,36],inf),
