%%
R = [1;0;1;0;1;1];
m = mseq(R);
m = vertcat(m,zeros(1000,1));

%%
F =70;
FG_FS = 57;
divide = 10;
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


for i = 1:fs
    t = (i-1)/fs;
    wave_S(i) = sin(2*pi*t*F)*m(fix(t*F/per_tip)+1);
    last_fix = fix(t*F/per_tip)+1;
end

time_div = dlmread('WAVE/AAAF0025.CSV',',',[3 1 3 1])*10;
c_fs =  10001/time_div;


for i=1:4
    wave_mic{i} = dlmread(sprintf('WAVE/AAAF00%d.CSV',5+i*5),',',[30 1 10030 3]);
end


for i=1:4
    wave_r{i} = [osci_to_xcorr(wave_mic{i}(:,1),wave_S,time_div,divide,FG_FS),osci_to_xcorr(wave_mic{i}(:,2),wave_S,time_div,divide,FG_FS)];
    wave_r{i} = wave_r{i}(6300:end,:);
end


%%

TATE = 1200;

W = 0.6;
H = W*(TATE/640);
d = W/640;
y_ax = 0:d:H-d;
x_ax = 0:d:W-d;

v = 340;

s = [0.10,0.15,0.20,0.25,0.30];
speaker = [-0.05,W/2];

B_data = zeros(TATE,640);
C_data = zeros(TATE,640,2);


for i=1:640
    for j=1:TATE
        ten = [j,i]*d;
        spk_tar = norm(speaker - ten);
        for k=1:4
            for z=1:2
                mic_tar = norm([0,fix((z-1.5)*2)*s(k)+0.3] - ten);
                t = (spk_tar+mic_tar)/v;
                last=fix(t*c_fs);
                B_data(j,i) = B_data(j,i) + wave_r{k}(fix(t*c_fs),z);
                C_data(j,i,z) = fix(t*c_fs);
            end
        end
    end
end
figure;imagesc(x_ax,y_ax,B_data);