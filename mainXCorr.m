%% Select the signals to send
function mainXCorr(sig1, sig2, fs)
    % Example function
    
    % Prepare the signals for X-correlation    
    [sig1, sig2] = modifySignals(sig1, ...      % Raw signal data stack/ singular
                                 sig2, ...      % Raw signal data stack/ singular
                                 dsFactor,...   % (double) Downsampling factor
                                 trim);          % (double) Trimming length (signal should have same number of samples)
    % ***** NOTE : Signal stacks sig1, sig2 are returned as row vectors *****
    
    % Set Options
    createPlots = 1; % Create plots for CWT
    shouldNormalize = 1;% Normalize the data
    shouldLog = 1;% Log transform the data
    
    % Compute CWT with signal stacks: signal1, signal2 
    [crossWT, crossWTReverse, fVec] =   computeCWT(signal1, ... % Signal stack 1 (nSignals, N)
                                        signal2, ...            % Signal stack 2 (nSignals, N)
                                        fs,...                  % (double) Sampling frequency
                                        createPlots);           % (string) Create XCorr | CWT | XWT plots
    
    % Run the analysis on the crossWT
    [meanNarrowbandCoherence, ...
        narrowbandCoherencePhase, meanNarrowBandCoherenceBlocks] =  meanCoherence(crossWT, ...  % Cross-wavelet data for all many-many:: sig1-sig2 combinations
                                                                    crossWTReverse, ...         % Reverse cross-wavelet data for all many-many:: sig2-sig1 combinations *** (In order with sig1-sig2) ***
                                                                    fVec, ...                   % Frequency vector
                                                                    t, ...                      % Time vector
                                                                    BandwidthOfInterest,...     % Bandwidth of interest for finding correlation ** Important to observe with
                                                                    shouldNormalize, ...        % Choose to normalize: Normalize the mean coherence to the maximum correlation value
                                                                    shouldLog, ...              % Log transform the data if skewed
                                                                    NWindows);                  % Number of windows
                                                              
    % Plot selected graphs, options:
    %   - Boxplot
    %   - Line plot for each correlation
    %   - t-maps/ heatmaps
    %   - regression analysis (R-Squared with ROC plots)
    plotThis(option, ...                % Option to select the plot to create:
             sig1, ...                  % signal stack 1
             sig2, ...                  % signal stack 2
             meanNarrowbandCoherence);  % mean coherence values over specified bandwidth
     
    % Plots for windowed data depend on user need: plot for coherence between sig1 and sig 2 stacks by:
    % - signal window
    % - correlation between windows
    % - 
    
end

% Auto-regression model
% varm fucntion
% for j = 1:9
%     ARm(j,:) = varm(meanNarrowbandCoherence(j,:));
% end

% Run Granger analysis 
% function gctest
% h = gctest(meanNarrowbandCoherence(1,:), meanNarrowbandCoherenceReverse(1,:));