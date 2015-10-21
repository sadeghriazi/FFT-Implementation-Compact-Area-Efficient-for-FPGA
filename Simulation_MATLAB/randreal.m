Fs = 16;                    % Sampling frequency
T = 1/Fs;                     % Sample time
L = 16;                     % Length of signal
t = (0:L-1)*T;                % Time vector
% Sum of a 3 Hz sinusoid and a 5 Hz sinusoid

randomreal = 2*randn(size(t));     % Sinusoids plus noise
randomrealt=randomreal';
randomimag =2*rand(size(t));
randomimagt= randomimag';
randomabs=randomreal.^2+randomimag.^2;
randomabst=randomabs';

randomreals=single(randomrealt);
randomimags=single(randomimagt);
randomabss=single(randomabst);
randomrealhex=num2hex(randomreals);
randomimaghex=num2hex(randomimags);
randomabshex=num2hex(randomabss);

fid=fopen('realmux.coe','wt');
fprintf(fid,'memory_initialization_radix=16;\n');
fprintf(fid,'memory_initialization_vector=\n');

for i=1:16
        for j=1:8
            fprintf(fid,'%c',randomrealhex(i,j));
        end
        
        if(i==16)
            fprintf(fid,';\n');
        else
            fprintf(fid, ',\n');
        end
end

fclose(fid);

fid=fopen('imagmux.coe','wt');
fprintf(fid,'memory_initialization_radix=16;\n');
fprintf(fid,'memory_initialization_vector=\n');

for i=1:16
        for j=1:8
            fprintf(fid,'%c',randomimaghex(i,j));
        end
        
        if(i==16)
            fprintf(fid,';\n');
        else
            fprintf(fid, ',\n');
        end
end

fclose(fid);


fid=fopen('absmux.coe','wt');
fprintf(fid,'memory_initialization_radix=16;\n');
fprintf(fid,'memory_initialization_vector=\n');

for i=1:16
        for j=1:8
            fprintf(fid,'%c',randomabshex(i,j));
        end
        
        if(i==16)
            fprintf(fid,';\n');
        else
            fprintf(fid, ',\n');
        end
end
