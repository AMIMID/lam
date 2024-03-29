
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=18;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/60);
s.options.memSize = 8192*8;
s.waitForBoot
)
Buffer.freeAll
(
// 3D
a = VBAPSpeakerArray.new(3, [[0, 45], [90, 45], [180, 45], [-90, 45],[0, -45], [90, -45], [180, -45], [-90, -45],[0, 0], [45, 0], [90, 0], [135, 0],[180, 0], [-135, 0], [-90, 0], [-45,0]]); // torus geo dome
~b = Buffer.loadCollection(s, a.getSetsAndMatrices);
)

(
SynthDef.new(\oa, {
	arg  n=1, cutt=20000,decay=3,harm=6,t=2;
	var amps,tf,tfBuf=0;
	var detune1, osc1;
	var freq1, env,m=1,x=0;
	var bank, angle1, pitch;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);  // multiple buses!

	bank=6;
	angle1=45;
	pitch=2.pow(n/(2*6));
fund=(((4*t)-1)*((4*t)/2));
	freq1 = fund*harm;
	freq1=freq1*(1/1);

	bank.do{

env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		detune1=exp(Complex(0,1)*(angle1.degrad));

			osc1=VBAP.ar(16,SinOsc.ar((freq1*m+detune1.theta)*pitch,
			mul:m.reciprocal,
			phase:2pi/detune1.theta),~b.bufnum,detune1.real.raddeg.wrap(-180,180),detune1.imag.raddeg.wrap(-90,90));

x=x+1;
	m=x+1;
	m.postln;
	angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env),cutt));
///trig = TDelay.ar(trig, 1);
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
	Synth(\oa, [n: num - 48, out: (0..15).rotate(16.rand)]);

}, noteNum: (36..96))
)


(
Pdef(\1, Pbind(\instrument, \oa,
		\dur,Pbrown(1/4,1,1/4,inf),
	//\harm,Prand([6,8,9,12],inf),
	//\dur,Pseq([1,1/2,2,1,1,1/2,1/4,1/2,1/4,1,1/2,1,1/4,1/2,2,1],2),
\n,Prand([8,20,23,11,25,15,23,22,8,20,23,11,22,15,18,20],inf),
	\cutt,Pbrown(440,5000,100,inf),
	\out,Pxrand([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],inf),
	//\t,Prand([1,2,4],inf),
	\decay,Pbrown(4,8,1,inf);
)).play;
)