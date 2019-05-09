classdef signal
    %SIGNAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        horizontal;
        vertical;
        timeAxis;
        sampleRate;
        origin;
        destination;
    end
    
    methods
        function obj = signal(vertical,sampleRate,horizontal)
            %SIGNAL Construct an instance of this class
            if nargin()>0
                obj.vertical = vertical;
                if nargin()>1
                    obj.sampleRate=sampleRate;
                    obj.timeAxis = linspace(0, length(vertical) / sampleRate,length(vertical));
                    if nargin()>2
                        obj.horizontal = horizontal;
                    end
                end    
            end
        end
        
% set functions
        function obj = setHorizontal(obj,inputArg)
          obj.horizontal = inputArg;
        end
        
        function obj = setVertical(obj,inputArg)
          obj.vertical = inputArg;
        end
        
        function obj = setTimeAxis(obj,inputArg)
            obj.timeAxis = inputArg;
        end
        
        function obj = setSignalPath(obj,origin,destination)
            obj.origin = origin;
            obj.destination = destination;
        end
        
% get functions
        function r = gHorizontal(obj)
            r = obj.horizontal;
        end
        
        function r = gVertical(obj)
            r = obj.vertical;
        end
        
        function r = gAbs(obj)
            if length(obj.horizontal)==length(obj.vertical)
                r = sqrt(obj.horizontal.^2+obj.vertical.^2);
            else
                r = obj.vertical;
            end
        end
        
        function r = gAng(obj)
            r = angle(obj.horizontal*1i+obj.vertical);
        end
        
        function r = gFFT(obj)
            r = fft(obj.gAbs);
        end
        
        function r = gTimeAxis(obj)
            r = obj.timeAxis;
        end
        
        function r = gSampleRate(obj)
            r = obj.sampleRate;
        end
    end
end

