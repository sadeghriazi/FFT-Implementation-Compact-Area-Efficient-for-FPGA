

%close all

Fs = 16;                    % Sampling frequency
T = 1/Fs;                     % Sample time
L = 16;                     % Length of signal
t = (0:L-1)*T;                % Time vector
% Sum of a 3 Hz sinusoid and a 5 Hz sinusoid
x = 0.7*sin(2*pi*3*t) + sin(2*pi*6*t); 

y = x + .2*randn(size(t));     % Sinusoids plus noise
yt=y';
plot(t(1:L),y(1:L))
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('time (seconds)')

NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
absolute = 2*abs(Y(1:NFFT/2+1)) ; 
figure; 
plot(f,absolute) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
text = sprintf('Value at 3 Hz is %s',absolute(3));
disp(text) ; 
text = sprintf('Value at 5 Hz is %s',absolute(5));
disp(text) ; 



%% save ceo file

yt=single(yt);
signalhex=num2hex(yt);

fid=fopen('signal.coe','wt');
fprintf(fid,'memory_initialization_radix=16;\n');
fprintf(fid,'memory_initialization_vector=\n');

for i=1:16
        for j=1:8
            fprintf(fid,'%c',signalhex(i,j));
        end
        
        if(i==16)
            fprintf(fid,';\n');
        else
            fprintf(fid, ',\n');
        end
end

fclose(fid);
