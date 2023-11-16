
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.reboot
Server.killAll
Buffer.freeAll


(
(SynthDef.new(\oa, {
	arg  n=1, cutt=1300,decay=3,harm=3,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1,osc2;
	var freq1, env,m=1,x=0;
	var bank, pitch;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=12;
	angle1=45;
	pitch=2.pow(n/(2*6));
fund=(((4*t)-1)*((4*t)/2));
	freq1 = fund*harm;
	freq1=freq1*(1/1);


	bank.do{

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),trig,doneAction:2);

//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);


		detune1=exp(Complex(0,1)*(angle1.degrad));


		osc1=Pan2.ar(FreeVerb.ar(SinOsc.ar((freq1*m)*pitch,
			mul:m.reciprocal,
			phase:(detune1.theta)),0.1),
		detune1.real.round(0.0001));

		/*osc1=Pan4.ar(FreeVerb.ar(SinOsc.ar((freq1*m)*pitch,
			mul:m.reciprocal,
			phase:(detune1.theta)+LFNoise1.ar(m)),(m/bank)),
		detune1.real.round(0.0001),detune1.imag.round(0.0001));
*/

x=x+1;
	m=x+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env*1),cutt));
		//trig = TDelay.ar(trig, 1);


	};
}).add;);

(SynthDef.new(\ob, {
	arg  n=1, cutt=1300,decay=3,harm=3,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1,osc2;
	var freq1, env,m=1,x=0;
	var bank, pitch;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=12;
	angle1=45;
	pitch=2.pow(n/(2*6));
fund=(((4*t)-1)*((4*t)/2));
	freq1 = fund*harm;
	freq1=freq1*(1/1);


	bank.do{

//env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),trig,doneAction:2);

env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);


		detune1=exp(Complex(0,1)*(angle1.degrad));


		osc1=Pan2.ar(FreeVerb.ar(SinOsc.ar((freq1*m)*pitch,
			mul:m.reciprocal,
			phase:(detune1.theta)),0.1),
		detune1.real.round(0.0001));

		/*osc1=Pan4.ar(FreeVerb.ar(SinOsc.ar((freq1*m)*pitch,
			mul:m.reciprocal,
			phase:(detune1.theta)+LFNoise1.ar(m)),(m/bank)),
		detune1.real.round(0.0001),detune1.imag.round(0.0001));
*/

x=x+1;
	m=x+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env*1),cutt));
		//trig = TDelay.ar(trig, 1);


	};
}).add;);

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
	Synth(\oa, [n: num - 48, out: [(0..1).rotate(2.rand)]]);

}, noteNum: (36..96))
)



(
(
(
Tdef.new(\h,{loop({
Synth(\oa, [n: 2,decay:8, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n: 14,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 18,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 19,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n: 7,decay:8, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n: 14,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 19,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 22,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n: 2,decay:8, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n: 14,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 18,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 19,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n: 7,decay:8, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n: 14,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 19,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 22,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
//////////////////////////////////////////////////////////////////////
Synth(\oa, [n: 2,decay:8, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n: 14,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 18,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 19,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n: 7,decay:8, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n: 19,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 22,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 24,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
////////////////////////////////////////////////////////////////////////////
Synth(\oa, [n: 2,decay:8, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n: 14,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 21,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 18,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n: 7,decay:8, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n: 19,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 22,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 24,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n: 2,decay:8, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n: 14,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 21,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 18,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;

Synth(\oa, [n: 7,decay:8, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n: 19,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 22,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 24,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
	/////////////////////////////////////////////////////////////////////
Synth(\oa, [n: 7,decay:8, out: (0..1).rotate(2.rand)]);(1).wait;
Synth(\oa, [n: 14,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 21,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 18,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 19,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 2,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 24,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 21,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 18,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;
Synth(\oa, [n: 19,decay:4, out: (0..1).rotate(2.rand)]);(1/2).wait;

	}
)})
);
(
Tdef.new(\i,{loop({
ustain
Synth(\ob, [n: 0,decay:4*2, out: (0..1).rotate(2.rand)]);(1).wait;
	}
)})
);
Tdef(\h).stop;
Tdef(\h).play;
Tdef(\h).clear;
////////////////////4th
Tdef(\i).stop;
Tdef(\i).play;
Tdef(\i).clear;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////sine

)



(
Tdef.new(\oo,{

	Tdef(\h).play;(20).wait;
	Tdef(\k).play;(20).wait;
}
)
)
s.record(numChannels:4)
Tdef(\oo).stop;
Tdef(\oo).play;
Tdef(\oo).clear;