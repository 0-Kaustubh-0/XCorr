% Function to prepare the signals for cross-correlation
function [sig1, sig2] = modifySignals(sig1, sig2, dsFactor,trim)
% Function to modify signals towards perfroming cross correlation, this
% function will help trim the signals to the correct length for
% cross-correlation to occur:
% The signals have the option avialble for:
% - Truncation 
% - Downsampling
% Inputs:
%   sig1, sig2      - Two input signal(s) for cross-correlation
%   dsFactor        - Downsampling factor   [default = 1x ]
%   trim            - Trim to length        [default = lowest samples from either input signal ]
% Outputs:
%   sig1, sig2      - Modified signals

    % Check for inputs
    if nargin < 1
        error('Invalid input')
    elseif nargin < 2
        disp("Enter a minimum of 2 signal arrays for modification")
    elseif nargin < 3
        trim = 1;
        disp("No modifications applied")
        dsFactor = 1;
    elseif nargin < 4
        trim = 1;
        minLength = min(length(sig1),length(sig2));
        disp(['Trimming to a least length of: ' num2str(minLength)])
    end
    
    if trim
        if size(sig1,1) > size(sig1,2)
            sig1 = sig1';
            sig2 = sig2';
        end
        sig1 = sig1(:,1:minLength);
        sig2 = sig2(:,1:minLength)
    else
        warning('Signal trimming disabled. Cross-wavelet may not function as intended')
    end
    
    % Downsample the signals if required (for plotting the regression)
    if dsFactor
        sig1 = downsample(sig1, dsFactor);
        sig2 = downsample(sig2, dsFactor);
        disp(['Downsampled by ' nu2mstr(dsFactor) 'x'])
    else
        disp('No downsampling done.')
    end
end