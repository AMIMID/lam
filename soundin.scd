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
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=1;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.reboot
(
(
(
SynthDef.new(\oa, {
	arg  n=1, cutt=440,decay=6;
	var detune1,detune2;
	var osc1;
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
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=24;
	angle1=0;
	//n=TRand.ar(1,12,SinOsc.ar(1/2)).round;
	pitch=2.pow(n/(2*6));


	//freq1 = fund*4;
	//freq1=freq1*(1/1);

	env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),doneAction:2);

	bank.do{

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);



		osc1=Pan4.ar(SoundIn.ar(0,mul:1),SinOsc.ar(pitch,phase:detune1.real.degrad,mul:pitch.reciprocal),SinOsc.ar(pitch,phase:detune1.imag.degrad,mul:pitch.reciprocal));

	wrappedOut.value(out, LeakDC.ar(osc1 * env ));

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
	Synth(\oa, [n: num - 48, out: (0..3).rotate(4.rand)]);
}, noteNum: (36..96))
)
s.record(numChannels:4) ;

