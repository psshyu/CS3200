
%a = 1;
%b = 2;
%N = 28;
%[xi, wi] = QuadSchemeMidpoint(a,b,N);
%[xi, wi] = QuadSchemeTrapezoid(a,b,N);
%[xi, wi] = QuadSchemeSimpson(a,b,N);

GaussianQuad(0,2*pi,2, 'x + 1');