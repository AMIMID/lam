(
var angle=0,point;

20.collect{
angle=(angle+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	point=exp(Complex(0,1)*angle.degrad).theta;
}
)

s = Server.local;
s.waitForBoot {

n = 1000;

~freq = Array.rand(n, 20.0, 60.0).midicps;
~amp = Array.rand(n, 1/n * 0.01, 1/n * 0.5);
~pan= (
var angle=0,point;

1000.collect{
angle=(angle+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	point=exp(Complex(0,1)*angle.degrad).theta;
}
)

~sines = Array.fill(n, { arg i;
    { Pan2.ar( FSinOsc.ar(~freq[i], 0, ~amp[i]), ~pan[i]) }.play;
});

};

(
x = {
    var mags, phases, chain, sig,angle=0,point;
    // Create simple undulating magnitudes
    mags = (
10000.collect{
angle=(angle+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	point=exp(Complex(0,1)*angle.degrad).real;
}
);
    phases = (
10000.collect{
angle=(angle+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	point=exp(Complex(0,1)*angle.degrad).theta;
}
);
    // We need to create an FFT chain to feed our data in to.
    // The easiest way is to do an FFT on some signal which we then ignore!
    chain = FFT(LocalBuf(2048), SinOsc.ar);
    // Now we can do the packing
    chain = PackFFT(chain, 2048, [mags, phases].flop.flatten, 0, 99, 1);
    sig = IFFT(chain);
    sig.dup
}.play
)