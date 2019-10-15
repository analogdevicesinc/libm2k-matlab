classdef libm2kTests < matlab.unittest.TestCase
    
    properties
        root = '';
    end
    
    methods(TestClassSetup)
        function addpaths(testCase)
            here = mfilename('fullpath');
            here = strsplit(here,'/');
            here = fullfile('/',here{1:end-1});
            testCase.root = here;
            addpath(genpath(fullfile(here,'libm2k')));
        end
    end
    
    methods(Test)
        function checkConnectivity(~)
            m2k = clib.libm2k.libm2k.devices.m2kOpen();
            if isempty(m2k)
                error('No M2K found');
            end
        end
        function testDigital(~)
            m2k = clib.libm2k.libm2k.devices.m2kOpen();
            dig = m2k.getDigital();
            dig.setSampleRateIn(100000);
            dig.setSampleRateOut(100000);
        end
    end
    
end
