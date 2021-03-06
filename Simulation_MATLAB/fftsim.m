clear all

x= [
            -0.2993838,
            1.3896283,
            -0.29296833,
            -0.7957215,
            0.126703,
            -0.7349312,
            -0.4006653,
            1.838972,
            -0.19768694,
            -1.2070067,
            0.13724472,
            0.3602137,
            -0.42373636,
            0.837462,
            0.42331788,
            -1.5385498
            
        ];
    
 WN=    [
        1,
        0.9238795-i*0.38268343,
        0.70710677-i*0.70710677,
        0.38268343-i*0.9238795,
        6.123234E-17-i,
        -0.38268343-i*0.9238795,
        -0.70710677-i*0.70710677,
        -0.9238795-i*0.38268343,
        -1.0,
        -0.9238795+i*0.38268343,
        -0.70710677+i*0.70710677,
        -0.38268343+i*0.9238795,
        i,
        0.38268343+i*0.9238795,
        0.70710677+i*0.70710677,
        exp(-i*2*pi/16)
        ];
    
    
  stage1=[
            x(1)+x(9),
            x(2)+x(10),
            x(3)+x(11),
            x(4)+x(12),
            x(5)+x(13),
            x(6)+x(14),
            x(7)+x(15),
            x(8)+x(16),
            x(1)-x(9),
            x(2)-x(10),
            x(3)-x(11),
            x(4)-x(12),
            x(5)-x(13),
            x(6)-x(14),
            x(7)-x(15),
            x(8)-x(16),
            
            
         ];  
         
     stage2=[
                stage1(1),
                stage1(2),
                stage1(3),
                stage1(4),
                stage1(5),
                stage1(6),
                stage1(7),
                stage1(8),
                stage1(9),
                stage1(10)*(WN(16,1))^1,
                stage1(11)*(WN(16,1))^2,
                stage1(12)*(WN(16,1))^3,
                stage1(13)*(WN(16,1))^4,
                stage1(14)*(WN(16,1))^5,
                stage1(15)*(WN(16,1))^6,
                stage1(16)*(WN(16,1))^7
            ];   
         
        stage3=[
                stage2(1)+stage2(5),
                stage2(2)+stage2(6),
                stage2(3)+stage2(7),
                stage2(4)+stage2(8),
              
                stage2(1)-stage2(5),
                stage2(2)-stage2(6),
                stage2(3)-stage2(7),
                stage2(4)-stage2(8),
                
                
                stage2(9)+stage2(13),
                stage2(10)+stage2(14),
                stage2(11)+stage2(15),
                stage2(12)+stage2(16),
                
                stage2(9)-stage2(13),
                stage2(10)-stage2(14),
                stage2(11)-stage2(15),
                stage2(12)-stage2(16),
               ];
           
           stage4=[
                    stage3(1),
                    stage3(2),
                    stage3(3),
                    stage3(4),
                    stage3(5),
                    stage3(6)*(WN(16,1))^2,
                    stage3(7)*(WN(16,1))^4,
                    stage3(8)*(WN(16,1))^6,
                    stage3(9),
                    stage3(10),
                    stage3(11),
                    stage3(12),
                    stage3(13),
                    stage3(14)*(WN(16,1))^2,
                    stage3(15)*(WN(16,1))^4,
                    stage3(16)*(WN(16,1))^6,
                    ];
                
           stage5=[
                    stage4(1)+stage4(3),
                    stage4(2)+stage4(4),
                    stage4(1)-stage4(3),
                    stage4(2)-stage4(4),
                    
                    stage4(5)+stage4(7),
                    stage4(6)+stage4(8),
                    stage4(5)-stage4(7),
                    stage4(6)-stage4(8),
                    
                    stage4(9)+stage4(11),
                    stage4(10)+stage4(12),
                    stage4(9)-stage4(11),
                    stage4(10)-stage4(12),
                    
                    stage4(13)+stage4(15),
                    stage4(14)+stage4(16),
                    stage4(13)-stage4(15),
                    stage4(14)-stage4(16),
                   ];
               
               stage6=[
                        stage5(1),
                        stage5(2),
                        stage5(3),
                        stage5(4)*(WN(16,1))^4,
                        stage5(5),
                        stage5(6),
                        stage5(7),
                        stage5(8)*(WN(16,1))^4,
                        stage5(9),
                        stage5(10),
                        stage5(11),
                        stage5(12)*(WN(16,1))^4,
                        stage5(13),
                        stage5(14),
                        stage5(15),
                        stage5(16)*(WN(16,1))^4,
                        ];
               
                    
                    
                stage7=[
                        
                        stage6(1)+stage6(2),
                        stage6(1)-stage6(2),
                        
                        stage6(3)+stage6(4),
                        stage6(3)-stage6(4),

                        stage6(5)+stage6(6),
                        stage6(5)-stage6(6),

                        stage6(7)+stage6(8),
                        stage6(7)-stage6(8),

                        stage6(9)+stage6(10),
                        stage6(9)-stage6(10),

                        stage6(11)+stage6(12),
                        stage6(11)-stage6(12),
                            
                        stage6(13)+stage6(14),
                        stage6(13)-stage6(14),

                        stage6(15)+stage6(16),
                        stage6(15)-stage6(16),

                    ];
                
                
                
                       stage1real=real(stage1);
                       stage1im=imag(stage1);
                       
                       stage2real=real(stage2);
                       stage2im=imag(stage2);
                       
                       stage3real=real(stage3);
                       stage3im=imag(stage3);
                       
                       stage4real=real(stage4);
                       stage4im=imag(stage4);
                
                       stage5real=real(stage5);
                       stage5im=imag(stage5);
                
                       stage6real=real(stage6);
                       stage6im=imag(stage6);
                
                       stage7real=real(stage7);
                       stage7im=imag(stage7);
                
                
                
                       
                    
                
                
 %%               
                signalsingle=single(x);
                WNsingle=single(WN);
                
                stage1realsingle=single(stage1real);
                stage1imsingle=single(stage1im);
                
                stage2realsingle=single(stage2real);
                stage2imsingle=single(stage2im);
                
                stage3realsingle=single(stage3real);
                stage3imsingle=single(stage3im);
                
                stage4realsingle=single(stage4real);
                stage4imsingle=single(stage4im);
                
                stage5realsingle=single(stage5real);
                stage5imsingle=single(stage5im);
                
                stage6realsingle=single(stage6real);
                stage6imsingle=single(stage6im);
                
                stage7realsingle=single(stage7real);
                stage7imsingle=single(stage7im);
                
              
                
                
                 signalhex=num2hex(signalsingle);
                 stage1realhex=num2hex(stage1realsingle);
                 stage1imhex=num2hex(stage1imsingle);
                 stage2realhex=num2hex(stage2realsingle);
                 stage2imhex=num2hex(stage2imsingle);
                 stage3realhex=num2hex(stage3realsingle);
                 stage3imhex=num2hex(stage3imsingle);
                 stage4realhex=num2hex(stage4realsingle);
                 stage4imhex=num2hex(stage4imsingle);
                 stage5realhex=num2hex(stage5realsingle);
                 stage5imhex=num2hex(stage5imsingle);
                 stage6realhex=num2hex(stage6realsingle);
                 stage6imhex=num2hex(stage6imsingle);
                 stage7realhex=num2hex(stage7realsingle);
                 stage7imhex=num2hex(stage7imsingle);
                 
 
                 fid=fopen('stage1real.coe','wt');
                 fprintf(fid,'memory_initialization_radix=16;\n');
                 fprintf(fid,'memory_initialization_vector=\n');
 
                 for i=1:16
                         for j=1:8
                             fprintf(fid,'%c',stage1realhex(i,j));
                         end
 
                         if(i==16)
                             fprintf(fid,';\n');
                         else
                             fprintf(fid, ',\n');
                         end
                 end
 
                 fclose(fid);
                 
                 fid=fopen('stage1imag.coe','wt');
                 fprintf(fid,'memory_initialization_radix=16;\n');
                 fprintf(fid,'memory_initialization_vector=\n');
 
                 for i=1:16
                         for j=1:8
                             fprintf(fid,'%c',stage1imhex(i,j));
                         end
 
                         if(i==16)
                             fprintf(fid,';\n');
                         else
                             fprintf(fid, ',\n');
                         end
                 end
 
                 fclose(fid);
                 
                 
                 fid=fopen('stage2real.coe','wt');
                 fprintf(fid,'memory_initialization_radix=16;\n');
                 fprintf(fid,'memory_initialization_vector=\n');
 
                 for i=1:16
                         for j=1:8
                             fprintf(fid,'%c',stage2realhex(i,j));
                         end
 
                         if(i==16)
                             fprintf(fid,';\n');
                         else
                             fprintf(fid, ',\n');
                         end
                 end
 
                 fclose(fid);
                 
                 fid=fopen('stage2imag.coe','wt');
                 fprintf(fid,'memory_initialization_radix=16;\n');
                 fprintf(fid,'memory_initialization_vector=\n');
 
                 for i=1:16
                         for j=1:8
                             fprintf(fid,'%c',stage2imhex(i,j));
                         end
 
                         if(i==16)
                             fprintf(fid,';\n');
                         else
                             fprintf(fid, ',\n');
                         end
                 end
 
                 fclose(fid);

         
         fid=fopen('stage3real.coe','wt');
                 fprintf(fid,'memory_initialization_radix=16;\n');
                 fprintf(fid,'memory_initialization_vector=\n');
 
                 for i=1:16
                         for j=1:8
                             fprintf(fid,'%c',stage3realhex(i,j));
                         end
 
                         if(i==16)
                             fprintf(fid,';\n');
                         else
                             fprintf(fid, ',\n');
                         end
                 end
 
                 fclose(fid);
                 
                 fid=fopen('stage3imag.coe','wt');
                 fprintf(fid,'memory_initialization_radix=16;\n');
                 fprintf(fid,'memory_initialization_vector=\n');
 
                 for i=1:16
                         for j=1:8
                             fprintf(fid,'%c',stage3imhex(i,j));
                         end
 
                         if(i==16)
                             fprintf(fid,';\n');
                         else
                             fprintf(fid, ',\n');
                         end
                 end
 
                 fclose(fid);
                 
                 
                 
                 fid=fopen('stage4real.coe','wt');
                 fprintf(fid,'memory_initialization_radix=16;\n');
                 fprintf(fid,'memory_initialization_vector=\n');
 
                 for i=1:16
                         for j=1:8
                             fprintf(fid,'%c',stage4realhex(i,j));
                         end
 
                         if(i==16)
                             fprintf(fid,';\n');
                         else
                             fprintf(fid, ',\n');
                         end
                 end
 
                 fclose(fid);
                 
                 fid=fopen('stage4imag.coe','wt');
                 fprintf(fid,'memory_initialization_radix=16;\n');
                 fprintf(fid,'memory_initialization_vector=\n');
 
                 for i=1:16
                         for j=1:8
                             fprintf(fid,'%c',stage4imhex(i,j));
                         end
 
                         if(i==16)
                             fprintf(fid,';\n');
                         else
                             fprintf(fid, ',\n');
                         end
                 end
 
                 fclose(fid);
                 
                 
                 fid=fopen('stage5real.coe','wt');
                 fprintf(fid,'memory_initialization_radix=16;\n');
                 fprintf(fid,'memory_initialization_vector=\n');
 
                 for i=1:16
                         for j=1:8
                             fprintf(fid,'%c',stage5realhex(i,j));
                         end
 
                         if(i==16)
                             fprintf(fid,';\n');
                         else
                             fprintf(fid, ',\n');
                         end
                 end
 
                 fclose(fid);
                 
                 fid=fopen('stage5imag.coe','wt');
                 fprintf(fid,'memory_initialization_radix=16;\n');
                 fprintf(fid,'memory_initialization_vector=\n');
 
                 for i=1:16
                         for j=1:8
                             fprintf(fid,'%c',stage5imhex(i,j));
                         end
 
                         if(i==16)
                             fprintf(fid,';\n');
                         else
                             fprintf(fid, ',\n');
                         end
                 end
 
                 fclose(fid);
                 
                 
                 
                 fid=fopen('stage6real.coe','wt');
                 fprintf(fid,'memory_initialization_radix=16;\n');
                 fprintf(fid,'memory_initialization_vector=\n');
 
                 for i=1:16
                         for j=1:8
                             fprintf(fid,'%c',stage6realhex(i,j));
                         end
 
                         if(i==16)
                             fprintf(fid,';\n');
                         else
                             fprintf(fid, ',\n');
                         end
                 end
 
                 fclose(fid);
                 
                 fid=fopen('stage6imag.coe','wt');
                 fprintf(fid,'memory_initialization_radix=16;\n');
                 fprintf(fid,'memory_initialization_vector=\n');
 
                 for i=1:16
                         for j=1:8
                             fprintf(fid,'%c',stage6imhex(i,j));
                         end
 
                         if(i==16)
                             fprintf(fid,';\n');
                         else
                             fprintf(fid, ',\n');
                         end
                 end
 
                 fclose(fid);
                 
                 
                 
                 fid=fopen('stage7real.coe','wt');
                 fprintf(fid,'memory_initialization_radix=16;\n');
                 fprintf(fid,'memory_initialization_vector=\n');
 
                 for i=1:16
                         for j=1:8
                             fprintf(fid,'%c',stage7realhex(i,j));
                         end
 
                         if(i==16)
                             fprintf(fid,';\n');
                         else
                             fprintf(fid, ',\n');
                         end
                 end
 
                 fclose(fid);
                 
                 fid=fopen('stage7imag.coe','wt');
                 fprintf(fid,'memory_initialization_radix=16;\n');
                 fprintf(fid,'memory_initialization_vector=\n');
 
                 for i=1:16
                         for j=1:8
                             fprintf(fid,'%c',stage7imhex(i,j));
                         end
 
                         if(i==16)
                             fprintf(fid,';\n');
                         else
                             fprintf(fid, ',\n');
                         end
                 end
 
                 fclose(fid);
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
    