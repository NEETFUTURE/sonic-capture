function [ B ] = mseq( R )
% 初期値の列Rを受取り、1,10 のM系列Bを返す関数
N = 1;
M = length(R);
 
nP = 2^M-1;
B = zeros(nP*1, 1);
 
% 生成
for iP = 1:nP*1
    R = [xor(R(N),R(end)); R(1:end-1)];
    if R(1) == 0
        B(iP) = -1;
    else
        B(iP) = 1;
    end
end
 
end