s.record(numChannels:4)
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=12;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/60);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.reboot
Server.killAll
Buffer.freeAll


(
SynthDef.new(\oa, {
	arg  n=1, cutt=20000,decay=3;
	var amps,tf,tfBuf=0;
	var detune1, osc1,osc2;
	var freq1, env,m=1,x=0;
	var bank, angle1, pitch;
	var fund=(((4*2)-1)*((4*2)/2)),trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3,4,5,6,7,8,9,10,11]);  // multiple buses!

	bank=12;
	angle1=0;
	pitch=2.pow(n/(2*6));

	freq1 = fund*6;
	freq1=freq1*(1/1);

	bank.do{

env=EnvGen.ar(Env.perc(0.05,decay,pitch.reciprocal),trig,doneAction:2);
//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		detune1=exp(Complex(0,1)*(angle1.degrad));


		osc1=PanAz.ar(12,SinOsc.ar((freq1*m)*pitch,
			mul:m.reciprocal,
			phase:detune1.theta),
		detune1.real.round(0.001));

		osc2=PanAz.ar(12,SinOsc.ar((freq1*m)*pitch,
			mul:m.reciprocal,
			phase:detune1.theta),
		detune1.imag.round(0.001));

x=x+1;
	m=x+1;
	m.postln;

		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc1 )* env),cutt));
		wrappedOut.value(out, LPF.ar(LeakDC.ar((osc2 )* env),cutt));

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
	Synth(\oa, [n: num - 48, out: (0..11).rotate(12.rand)]);

}, noteNum: (36..96))
)