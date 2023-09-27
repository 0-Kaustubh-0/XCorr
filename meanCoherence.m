% Function to generate mean Coherence
function [meanNarrowbandCoherence, narrowbandCoherencePhase, meanNarrowBandCoherenceBlocks] =   meanCoherence(crossWT, crossWTReverse,fVec,t,BandwidthOfInterest,...
                                                                                                shouldNormalize, shouldLog, NWindows)
%     crossWT                 - Cross-wavelet data for all many-many:: sig1-sig2 combinations
%     crossWTReverse          - Reverse cross-wavelet data for all many-many:: sig2-sig1 combinations *** (In order with sig1-sig2) ***
%     fVec                    - Frequency vector
%     t                       - Time vector
%     BandwidthOfInterest     - Bandwidth of interest for finding correlation ** Important to observe with
%     shouldNormalize         - Choose to normalize: Normalize the mean coherence to the maximum correlation value
%     shouldLog               - Log transform the data if skewed
%     NWindows)               - Number of windows
    
    if nargin < 8
        continue
    end
    % Feature: Set the freqeuncy bin for finding average coherence
    [~,lowBWIdx] = min(abs(fVec-BandwidthOfInterest(1)));
    [~,highBWIdx] = min(abs(fVec-BandwidthOfInterest(2)));
    
    % Isolate the coherent wavelet within this bandwidth (highBWIdx:lowBWIdx :: fVec is in decreasing order)
    narrowbandCoherence = abs(crossWT(:,highBWIdx:lowBWIdx,:)); 
    narrowbandCoherencePhase = angle(crossWT(:,highBWIdx:lowBWIdx,:)) % Phase differences for the sig1-to-sig2 stack
    
    % Compute MEAN coherence over the bandwidth acquired for
    meanNarrowbandCoherence = squeeze(mean(narrowbandCoherence, 2)); % Take mean across bandwidth, reduce the dimension
    narrowbandCoherenceReverse = abs(crossWTReverse(:,highBWIdx:lowBWIdx,:)); 
    meanNarrowbandCoherenceReverse = squeeze(mean(narrowbandCoherenceReverse, 2));

    % Extra Feature: Compute the average coherence over windowed blocks
    if nargin < 8
        NWindows = []; % Set the number of windows for the signal
    else
        blockLength = floor(length(meanNarrowbandCoherence)/NWindows);
        for m = 1:size(meanNarrowbandCoherence,1)
            for n = 1:NWindows
                if n == 1
                    meanNarrowBandCoherenceBlocks(m,n,:) = meanNarrowbandCoherence(m,1:blockLength);
                else
                    meanNarrowBandCoherenceBlocks(m,n,:) = meanNarrowbandCoherence(m,blockLength*(n-1)+1:blockLength);
                end
            end
        end
    end
    
    % Transform coherence values
    if (shouldNormalize)
        disp('Normalizing data')
        meanNarrowbandCoherence = meanNarrowbandCoherence./max(max(meanNarrowbandCoherence));
        if (shouldLog)
            disp('Log transforming data')
            meanNarrowbandCoherence = abs(log(meanNarrowbandCoherence));
        end
    end
end