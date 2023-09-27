% Function to create plots for different figures
function plotThis(option, windows, sig1, sig2, meanNarrowbandCoherence)
    % Plot the figures
    
    switch lower(option)
        case {'boxplot','box'} % Box-plot on coherence values for all combinations
            figure(5)
            boxplot(meanNarrowbandCoherence')
            xlabel('Correlation index')
            ylabel('INS')
            title(['Mean Musician-Listener correlation between ' num2str(fVec(highBWIdx)) ': ' num2str(fVec(lowBWIdx)) 'Hz'])
    
        case {'line'} % All independant coherence trends over time-series
            figure(6)
            downFactor =25;
            sgtitle('Musician-listener INS combinations over time')
            for j = 1: size(allSignals,1)*size(allSignals,1)
                subplot(size(allSignals,1),size(allSignals,1),j)
                plot(downsample(t,downFactor),downsample(meanNarrowbandCoherence(j,:),downFactor))
                xlabel('Time [mins]')
                title(['Combination index:' num2str(j)])
            end
            
        case {'t-maps', 'tmap','tmaps'} % T-Maps for all coherence combinations
            h = figure(7);
            sgtitle('t-map of all signal combinations')
            timeAveragedMeanNarrowbandCoherence = mean(meanNarrowbandCoherence,2);
            coherenceCombinations = reshape(timeAveragedMeanNarrowbandCoherence, [size(sig1,1),size(sig2,1)]);
            for j =1:length(size(sig1,1))
                signalStack1(j,:) = ["Sig1_" num2str(j)];%#ok
            end
            for k =1:length(size(sig2,1))
                signalStack2(k,:) = ["Sig2_" num2str(k)];%#ok
            end            
            imagesc(coherenceCombinations)
            xticklabels(signalStack1)
            yticklabels(signalStack2)
            colormap(h,hot)
        
        case 'regression'
            % Plot the linear regression on scatter plot
            figure(8)
            meanNarrowbandCoherenceDS = mean(meanNarrowbandCoherence); % meanNarrowbandCoherenceDS - mean over all combinations 
            meanNarrowbandCoherenceSTDEV = std(meanNarrowbandCoherence);

            % Downsample ------------------ Because there are TOOO MANY data points
            % over time, other study with this graph had very few data points over
            % time
            downsampleFactor = 20;
            meanNarrowbandCoherenceDS = downsample(meanNarrowbandCoherenceDS,downsampleFactor);
            tDS = downsample(t,downsampleFactor);

            % Fit linear model for R-squared value
            fitvars = polyfit(tDS, meanNarrowbandCoherenceDS,1);
            lm1 = fitlm(tDS, meanNarrowbandCoherenceDS);
            RSq = lm1.Rsquared.Ordinary;

            % Compute 'grey' / stdev area
            line1 = fitvars(1)*tDS + fitvars(2) + downsample(meanNarrowbandCoherenceSTDEV, downsampleFactor);
            line2 = fitvars(1)*tDS + fitvars(2) - downsample(meanNarrowbandCoherenceSTDEV, downsampleFactor);

            % Plot grey
            x2 = [tDS, fliplr(tDS)];
            inBetween = [line1, fliplr(line2)];
            grayColor = [.7 .7 .7];
            fill(x2, inBetween, grayColor);
            hold on
            plot(tDS, line1 , 'w')  
            hold on
            plot(tDS, line2 , 'w')
            hold on

            % Scatter plot
            scatter(tDS, meanNarrowbandCoherenceDS, 'k','filled')
            hold on

            % Plot regression line
            plot(tDS,fitvars(1)*tDS + fitvars(2),'k')

            % Add R-squared value, details to graph
            text(.8*tDS(end),meanNarrowbandCoherenceDS(1), sprintf('R^{2} = %0.2f',RSq))
            xlabel('Time [s]')
            ylabel('INS score')
            title(['Regression model for INS change (heavily downsampled, by ' num2str(downsampleFactor) 'x)'])
            hold off
        otherwise 
            msgbox('Wrong option chosen! Select again.')
    end
end