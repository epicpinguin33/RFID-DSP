classdef systemBlock
    %SYSTEMBLOCK Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        response;
        inputSignal;
        outputSignal;
    end
    
    methods
        function obj = systemBlock(response,inputSignal,outputSignal)
            %SYSTEMBLOCK Construct an instance of this class
            %   Detailed explanation goes here
            obj.response = response;
            if nargin()>1
                obj.inputSignal = inputSignal;
                if nargin()>2
                    obj.outputSignal = outputSignal;
                end
            end
        end
        
        function r = gOutput(obj,inputArg,sampleRate)
            r = signal(conv(inputArg.gAbs(),obj.response),sampleRate);
            assignin('base','test',r)
        end
        
% set functions
        function obj = setInputSignal(obj,inputArg)
            obj.inputSignal = inputArg;
        end
        
        function obj = setOutputSignal(obj,inputArg)
            obj.outputSignal = inputArg;
        end
        
%get functions
        function r = gResponse(obj)
            r = obj.response;
        end
        
        function r = gFFT(obj)
            r = fft(obj.gResponse);
        end
        
    end
end

