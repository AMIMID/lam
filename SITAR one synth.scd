//////////////////////////////////synth server and audio settings
s.options.sampleRate = 44100;
s.options.numBuffers = 1024*8;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;
s.options.outputStreamsEnabled.postln
s.options.device_("USB Sound Device");

({Out.ar(2,SoundIn.ar(0))}.play;
s.record(numChannels:4)

s.options.numWireBufs = 1024*16;

s.options.numOutputBusChannels=4;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
s.reboot
(
(
SynthDef.new(\oa, {
	arg rotation1=1,rotation2=1,rotation3=1,rotation4=1,rotation5=1,rotation6=1, cf=8, n=1;
	var frequency=2,detune1,detune2,detune3;
	var osc1,osc2,osc3;
	var freq,env;
	var bank, angle1,angle2,angle3,scale;
    var fundamental;
	var pitch;

	frequency=1;
	bank=12;
	angle1=0;
	angle2=90;
	angle3=45;
	pitch=2.pow(n/12);

	freq =(((4*cf)-1)*((4*cf)/2))/frequency;

 fundamental=((4*cf)-1)*((4*cf)/2);

	rotation1=TExpRand.ar(1,10,Dust.ar(1));
	rotation2=TExpRand.ar(1,10,Dust.ar(1));
	rotation3=TExpRand.ar(1,10,Dust.ar(1));
	rotation4=TExpRand.ar(1,10,Dust.ar(1));
	rotation5=TExpRand.ar(1,10,Dust.ar(1));
	rotation6=TExpRand.ar(1,10,Dust.ar(1));

env=EnvGen.ar(Env.perc(0.01,8,pitch.reciprocal),doneAction:2);

	bank.do{

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);

		angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune2=exp(Complex(0,1)*angle2);

		angle3=(angle3+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune3=exp(Complex(0,1)*angle3);




osc1=Pan4.ar(SinOsc.ar(freq*pitch,mul:bank.reciprocal,phase:detune1.theta),SinOsc.ar(rotation1*detune1.real,phase:0.degrad),SinOsc.ar(rotation4*detune1.imag,phase:0.degrad));

osc2=Pan4.ar(SinOsc.ar(freq*pitch,mul:bank.reciprocal,phase:detune2.theta),SinOsc.ar(rotation2*detune2.real,phase:90.degrad),SinOsc.ar(rotation5*detune2.imag,phase:90.degrad));

osc3=Pan4.ar(SinOsc.ar(freq*pitch,mul:bank.reciprocal,phase:detune3.theta),SinOsc.ar(rotation3*detune3.real,phase:45.degrad),SinOsc.ar(rotation6*detune3.imag,phase:45.neg.degrad));



		Out.ar(0,LeakDC.ar(osc1*env));
		Out.ar(0,LeakDC.ar(osc2*env));
		//Out.ar(0,LeakDC.ar(osc3));

	};

}).add;
);
)



(
MIDIClient.init;
MIDIIn.connectAll;
~note=Array.newClear(128);
)
~bend=8192;
~data=127;
~modul=127;

/////
(

MIDIdef.noteOn(\synhtone,{|val,num,chan,src|[val,num,chan,src].postln;
	if( num==49,{Synth.new(\oa,[\n,1])});
	if( num==50,{Synth.new(\oa,[\n,2])});
	if( num==51,{Synth.new(\oa,[\n,3])});
	if( num==52,{Synth.new(\oa,[\n,4])});
	if( num==53,{Synth.new(\oa,[\n,5])});
	if( num==54,{Synth.new(\oa,[\n,6])});
	if( num==55,{Synth.new(\oa,[\n,7])});
	if( num==56,{Synth.new(\oa,[\n,8])});
	if( num==57,{Synth.new(\oa,[\n,9])});
	if( num==58,{Synth.new(\oa,[\n,10])});
	if( num==59,{Synth.new(\oa,[\n,11])});
	if( num==60,{Synth.new(\oa,[\n,12])});
	if( num==61,{Synth.new(\oa,[\n,13])});
	if( num==62,{Synth.new(\oa,[\n,14])});
	if( num==63,{Synth.new(\oa,[\n,15])});
	if( num==64,{Synth.new(\oa,[\n,16])});
	if( num==65,{Synth.new(\oa,[\n,17])});
	if( num==66,{Synth.new(\oa,[\n,18])});
	if( num==67,{Synth.new(\oa,[\n,19])});
	if( num==68,{Synth.new(\oa,[\n,20])});
	if( num==69,{Synth.new(\oa,[\n,21])});
	if( num==70,{Synth.new(\oa,[\n,22])});
	if( num==71,{Synth.new(\oa,[\n,23])});
	if( num==72,{Synth.new(\oa,[\n,24])});
})
)
s.record(numChannels:4) ;
