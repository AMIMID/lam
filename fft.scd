c.free; c = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");

c = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/584948__dibko__birds-and-nature-4-channel-recording.wav",channels:1 );


(
{
    var in, chain, v,b=0,detune1,angle1=0;
    in = PlayBuf.ar(1, c, BufRateScale.kr(c), loop: 1);
   250.do{  chain = FFT(LocalBuf(1024), in);

		detune1=exp(Complex(0,1)*(angle1.degrad));

   chain = chain.pvcollect(1024, {|mag, phase, index|

        [mag, phase];


    }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;
		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		Out.ar(0,PanAz.ar(2,IFFT(chain),LFSaw.ar(0.999.rand)))
	}
}.play
)