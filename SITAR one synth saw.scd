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
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
s.reboot
(
(
SynthDef.new(\oa, {
	arg rotation1=1,rotation2=1,rotation3=1,rotation4=1,rotation5=1,rotation6=1, n=1, cutt=1000;
	var frequency=8,detune1,detune2,detune3;
	var osc1,osc2,osc3;
	var freq,env;
	var bank, angle1,angle2,angle3,scale;
	var pitch,m=0,over=1;

	frequency=1;
	bank=8;
	angle1=0;
	angle2=90;
	//angle3=45;
	pitch=2.pow(n/12);

	freq =(((4*8)-1)*((4*8)/2));
	freq=freq/2;


	rotation1=TExpRand.ar(1,2,Dust.ar(1));
	rotation2=TExpRand.ar(1,2,Dust.ar(1));
	rotation3=TExpRand.ar(1,2,Dust.ar(1));
	rotation4=TExpRand.ar(1,2,Dust.ar(1));
	rotation5=TExpRand.ar(1,2,Dust.ar(1));
	rotation6=TExpRand.ar(1,2,Dust.ar(1));

env=EnvGen.ar(Env.perc(0.01,6,pitch.reciprocal),doneAction:2);

	bank.do{

		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune1=exp(Complex(0,1)*angle1);

		angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune2=exp(Complex(0,1)*angle2);

//		angle3=(angle3+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
//	detune3=exp(Complex(0,1)*angle3);




osc1=Pan4.ar(SinOsc.ar((freq*over)*pitch,mul:over.reciprocal,phase:detune1.theta),SinOsc.ar(rotation1*detune1.real,phase:0.degrad),SinOsc.ar(rotation4*detune1.imag,phase:0.degrad),);

osc2=Pan4.ar(SinOsc.ar((freq*over)*pitch,mul:over.reciprocal,phase:detune2.theta),SinOsc.ar(rotation2*detune2.real,phase:90.degrad),SinOsc.ar(rotation5*detune2.imag,phase:90.degrad));

//osc3=Pan4.ar(SinOsc.ar((freq*over)*pitch,mul:over.reciprocal,phase:detune3.theta),SinOsc.ar(rotation3*detune3.real,phase:45.degrad),SinOsc.ar(rotation6*detune3.imag,phase:45.neg.degrad));


       //Out.ar(4,LeakDC.ar(LPF.ar(osc1*env,220)));
		//Out.ar(4,LeakDC.ar(LPF.ar(osc2*env,220)));

		Out.ar(0,LeakDC.ar(LPF.ar(osc1*env,cutt)));
	Out.ar(0,LeakDC.ar(LPF.ar(osc2*env,cutt)));
	//Out.ar(0,LeakDC.ar(LPF.ar(osc3,220)));

		m = m+1;
		over = over + (m+1)/1;

	};
}).add;
);

SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;

)

(
MIDIClient.init;
MIDIIn.connectAll;
)
~bend=8192;
~data=127;
~modul=127;

/////

// MIDIdef.cc(\dataentry,{|val,chan,src|[val,chan,src].postln; ~a.set(\cutt,val.linlin(1,127,110,880))},7);
// ~a=Synth.new(\oa);
// ~a.set(\cutt,220)

(

MIDIdef.noteOn(\synhtone,{|val,num,chan,src|[val,num,chan,src].postln;
	if( num==36,{Synth.new(\oa,[\n,13.neg])});
	if( num==37,{Synth.new(\oa,[\n,12.neg])});
	if( num==38,{Synth.new(\oa,[\n,11.neg])});
	if( num==39,{Synth.new(\oa,[\n,10.neg])});
	if( num==40,{Synth.new(\oa,[\n,9.neg])});
	if( num==41,{Synth.new(\oa,[\n,8.neg])});
	if( num==42,{Synth.new(\oa,[\n,7.neg])});
	if( num==43,{Synth.new(\oa,[\n,6.neg])});
	if( num==44,{Synth.new(\oa,[\n,5.neg])});
	if( num==45,{Synth.new(\oa,[\n,4.neg])});
	if( num==46,{Synth.new(\oa,[\n,3.neg])});
	if( num==47,{Synth.new(\oa,[\n,2.neg])});
	if( num==48,{Synth.new(\oa,[\n,1.neg])});
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
	if( num==73,{Synth.new(\oa,[\n,25])});
	if( num==74,{Synth.new(\oa,[\n,26])});
	if( num==75,{Synth.new(\oa,[\n,27])});
	if( num==76,{Synth.new(\oa,[\n,28])});
	if( num==77,{Synth.new(\oa,[\n,29])});
	if( num==78,{Synth.new(\oa,[\n,30])});
	if( num==79,{Synth.new(\oa,[\n,31])});
	if( num==80,{Synth.new(\oa,[\n,32])});
	if( num==81,{Synth.new(\oa,[\n,33])});
	if( num==82,{Synth.new(\oa,[\n,34])});
	if( num==83,{Synth.new(\oa,[\n,35])});
	if( num==84,{Synth.new(\oa,[\n,36])});
	if( num==85,{Synth.new(\oa,[\n,37])});
	if( num==86,{Synth.new(\oa,[\n,38])});
	if( num==87,{Synth.new(\oa,[\n,39])});
	if( num==88,{Synth.new(\oa,[\n,40])});
	if( num==89,{Synth.new(\oa,[\n,41])});
	if( num==90,{Synth.new(\oa,[\n,42])});
	if( num==91,{Synth.new(\oa,[\n,43])});
	if( num==92,{Synth.new(\oa,[\n,44])});
	if( num==93,{Synth.new(\oa,[\n,45])});
	if( num==94,{Synth.new(\oa,[\n,46])});
	if( num==95,{Synth.new(\oa,[\n,47])});
	if( num==96,{Synth.new(\oa,[\n,48])});
})
)
s.record(numChannels:4) ;


(

MIDIdef.noteOn(\synhtone,{|val,num,chan,src|[val,num,chan,src].postln;
	if( num==36,{Synth.new(\oa,[\n,13.neg]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==37,{Synth.new(\oa,[\n,12.neg]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==38,{Synth.new(\oa,[\n,11.neg]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==39,{Synth.new(\oa,[\n,10.neg]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==40,{Synth.new(\oa,[\n,9.neg]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==41,{Synth.new(\oa,[\n,8.neg]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==42,{Synth.new(\oa,[\n,7.neg]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==43,{Synth.new(\oa,[\n,6.neg]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==44,{Synth.new(\oa,[\n,5.neg]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==45,{Synth.new(\oa,[\n,4.neg]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==46,{Synth.new(\oa,[\n,3.neg]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==47,{Synth.new(\oa,[\n,2.neg]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==48,{Synth.new(\oa,[\n,1.neg]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==49,{Synth.new(\oa,[\n,1]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==50,{Synth.new(\oa,[\n,2]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==51,{Synth.new(\oa,[\n,3]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==52,{Synth.new(\oa,[\n,4]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==53,{Synth.new(\oa,[\n,5]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==54,{Synth.new(\oa,[\n,6]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==55,{Synth.new(\oa,[\n,7]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==56,{Synth.new(\oa,[\n,8]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==57,{Synth.new(\oa,[\n,9]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==58,{Synth.new(\oa,[\n,10]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==59,{Synth.new(\oa,[\n,11]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==60,{Synth.new(\oa,[\n,12]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==61,{Synth.new(\oa,[\n,13]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==62,{Synth.new(\oa,[\n,14]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==63,{Synth.new(\oa,[\n,15]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==64,{Synth.new(\oa,[\n,16]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==65,{Synth.new(\oa,[\n,17]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==66,{Synth.new(\oa,[\n,18]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==67,{Synth.new(\oa,[\n,19]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==68,{Synth.new(\oa,[\n,20]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==69,{Synth.new(\oa,[\n,21]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==70,{Synth.new(\oa,[\n,22]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==71,{Synth.new(\oa,[\n,23]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==72,{Synth.new(\oa,[\n,24]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==73,{Synth.new(\oa,[\n,25]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==74,{Synth.new(\oa,[\n,26]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==75,{Synth.new(\oa,[\n,27]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==76,{Synth.new(\oa,[\n,28]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==77,{Synth.new(\oa,[\n,29]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==78,{Synth.new(\oa,[\n,30]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==79,{Synth.new(\oa,[\n,31]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==80,{Synth.new(\oa,[\n,32]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==81,{Synth.new(\oa,[\n,33]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==82,{Synth.new(\oa,[\n,34]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==83,{Synth.new(\oa,[\n,35]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==84,{Synth.new(\oa,[\n,36]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==85,{Synth.new(\oa,[\n,37]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==86,{Synth.new(\oa,[\n,38]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==87,{Synth.new(\oa,[\n,39]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==88,{Synth.new(\oa,[\n,40]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==89,{Synth.new(\oa,[\n,41]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==90,{Synth.new(\oa,[\n,42]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==91,{Synth.new(\oa,[\n,43]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==92,{Synth.new(\oa,[\n,44]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==93,{Synth.new(\oa,[\n,45]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==94,{Synth.new(\oa,[\n,46]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==95,{Synth.new(\oa,[\n,47]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
	if( num==96,{Synth.new(\oa,[\n,48]);(SynthDef.new(\ob, {
 Out.ar(0,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(1,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(2,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
Out.ar(3,LeakDC.ar(InFeedback.ar(Array.rand(4, 4, 7).choose)));
}).add;Synth.new(\ob);)});
})
)
