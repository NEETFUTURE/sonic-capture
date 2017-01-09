for i=1:4
    subplot(4,1,i);
    plot(wave_r{i}(:,1))
    xlim([2000 5800])
end
figure
for i=1:4
    subplot(4,1,i);
    plot(wave_r{i}(:,2))
    xlim([2000 5800])
end
figure
for i=1:4
    subplot(4,1,i);
    plot(wave_mic{i}(:,3))
end