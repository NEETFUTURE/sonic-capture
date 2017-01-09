for i=1:length(VarName1)
    if VarName1(i) > 32767
        Var(i) = VarName1(i) - 65535;
    else
        Var(i) = VarName1(i);
    end
end



%%
R = [1;0;1;0;1;1];
m = mseq(R);
m = vertcat(m,zeros(1000,1));

%%
F = 70;
fs = 52428;
per_tip = 1;
wave_num = length(m) * per_tip;
wave_S = zeros(fs,1);


%%
for i = 1:fs
    t = (i-1)/fs;
    wave_S(i) = sin(2*pi*t*F)*m(fix(t*F/per_tip)+1);
    last_fix = fix(t*F/per_tip)+1;
end
plot(wave_S);

 
%%
wave_D = zeros(fs,1);
for i=1:length(wave_S)
    if wave_S(i) < 0
        wave_D(i) =  (65535/2)*(wave_S(i)+2);
    else
        wave_D(i) =  (65535/2)*wave_S(i);
    end
end
wave_D = uint16(wave_D);
dlmwrite('myFile3.txt',wave_D,'delimiter','\n','newline','pc')