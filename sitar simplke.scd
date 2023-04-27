(
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(2.999.rand,phase:0.degrad),SinOsc.ar(2.999.rand,phase:90.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(2.999.rand,phase:0.degrad),SinOsc.ar(2.999.rand,phase:90.neg.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(0.999.rand,phase:90.degrad),SinOsc.ar(0.999.rand,phase:0.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(0.999.rand,phase:90.neg.degrad),SinOsc.ar(0.999.rand,phase:0.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(2.999.rand,phase:45.degrad),SinOsc.ar(2.999.rand,phase:135.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(2.999.rand,phase:45.neg.degrad),SinOsc.ar(2.999.rand,phase:135.neg.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(2.999.rand,phase:135.degrad),SinOsc.ar(2.999.rand,phase:45.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(2.999.rand,phase:135.neg.degrad),SinOsc.ar(2.999.rand,phase:45.neg.degrad))}.play;
)


{(SinOsc.ar((10)+SinOsc.ar(440,mul:440)))}.play


(
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(2.999.rand,phase:0.degrad),SinOsc.ar(2.999.rand,phase:90.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(2.999.rand,phase:90.degrad),SinOsc.ar(2.999.rand,phase:0.degrad))}.play;
//{Pan4.ar(SinOsc.ar(440),SinOsc.ar(0.999.rand,phase:45.degrad),SinOsc.ar(0.999.rand,phase:135.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(0.999.rand,phase:0.neg.degrad),SinOsc.ar(0.999.rand,phase:90.neg.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(2.999.rand,phase:90.neg.degrad),SinOsc.ar(2.999.rand,phase:0.degrad))}.play;
//{Pan4.ar(SinOsc.ar(440),SinOsc.ar(2.999.rand,phase:45.neg.degrad),SinOsc.ar(2.999.rand,phase:135.neg.degrad))}.play;
)

(
{Pan4.ar(SinOsc.ar(440,phase:0.degrad),SinOsc.ar(10,phase:0.degrad),SinOsc.ar(10,phase:0.degrad))}.play;
{Pan4.ar(SinOsc.ar(440,phase:90.degrad),SinOsc.ar(10,phase:90.degrad),SinOsc.ar(10,phase:90.degrad))}.play;
//{Pan4.ar(SinOsc.ar(440,phase:45.degrad),SinOsc.ar(10,phase:45.degrad),SinOsc.ar(10,phase:45.neg.degrad))}.play;
s.record(numChannels:4) ;

)



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
s.options.numOutputBusChannels=8;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.reboot
(
(
SynthDef.new(\oa, {
	var osc1,osc2,osc3,osc4;
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1, 2]);  // multiple buses!


	osc1=Pan4.ar(SinOsc.ar(440,mul:1,phase:0.degrad),SinOsc.ar(0.1,phase:0.degrad),SinOsc.ar(0.1,phase:90.degrad));


	wrappedOut.value(out, LeakDC.ar(osc1));

}).add;
)

Synth.new(\oa)


/////////////////////////////////////

(
SynthDef.new(\oa, {
	var osc1,osc2,osc3,osc4;
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 2,3,6]);  // multiple buses!


	osc1=PanAz.ar(4,SinOsc.ar(440,mul:1,phase:0.degrad),SinOsc.ar(0.1,phase:0.degrad));


	wrappedOut.value(out, LeakDC.ar(osc1));

}).add;
)

Synth.new(\oa)


