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
Buffer.freeAll

(
~e= Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/LITERARY DOCUMENTS/UNIVERSITY AND EDUCATION DOCUMENTS/acg/9/studio projects/examples/birdy.mp3",channels:0);
~k= Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/LITERARY DOCUMENTS/UNIVERSITY AND EDUCATION DOCUMENTS/acg/9/studio projects/examples/birdy.mp3",channels:1);
)

(
(
SynthDef.new(\oa, {
	var detune1;
	var osc1,osc2;
	var bank, angle1;
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!


	bank=100;
	angle1=0;

	bank.do{

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(PlayBuf.ar(1,0,BufRateScale.kr(0),loop:0)),detune1.real,detune1.imag);


		wrappedOut.value(out, osc1 *(0.1));

	};
}).add;
);
(
SynthDef.new(\ob, {
	var detune1;
	var osc1,osc2;
	var bank, angle1;
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!


	bank=100;
	angle1=0;

	bank.do{

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1.degrad);


		osc1=Pan4.ar(LeakDC.ar(PlayBuf.ar(1,1,BufRateScale.kr(1),loop:0)),detune1.real,detune1.imag);


		wrappedOut.value(out, osc1 *(0.1));

	};
}).add;
)
)

(
Synth(\oa, [out: (0..3).rotate(4.rand)]);
Synth(\ob,[ out: (0..3).rotate(4.rand)]);
)


(
SynthDef.new(\oa, {
	var detune1,cutt=20000;
	var osc1,osc2;
	var bank, angle1;

	bank=32;
	angle1=0;

	bank.do{

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);


		osc1=Pan2.ar(LeakDC.ar(SoundIn.ar(0),detune1.imag);
		osc2=Pan2.ar(LeakDC.ar(SoundIn.ar(0),detune1.real);



   Out.ar(0 ,LPF.ar(LeakDC.ar((osc1 )*0.1),cutt));
	 Out.ar(0, LPF.ar(LeakDC.ar((osc1 )*0.1),cutt));

	};
}).add;
)
