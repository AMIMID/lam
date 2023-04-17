(
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(2.999.rand,phase:0.degrad),SinOsc.ar(2.999.rand,phase:90.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(2.999.rand,phase:0.degrad),SinOsc.ar(2.999.rand,phase:90.neg.degrad))}.play;
//{Pan4.ar(SinOsc.ar(440),SinOsc.ar(0.999.rand,phase:90.degrad),SinOsc.ar(0.999.rand,phase:0.degrad))}.play;
//{Pan4.ar(SinOsc.ar(440),SinOsc.ar(0.999.rand,phase:90.neg.degrad),SinOsc.ar(0.999.rand,phase:0.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(2.999.rand,phase:45.degrad),SinOsc.ar(2.999.rand,phase:135.degrad))}.play;
{Pan4.ar(SinOsc.ar(440),SinOsc.ar(2.999.rand,phase:45.neg.degrad),SinOsc.ar(2.999.rand,phase:135.neg.degrad))}.play;
)


{(SinOsc.ar((10)+SinOsc.ar(440,mul:440)))}.play