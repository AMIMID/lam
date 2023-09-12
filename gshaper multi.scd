(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/80);
s.options.memSize = 8192*8;
s.waitForBoot
)
Server.killAll
Buffer.freeAll

(
(
~tf=Array.fill(32,{
	var amps,angle1=0,detune1,ph;

	ph=24.collect{
	angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad).theta;
	};
	amps = [1] ++ ({[exprand(0.01,1),exprand(0.1,1)].choose}!24);

	Signal.sineFill(1025, amps,ph).asWavetableNoWrap;
});
);
~tBuf = Buffer.allocConsecutive(32,s,2048);

(
~tBuf.do({
	arg buf, i;
	buf.loadCollection(~tf[i]);
});
);
)

~tf.do({arg n,i; n.plot(~tBuf[i].bufnum.asString)});

(
SynthDef.new(\oa, {
	arg  n=1, cutt=1200,decay=3,harm=4,attack=0.01;
	var amps,tf,tfBuf=0;
	var detune1, osc1;
	var freq1, env,m=1,x=0;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=24;
	angle1=45;
	pitch=2.pow(n/(2*6));
	fund=fund;
	freq1 = fund*harm;
	freq1=freq1*(1/1);
env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),trig,doneAction:2);

	bank.do{

//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);


	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(FreeVerb.ar(Shaper.ar(~tBuf[tfBuf].bufnum,SinOsc.ar((freq1)*pitch,
			mul:LFNoise1.kr(0.1),
			phase:(detune1.theta*pi).mod(2pi))),m/25,0.5),
		detune1.real.round(0.001),detune1.imag.round(0.001));

x=x+1;
	m=x+1;
	//m.postln;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		tfBuf=tfBuf+1;

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env*harm.reciprocal),cutt));

	};
}).add;

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
	Synth(\oa, [n: num - 48, out:[ (0..3).rotate(4.rand)]]);

}, noteNum: (36..96))
)

(
Pdef(\1, Pbind(\instrument, \oa,
		\dur,Pbrown(1/2,1,1/8,inf),
	//\harm,Prand([2,3/2,4/3,1],inf),
	//\dur,Pseq([1,1/2,2,1,1,1/2,1/4,1/2,1/4,1,1/2,1,1/4,1/2,2,1],2),
\n,Prand([8,20,23,11,25,15,23,22,8,20,23,11,22,15,18,20],inf),
	\cutt,Pbrown(440,10000,1000,inf),
	\out, Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		\attack,Pbrown(0.01,1,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
)).play;
)

s.record(numChannels:4)