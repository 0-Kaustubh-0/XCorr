% Function to process all signal data and create INS graphs
function [crossWT, crossWTReverse] = computeCWT(signal1, signal2,fs, createPlots)
%     signal1       - Signal stack 1 (nSignals, N)
%     signal2       - Signal stack 2 (nSignals, N)
%     fs            - (double) Sampling frequency
%     createPlots   - (string) Create XCorr | CWT | XWT plots
    
    % Intitialize iterable
    l = 0
    
    % Loop through signal stacks ***** NOTE : Signal stacks are row vectors *****
    for j = 1: size(signal1, 1)
        for k = 1: size(signal2,1)
            % Compute CWT
            cwtM = cwt(signal1,fs);
            [cwtL, fVec] = cwt(signal2,fs);

            % Compute reverse cross-wavelet (for granger causality analysis)
            crossWTReverse(l,:,:) = cwtL.*conj(cwtM)

            % ******** Do a cross wavelet transform on both the signals: (formula based) *********
            crossWT(l,:,:) = cwtM.*conj(cwtL);
            % ******************************************

            % Create plots based on the option given
            if createPlots == 'CWT' || createPlots == "cwt"
                % Plot the continuoues wavelet transform
                figure(1)
                cwt(signal1(j,:),fs);
                title(['Musician ' num2str(j)])
                figure(2)
                cwt(signal2(k,:),fs);
                title(['Listener ' num2str(j)])
                pause
            elseif createPlots == 'XCorr' || createPlots == "xcorr"
                % Plot cross-wavelet coherence plot
                figure(3)
                image("XData",t,"YData",fVec,"CData",abs(squeeze(crossWT(l,:,:))),"CDataMapping","scaled")
                xlabel('Time [mins]')
                ylabel('Frequency')
                title(['Cross-correlation of listener and musician combination ' num2str(l)])
                pause
            elseif createPlots == "XWT" || createPlots == "xwt"
                % Plot the XWT from Geophysics group
                figure(4)
                xwt(list1(j,:),list2(k,:),'ms',1024)
                pause    
            end
            
            % Update message for correlation index (display loop details) and tterables
            updateMsg(j,k,l)
            l = l+1;
        end
    end
end