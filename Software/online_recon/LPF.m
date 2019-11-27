function [y]=LPF(y,o,cut)
%y:input signal
% o: order of the filter
% cut: cutoff frequency
x=fft(y);%fast fourier transform
size_y = size(x);
po=floor(size_y(1)/2);% cutting from left and right
for i=1:size_y(2)
    for j=(po-cut):(po+cut)
        x(j,i)=(x(j,i)/o);
    end;
end; 
f=x;
y=ifft(f,'symmetric');
end