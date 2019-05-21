classdef systemBlock
    %SYSTEMBLOCK Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        response;
        inputSignal;
    end
    
    methods
        function obj = systemBlock(response,inputSignal)
            %SYSTEMBLOCK Construct an instance of this class
            %   Detailed explanation goes here
            obj.response = response;
            if nargin()>1
                obj.inputSignal = inputSignal;
            end
        end
        
        function r = gOutput(obj,inputSig,sampleRate)
            r = signal(conv(inputSig.gAbs(),obj.response),sampleRate);
%             assignin('base','test',r)
        end
        
% set functions
%         function obj = setInputSignal(obj,inputArg)
%             obj.inputSignal = inputArg;
%         end
%         
%         function obj = setOutputSignal(obj,inputArg)
%             obj.outputSignal = inputArg;
%         end
        
%get functions
        function r = gResponse(obj)
            r = obj.response;
        end
        
        function r = gFFT(obj)
            r = fft(obj.gResponse);
        end
        
    end
end

