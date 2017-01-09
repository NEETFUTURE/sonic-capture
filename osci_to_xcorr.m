function [ output ] = osci_to_xcorr( osci_data,soft_wave,time_div ,divide,freq)
% �I�V���X�R�[�v�f�[�^�Ɠ��M�����g��ǂݍ��݁A���ݑ��ւ�Ԃ��֐�

    osci_time_div = time_div;  %�I�V���X�R�[�v��sec/window
    

%%
    pulse_per_sec = fix((40e3)/(freq*divide));  %FG�̐ݒ��g��
    osci_point = length(osci_data);  %�I�V���X�R�[�v�f�[�^�̕W�{�_��
    fs1 = 52428;  %Matlab�Ő�������M�����g�f�[�^�̕W�{�_��

%%
    fs2 = fix(osci_point/(divide*pulse_per_sec*osci_time_div));

    d_wave = zeros(fs2,1);

    for k=1:fs2
        d_wave(k) = soft_wave(fix(k*fs1/fs2));
    end

%%
    xc = conv(hilbert(flipud(d_wave)),hilbert(osci_data));
    output = abs(hilbert(xc));

end
