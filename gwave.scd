s.record(numChannels:4)
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/60);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.reboot
Server.killAll
Buffer.freeAll


(
	var angle1=1,detune1;

~amps = [1] ++ ({[0,exprand(0.01,1)].choose}!16);
~ph=16.collect{
	angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad).theta;
	};

b= Buffer.alloc(s,2048);

~sig = Signal.sineFill(1024, ~amps,
	~ph
);

~sig.plot;
~wt= ~sig.asWavetable;
b.loadCollection(~wt);
)

(
SynthDef.new(\oa, {
	arg  n=1, cutt=200,decay=3,harm=6,attack=0.01;
	var amps,tf,tfBuf=0;
	var detune1, osc1;
	var freq1, env,m=1,x=0;
	var bank, angle1, pitch;
	var fund=(((4*1)-1)*((4*1)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=18;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*harm;
	freq1=freq1*(1/1);
env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),trig,doneAction:2);

	bank.do{

//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(Osc.ar(b,(freq1)*pitch,
			mul:1,
			phase:detune1.theta),
		detune1.real.round(0.001),detune1.imag.round(0.001));

x=x+1;
	m=x+1;
	m.postln;

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env*0.1),cutt));

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
	Synth(\oa, [n: num - 48, out: (0..3).rotate(4.rand)]);

}, noteNum: (36..96))
)

(
Pdef(\1, Pbind(\instrument, \oa,
		\dur,Pbrown(1/4,1,1/4,inf),
	\harm,Prand([6,8,9,12],inf),
	//\dur,Pseq([1,1/2,2,1,1,1/2,1/4,1/2,1/4,1,1/2,1,1/4,1/2,2,1],2),
\n,Prand([8,20,23,11,25,15,23,22,8,20,23,11,22,15,18,20],inf),
	\cutt,Pbrown(440,5000,100,inf),
	\out,Pxrand([0,1,2,3],inf),
		\attack,Pbrown(0.01,1,0.1,inf),
	\decay,Pbrown(4,8,1,inf);
)).play;
)