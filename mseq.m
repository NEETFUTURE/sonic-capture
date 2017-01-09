function [ B ] = mseq( R )
% �����l�̗�R������A1,10 ��M�n��B��Ԃ��֐�
N = 1;
M = length(R);
 
nP = 2^M-1;
B = zeros(nP*1, 1);
 
% ����
for iP = 1:nP*1
    R = [xor(R(N),R(end)); R(1:end-1)];
    if R(1) == 0
        B(iP) = -1;
    else
        B(iP) = 1;
    end
end
 
end