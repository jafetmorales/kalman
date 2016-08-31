% WRITTEN BY JAFET MORALES
% FOR DR. MICHELLE ZHANG'S STATISTICAL SIGNAL PROCESSING CLASS AT UTSA (2012)

clear all; close all; clc;
numSamples=200;

% TRANSMITTER NOISE
sigmaW=.6;
% RECEIVER NOISE (INCLUDING CHANNEL)
sigmaU=8;

% DEFINE HOW FAST CAN THE SAMPLE CHANGE WITH RESPECT TO THE
% PREVIOUS SAMPLE
% TRANSMITTED
xCoeff=.8;%.8
% RECEIVED
yCoeff=.9;%.9

w=sigmaW*randn(numSamples,1);
u=sigmaU*randn(numSamples,1);

x(1)=w(1);
y(1)=yCoeff*x(1)+u(1);
mu(1)=y(1);
sigmaKKm1(1)=0;
for i=2:numSamples

   x(i)=xCoeff*x(i-1)+w(i);
   y(i)=yCoeff*x(i)+u(i);

   %  PREDICTIVE STEP
   sigmaKKm1(i)=xCoeff^2*sigmaKKm1(i-1)^2+sigmaW^2;%std(x);

   %  UPDATE STEP
   c1=1/sigmaKKm1(i)^2;
   c2=1/sigmaU^2;
   mu(i)=(c1*mu(i-1)+c2*y(i))/(c1+c2);
end

plot(1:numSamples,x,1:numSamples,y,1:numSamples,mu)
legend('transmitted','received','denoised')

receiverNoise=mse(x-y)
improvementPercent=(1-mse(x-mu)/mse(x-y))*100