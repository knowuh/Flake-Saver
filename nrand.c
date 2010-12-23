
// Copyright (c)  2010 Noah Paessel
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
//

#include "nrand.h"
#include <limits.h>
#include <math.h>
	#include <libc.h>
void seed() {
	srandomdev();
}

float rand_float () {
	double rdouble = 0;
	/*
	 DESCRIPTION
     The random() function uses a non-linear, additive feedback, random number generator, employing a default
     table of size 31 long integers.  It returns successive pseudo-random numbers in the range from 0 to
     (2**31)-1.  The period of this random number generator is very large, approximately 16*((2**31)-1).
	*/
	long   r = random();
	long max = powl(2,31) -1;
	double r2 = (double) r;
	rdouble = r2/max;
	return rdouble;
}


int rand_int (int range) {
	float rnd_f = rand_float();
	return (rnd_f * range) + 1;
}


float gauss () {
	double x;
	double pi,r1,r2;
	
	pi =  4*atan(1);
	r1 = -log(1-float_between(0.0f,1.0f));
	r2 =  2 * pi * float_between(0.0f,1.0f);
	r1 =  sqrt(2*r1);
	x  = r1 * cos(r2);
	// y  = r1 * sin(r2);
	return (x - 0.5f) * 2;
}

float float_between(float min, float max) {
	float rnd_f = rand_float();
	float scalar = max - min;
	rnd_f = rnd_f * scalar;
	rnd_f = rnd_f + min;
	return rnd_f;
}
