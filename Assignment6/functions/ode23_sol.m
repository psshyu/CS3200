% ODE23 method for dTc/dt = -r *(Tc - Ts)
% path to save graph outputs
folder = 'C:\Users\Skylar\Documents\GitHub\CS3200\Assignment5\output';

clear all

Tc0 = 84; % init coffe temp
r = 0.025;  % r-value
%r = 0.6;
Ts = 19.0;  % ambient temp

% vectors to capture error output
firsterr_pred = zeros(7,1); % error after 1st step
lasterr_pred  = zeros(7,1); % error at last step
firsterr_act = zeros(7,1); % error after 1st step
lasterr_act  = zeros(7,1); % error at last step
hlogs    = zeros(7,1); 

figure('Name', sprintf('ODE23 method'))         % figure title              
subplot(2,1,1) % plot for temp and time

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

    % this initializes the vector y to being all zeros
    t = zeros(npoints,1);
    Tode23 = zeros(npoints,1);
    Terror = zeros(npoints,1);
    Texact = zeros(npoints,1);
    
    % the initial conditions
    t(1) = 0.0;
    Tode23(1) = Tc0;
    Texact(1) = Tc0; 
    
    for step = 1:npoints-1 % loop over the timesteps
        t(step+1) = t(step) + dt;
        [Terror(step+1), Tode23(step+1)] = ODE23(t(step), Tode23(step), r, dt);
        Texact(step+1) = Tsexact(t(step+1),Tc0,r,Ts); % Analytical exact
    end

    plot(t,Tode23); % plot each ODE23 solution
    hold all
    plot(t,Texact); % plots the exact solution (default plot is in blue, solid line)
    title(sprintf('Temperature of Coffee with Respect to Time'));
    legend('dt=30','dt=15','dt=10','dt=5','dt=1','dt=0.5','dt=0.25','Exact')
    xlabel('Time') % x-axis label
    ylabel('Temperature') % y-axis label
    
    firsterr_pred(nruns) = abs(Terror(2));
    lasterr_pred(nruns) = abs(Terror(npoints));
    firsterr_act(nruns) = abs(Texact(2) - Tode23(2)); % error after 1st step
    lasterr_act(nruns)  = abs(Texact(npoints)-Tode23(npoints)); % error at last step
    hlogs(nruns)    = dt;
end

title(sprintf('Temperature of Coffee with Respect to Time'));

rateFirstTsexact = (log(firsterr_act(1))-log(firsterr_act(6)))/(log(hlogs(1))-log(hlogs(6)));
rateLastTsexact  = (log(lasterr_act(1))-log(lasterr_act(6)))/(log(hlogs(1))-log(hlogs(6)));
fprintf(' first rate %f6.3  last rate %f6.3',rateFirstTsexact,rateLastTsexact)

% error plot
subplot(2,1,2) 
loglog(hlogs,firsterr_pred(:,1), hlogs,lasterr_pred(:,1), hlogs,firsterr_act(:,1), hlogs,lasterr_act(:,1))
title(sprintf('Order of Error After First Step and Last Step'));
xlabel('log(dt)')
ylabel('log(error)')
legend('first step prediction', 'last step prediction', 'first step actual', 'last step actual')

%saveas(gcf, fullfile(folder, sprintf('ODE23')), 'jpg'); % saves figure to output