//////////////////////////////////synth server and audio settings
s.options.sampleRate = 44100;
s.options.numBuffers = 1024*8;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;
s.options.outputStreamsEnabled.postln//////////////////////////////////synth server and audio settings
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
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.reboot

b= Buffer.alloc(s,2048);

Buffer.freeAll

(
b.sine3(
	[1,1],
	[1,1],
	[0.degrad,90.degrad], asWavetable:false).plot
)
(



~sig = Signal.sineFill(1024, [1,1],

	[0.degrad,90.degrad]
);

~sig.plot;
~wt= ~sig.asWavetable;
b.loadCollection(~wt);
)

(
(
SynthDef.new(\oa, {
	arg  n,decay=8;
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
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
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



		env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),trig,doneAction:2);
	//env=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2);


		/*osc1=Pan2.ar(
					SinOsc.ar((freq1+detune2.real.round(0.0001))*(pitch),
				phase:detune1.theta,mul:1),
				detune1.real.round(0.001));


			osc2=Pan2.ar(
					SinOsc.ar((freq1+detune2.imag.round(0.0001))*(pitch),
						phase:detune1.theta,mul:1),
				detune1.imag.round(0.001));*/

			osc1=Pan4.ar(
			Osc.ar(b,(freq1+detune1.theta)*(pitch),
				phase:detune1.theta,mul:TExpRand.kr(trig:SinOsc.kr(0.1))),
				detune1.real.round(0.001),detune2.imag.round(0.001));


		wrappedOut.value(out, LeakDC.ar((osc1 )* env));
	//wrappedOut.value(out, LeakDC.ar((osc2 )* env*0.1));
		//Out.ar(0,LeakDC.ar((osc1 )* env*0.5));
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
	//Synth(\oa, [n: num - 48, out: (0..1).rotate(2.rand)]);
	Synth(\oa, [n: num - 48, out: (0..3).rotate(4.rand)]);
}, noteNum: (36..96))
)


(
Pdef(\1, Pbind(\instrument, \oa,
	\dur,1/3,
	\n,Pseq([8,20,23,11,25,15,23,22,8,20,23,11,22,15,18,20,18,15,22,11,23,20,8,22,23,15,25,11,23,20],inf),
	//\cutt,Pbrown(440,10000,1000,inf),
	\decay,Pbrown(1,8,1,inf);
)).play;
);

(
Pdef(\2, Pbind(\instrument, \oa,
	\dur,1/3,
	\n,Pseq([20,23,11,25,15,23,22,8,20,23,22,11,15,18,20,18,15,22,11,23,20,8,22,23,15,25,11,23,20,8],inf),
	//\cutt,Pbrown(440,10000,1000,inf),
	\decay,Pbrown(1,8,1,inf);
)).play;
);

