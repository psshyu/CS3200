% Example: Euler's method for dTc/dt = -r *(Tc - Ts)
%
clear all

K = 1;
s = 20;
Tc0 = 84;
firsterr = zeros(7,1);
lasterr  = zeros(7,1);
hlogs    = zeros(7,1);
subplot(2,1,1)

for nruns = 1:7
%********************************************************
%
if(nruns == 1)dt = 30.0;end
if(nruns == 2)dt = 15.0;end
if(nruns == 3)dt = 10.0;end
if(nruns == 4)dt = 5.0;end
if(nruns == 5)dt = 1.0;end
if(nruns == 6)dt = 0.5;end
if(nruns == 7)dt = 0.25;end
r = 0.025;
%r = 0.25;
%r = 0.3;
%r = 0.6;
Ts = 19.0;
npoints = int64(300.0/dt);

Tc = zeros(npoints,1); % this initializes the vector y to being all zeros
t = zeros(npoints,1);
Texact = zeros(npoints,1);

Tc(1) = Tc0; % the initial condition
t(1) = 0.0;
Texact(1) = Tc0; % initial condition is exact

for step=1:npoints-1 % loop over the timesteps
	Tc(step+1) = Tc(step) - dt*r*(Tc(step)-Ts);
	t(step+1) = t(step) + dt;
% as we know the exact solution lets calculate that too
 

	Texact(step+1) = Tsexact(t(step+1),Tc0,r,Ts); 
    %NOTE YOU HAVE TO WRITE THE  Tsexact function that delivers the exact solution to the problem
end

%olorstring='rbcmjyk';
%lot(t,Tc,'Color',colorstring(nruns))
plot(t,Tc)
%old on
hold all

%*************************************************************************************

   plot(t,Texact); %plots the exact solution (default plot is in blue, solid line)

  legend('dt=30','dt=15','dt=10','dt=5','dt=1','dt=0.5','dt=0.25','Exact')
  xlabel('Time ') % x-axis label
  ylabel('Temperature Ts ') % y-axis label

  
firsterr(nruns) = abs(Texact(2) - Tc(2));
lasterr(nruns)  = abs(Texact(npoints)-Tc(npoints));
hlogs(nruns)    = dt;
end

Ratefirst = (log(firsterr(1))-log(firsterr(6)))/(log(hlogs(1))-log(hlogs(6)));

Ratelast  = (log(lasterr(1))-log(lasterr(6)))/(log(hlogs(1))-log(hlogs(6)));

fprintf(' first rate %f6.3  last rate %f6.3',Ratefirst,Ratelast)

subplot(2,1,2)
loglog(hlogs,firsterr,hlogs,lasterr)
xlabel('log(dt)')
ylabel('log(error)')
legend('first step','end of integration')