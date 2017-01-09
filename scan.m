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

time_div = dlmread('data/AAAD0025.CSV',',',[3 1 3 1])*10;
c_fs =  10001/time_div;


for i=1:4
    wave_mic{i} = dlmread(sprintf('data/AAAD00%d.CSV',5+i*5),',',[30 1 10030 3]);
end


for i=1:4
    wave_r{i} = [osci_to_xcorr(wave_mic{i}(:,1),wave_S,time_div),osci_to_xcorr(wave_mic{i}(:,2),wave_S,time_div)];
    wave_r{i} = wave_r{i}(5000:end,:);
end

