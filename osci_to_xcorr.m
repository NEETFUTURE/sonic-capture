function [ output ] = osci_to_xcorr( osci_data,soft_wave,time_div ,divide,freq)

    osci_point = length(osci_data);
    fs1 = 52428;
    
    fs2 = fix(osci_point/(divide*freq*time_div))
    d_wave = zeros(fs2,1);
    
    for k=1:fs2
        d_wave(k) = soft_wave(fix(k*fs1/fs2));
    end

    xc = conv(hilbert(flipud(d_wave)),hilbert(osci_data));
    output = abs(hilbert(xc));

end
