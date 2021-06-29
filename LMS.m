
signal = sin(2*pi*0.055*(0:1000-1)');
noise = randn(1000,1);
filt = dsp.FIRFilter;
filt.Numerator = fir1(11,0.4);
fnoise = filt(noise);
d = signal + fnoise;
coeffs = (filt.Numerator).'-0.01; % Set the filter initial conditions.
mu = 0.05; % Set the step size for algorithm updating.
lms = dsp.LMSFilter(12,'Method','Sign-Data LMS',...
   'StepSize',mu,'InitialConditions',coeffs);
[~,e] = lms(noise,d);
L = 200;
r = snr(e);
plot(0:L-1,signal(1:L),'k',0:L-1,d(1:L),'r',0:L-1,e(1:L),'g');
title('Noise Cancellation by the Sign-Data LMS Algorithm');
legend('Actual signal','Noisy Signal','Result of noise cancellation',...
       'Location','NorthEast');
xlabel('Time index')
ylabel('Signal values')
