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
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
s.options.maxNodes=1024
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.reboot
(
(
SynthDef.new(\oa, {
	arg rotation1=1,rotation2=1, n=1, cutt=496,out=0;
	var frequency=8,detune1,detune2,detune3;
	var osc1,osc2;
	var freq1,env;
	var bank, angle1,angle2;
	var pitch,m=0,over=1;

	frequency=1;
	bank=8;
	angle1=0;
	angle2=90;
	pitch=2.pow(n/12);

	freq1 =(((4*8)-1)*((4*8)/2));
	freq1=freq1/3;

	rotation1=TExpRand.ar(0.1,10,Dust.ar(0.1));
	rotation2=TExpRand.ar(0.1,10,Dust.ar(0.1));


env=EnvGen.ar(Env.perc(0.01,4,pitch.reciprocal*0.5),doneAction:2);

	bank.do{

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);

		angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune2=exp(Complex(0,1)*angle2);





osc1=PanAz.ar(4,SinOsc.ar((freq1*over)*pitch,mul:over.reciprocal,phase:detune1.theta),SinOsc.ar(rotation1*detune1.real,phase:detune1.theta));

osc2=PanAz.ar(4,SinOsc.ar((freq1*over)*pitch,mul:over.reciprocal,phase:detune2.theta),SinOsc.ar(rotation2*detune1.imag,phase:detune2.theta));


	Out.ar(out,LeakDC.ar(LPF.ar(osc1*env,cutt)));
	Out.ar(out,LeakDC.ar(LPF.ar(osc2*env,cutt)));

		m = m+1;
		over = over + (m+1)/1;

	};
}).add;
);

MIDIClient.init;
MIDIIn.connectAll;

/////

// MIDIdef.cc(\dataentry,{|val,chan,src|[val,chan,src].postln; ~a.set(\cutt,val.linlin(1,127,110,880))},7);
// ~a=Synth.new(\oa);
// ~a.set(\cutt,220)

MIDIdef.noteOn(\synhtone,{|val,num,chan,src|[val,num,chan,src].postln;
	if( num==36,{Synth.new(\oa,[\n,13.neg,\out,Array.rand(4, 0, 3).choose])});
	if( num==37,{Synth.new(\oa,[\n,12.neg,\out,Array.rand(4, 0, 3).choose])});
	if( num==38,{Synth.new(\oa,[\n,11.neg,\out,Array.rand(4, 0, 3).choose])});
	if( num==39,{Synth.new(\oa,[\n,10.neg,\out,Array.rand(4, 0, 3).choose])});
	if( num==40,{Synth.new(\oa,[\n,9.neg,\out,Array.rand(4, 0, 3).choose])});
	if( num==41,{Synth.new(\oa,[\n,8.neg,\out,Array.rand(4, 0, 3).choose])});
	if( num==42,{Synth.new(\oa,[\n,7.neg,\out,Array.rand(4, 0, 3).choose])});
	if( num==43,{Synth.new(\oa,[\n,6.neg,\out,Array.rand(4, 0, 3).choose])});
	if( num==44,{Synth.new(\oa,[\n,5.neg,\out,Array.rand(4, 0, 3).choose])});
	if( num==45,{Synth.new(\oa,[\n,4.neg,\out,Array.rand(4, 0, 3).choose])});
	if( num==46,{Synth.new(\oa,[\n,3.neg,\out,Array.rand(4, 0, 3).choose])});
	if( num==47,{Synth.new(\oa,[\n,2.neg,\out,Array.rand(4, 0, 3).choose])});
	if( num==48,{Synth.new(\oa,[\n,1.neg,\out,Array.rand(4, 0, 3).choose])});
	if( num==49,{Synth.new(\oa,[\n,1,\out,Array.rand(4, 0, 3).choose])});
	if( num==50,{Synth.new(\oa,[\n,2,\out,Array.rand(4, 0, 3).choose])});
	if( num==51,{Synth.new(\oa,[\n,3,\out,Array.rand(4, 0, 3).choose])});
	if( num==52,{Synth.new(\oa,[\n,4,\out,Array.rand(4, 0, 3).choose])});
	if( num==53,{Synth.new(\oa,[\n,5,\out,Array.rand(4, 0, 3).choose])});
	if( num==54,{Synth.new(\oa,[\n,6,\out,Array.rand(4, 0, 3).choose])});
	if( num==55,{Synth.new(\oa,[\n,7,\out,Array.rand(4, 0, 3).choose])});
	if( num==56,{Synth.new(\oa,[\n,8,\out,Array.rand(4, 0, 3).choose])});
	if( num==57,{Synth.new(\oa,[\n,9,\out,Array.rand(4, 0, 3).choose])});
	if( num==58,{Synth.new(\oa,[\n,10,\out,Array.rand(4, 0, 3).choose])});
	if( num==59,{Synth.new(\oa,[\n,11,\out,Array.rand(4, 0, 3).choose])});
	if( num==60,{Synth.new(\oa,[\n,12,\out,Array.rand(4, 0, 3).choose])});
	if( num==61,{Synth.new(\oa,[\n,13,\out,Array.rand(4, 0, 3).choose])});
	if( num==62,{Synth.new(\oa,[\n,14,\out,Array.rand(4, 0, 3).choose])});
	if( num==63,{Synth.new(\oa,[\n,15,\out,Array.rand(4, 0, 3).choose])});
	if( num==64,{Synth.new(\oa,[\n,16,\out,Array.rand(4, 0, 3).choose])});
	if( num==65,{Synth.new(\oa,[\n,17,\out,Array.rand(4, 0, 3).choose])});
	if( num==66,{Synth.new(\oa,[\n,18,\out,Array.rand(4, 0, 3).choose])});
	if( num==67,{Synth.new(\oa,[\n,19,\out,Array.rand(4, 0, 3).choose])});
	if( num==68,{Synth.new(\oa,[\n,20,\out,Array.rand(4, 0, 3).choose])});
	if( num==69,{Synth.new(\oa,[\n,21,\out,Array.rand(4, 0, 3).choose])});
	if( num==70,{Synth.new(\oa,[\n,22,\out,Array.rand(4, 0, 3).choose])});
	if( num==71,{Synth.new(\oa,[\n,23,\out,Array.rand(4, 0, 3).choose])});
	if( num==72,{Synth.new(\oa,[\n,24,\out,Array.rand(4, 0, 3).choose])});
	if( num==73,{Synth.new(\oa,[\n,25,\out,Array.rand(4, 0, 3).choose])});
	if( num==74,{Synth.new(\oa,[\n,26,\out,Array.rand(4, 0, 3).choose])});
	if( num==75,{Synth.new(\oa,[\n,27,\out,Array.rand(4, 0, 3).choose])});
	if( num==76,{Synth.new(\oa,[\n,28,\out,Array.rand(4, 0, 3).choose])});
	if( num==77,{Synth.new(\oa,[\n,29,\out,Array.rand(4, 0, 3).choose])});
	if( num==78,{Synth.new(\oa,[\n,30,\out,Array.rand(4, 0, 3).choose])});
	if( num==79,{Synth.new(\oa,[\n,31,\out,Array.rand(4, 0, 3).choose])});
	if( num==80,{Synth.new(\oa,[\n,32,\out,Array.rand(4, 0, 3).choose])});
	if( num==81,{Synth.new(\oa,[\n,33,\out,Array.rand(4, 0, 3).choose])});
	if( num==82,{Synth.new(\oa,[\n,34,\out,Array.rand(4, 0, 3).choose])});
	if( num==83,{Synth.new(\oa,[\n,35,\out,Array.rand(4, 0, 3).choose])});
	if( num==84,{Synth.new(\oa,[\n,36,\out,Array.rand(4, 0, 3).choose])});
	if( num==85,{Synth.new(\oa,[\n,37,\out,Array.rand(4, 0, 3).choose])});
	if( num==86,{Synth.new(\oa,[\n,38,\out,Array.rand(4, 0, 3).choose])});
	if( num==87,{Synth.new(\oa,[\n,39,\out,Array.rand(4, 0, 3).choose])});
	if( num==88,{Synth.new(\oa,[\n,40,\out,Array.rand(4, 0, 3).choose])});
	if( num==89,{Synth.new(\oa,[\n,41,\out,Array.rand(4, 0, 3).choose])});
	if( num==90,{Synth.new(\oa,[\n,42,\out,Array.rand(4, 0, 3).choose])});
	if( num==91,{Synth.new(\oa,[\n,43,\out,Array.rand(4, 0, 3).choose])});
	if( num==92,{Synth.new(\oa,[\n,44,\out,Array.rand(4, 0, 3).choose])});
	if( num==93,{Synth.new(\oa,[\n,45,\out,Array.rand(4, 0, 3).choose])});
	if( num==94,{Synth.new(\oa,[\n,46,\out,Array.rand(4, 0, 3).choose])});
	if( num==95,{Synth.new(\oa,[\n,47,\out,Array.rand(4, 0, 3).choose])});
	if( num==96,{Synth.new(\oa,[\n,48,\out,Array.rand(4, 0, 3).choose])});
})
)
s.record(numChannels:4) ;



