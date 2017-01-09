W = 0.6;
H = W*(240/320);
d = W/320;
y_ax = 0:d:H-d;
x_ax = 0:d:W-d;


fs = 10001/5e-3;%

v = 340;

s = [0.10,0.15,0.20,0.25,0.30];
speaker = [-0.05,W/2];

B_data = zeros(240,320);

for i=1:320
    for j=1:240
        ten = [j*d,i*d];
        spk_tar = norm(speaker - ten);
        for k=1:4
            leftMic_tar = norm([0,-s(k)+0.3] -ten);
            t = (spk_tar+leftMic_tar)/v;
            left_wave = wave_r{k}(:,1);
            B_data(j,i) = B_data(j,i) + left_wave(fix(t*fs));

            rightMic_tar = norm([0,+s(k)+0.3] -ten);
            t = (spk_tar+rightMic_tar)/v;
            right_wave = wave_r{k}(:,2);
            B_data(j,i) = B_data(j,i) + right_wave(fix(t*fs));
        end
    end
end
