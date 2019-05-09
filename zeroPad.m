function [r] = zeroPad(vector,desiredLength)
%ZEROPAD Summary of this function goes here
r = [vector zeros(1,desiredLength-length(vector))];
end

