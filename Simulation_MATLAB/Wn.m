

close all

Fs = 16;                    % Sampling frequency
T = 1/Fs;                     % Sample time
N = 16;                     % Length of signal
n=0:N/2-1;
WN=exp(-i*2*pi/N*n);
Wn_Real=real(WN);
Wn_Imag=imag(WN);







%% save Wn_Real ceo file

Wn_Real=single(Wn_Real);
Wn_Real_Hex=num2hex(Wn_Real);

fid=fopen('Wn_Real.coe','wt');
fprintf(fid,'memory_initialization_radix=16;\n');
fprintf(fid,'memory_initialization_vector=\n');

for i=1:size(Wn_Real_Hex,1)
        for j=1:8
            fprintf(fid,'%c',Wn_Real_Hex(i,j));
        end
        
        if(i==16)
            fprintf(fid,';\n');
        else
            fprintf(fid, ',\n');
        end
end

fclose(fid);

%% save Wn_Imag ceo file
Wn_Imag=single(Wn_Imag);
Wn_Imag_Hex=num2hex(Wn_Imag);

fid=fopen('Wn_Imag.coe','wt');
fprintf(fid,'memory_initialization_radix=16;\n');
fprintf(fid,'memory_initialization_vector=\n');

for i=1:size(Wn_Imag_Hex,1)
        for j=1:8
            fprintf(fid,'%c',Wn_Imag_Hex(i,j));
        end
        
        if(i==16)
            fprintf(fid,';\n');
        else
            fprintf(fid, ',\n');
        end
end

fclose(fid);


x= yt;
    
 fftX= fft (x);
 fftX=bitrevorder(fftX);
 absFftX = abs (fftX);
 sqrFftX = absFftX.^2;
 sqe=sqrFftX;
 %% save Wn_Imag ceo file
sqrFftX=single(sqrFftX);
sqrFftX=num2hex(sqrFftX);

fid=fopen('sqrFftX.coe','wt');
fprintf(fid,'memory_initialization_radix=16;\n');
fprintf(fid,'memory_initialization_vector=\n');

for i=1:size(sqrFftX,1)
        for j=1:8
            fprintf(fid,'%c',sqrFftX(i,j));
        end
        
        if(i==16)
            fprintf(fid,';\n');
        else
            fprintf(fid, ',\n');
        end
end

fclose(fid);

%% save Wn_Imag ceo file
sqrFftX=single(real(fftX));
sqrFftX=num2hex(sqrFftX);

fid=fopen('real(fftX).coe','wt');
fprintf(fid,'memory_initialization_radix=16;\n');
fprintf(fid,'memory_initialization_vector=\n');

for i=1:size(sqrFftX,1)
        for j=1:8
            fprintf(fid,'%c',sqrFftX(i,j));
        end
        
        if(i==16)
            fprintf(fid,';\n');
        else
            fprintf(fid, ',\n');
        end
end

fclose(fid);