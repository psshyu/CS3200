% Euler's method for dTc/dt = -r *(Tc - Ts)

% path to save graph outputs
folder = 'C:\Users\Skylar\Documents\GitHub\CS3200\Assignment5\output';

clear all

Tc0 = 84;   % init coffe temp
r = 0.025;  % r-value
%r = 0.6;
Ts = 19.0;  % ambient temp

firsterr = zeros(7,2); % error after 1st step
lasterr  = zeros(7,2); % error at last step
hlogs    = zeros(7,1);
figure('Name', sprintf('Forward Euler Solution - with Different Step Sizes'))         % figure title              
subplot(2,1,1)

for nruns = 1:7
    % 7 iterations for each h-step size
    if(nruns == 1)dt = 30.0;end
    if(nruns == 2)dt = 15.0;end
    if(nruns == 3)dt = 10.0;end
    if(nruns == 4)dt = 5.0;end
    if(nruns == 5)dt = 1.0;end
    if(nruns == 6)dt = 0.5;end
    if(nruns == 7)dt = 0.25;end

    npoints = int64(300.0/dt);

    Tc = zeros(npoints,1); % this initializes the vector y to being all zeros
    t = zeros(npoints,1);
    Texact = zeros(npoints,1);

    Tc(1) = Tc0; % the initial condition
    t(1) = 0.0;
    Texact(1) = Tc0; % initial condition is exact

    
    for step = 1:npoints-1 % loop over the timesteps
        t(step+1) = t(step) + dt;
        Tc(step+1) = Tc(step) - dt*r*(Tc(step)-Ts);     % fwd Euler's
        Texact(step+1) = Tsexact(t(step+1),Tc0,r,Ts);   % Analytical exact
    end

    plot(t,Tc);     % plot each fwd euler solution
    hold all
    plot(t,Texact); % plots the exact solution (default plot is in blue, solid line)
    legend('dt=30','dt=15','dt=10','dt=5','dt=1','dt=0.5','dt=0.25','Exact')
    xlabel('Time') % x-axis label
    ylabel('Temperature') % y-axis label

    firsterr(nruns) = abs(Texact(2) - Tc(2));
    lasterr(nruns)  = abs(Texact(npoints)-Tc(npoints));
    hlogs(nruns)    = dt;
end

title(sprintf('Temperature of Coffee with Respect to Time'));

rateFirstTsexact = (log(firsterr(1))-log(firsterr(6)))/(log(hlogs(1))-log(hlogs(6)));
rateLastTsexact  = (log(lasterr(1))-log(lasterr(6)))/(log(hlogs(1))-log(hlogs(6)));
fprintf(' first rate %f6.3  last rate %f6.3',rateFirstTsexact,rateLastTsexact)

subplot(2,1,2)  % error plot
loglog(hlogs,firsterr(:,1),hlogs,lasterr(:,1))
title(sprintf('Order of Error After First Step and Last Step'));
xlabel('log(dt)')
ylabel('log(error)')
legend('first step','end of integration')

%saveas(gcf, fullfile(folder, sprintf('FWD_EULER')), 'jpg'); % saves figure to output