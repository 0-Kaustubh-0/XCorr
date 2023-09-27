% Funciton to display update messages (correlation index corresponding to Listener/ Musician)
function updateMsg(j,k,l,stackSize1, stackSize2)
    if j==k
        disp('Auto-correlation instance: vv removing the following data combination vv')
    end

    if j < stackSize1
        cwtSig = 'Signal stack 1';
        cwtSigNo = j;
    else
        cwtSig = 'Signal stack 2';
        cwtSigNo = mod(j,stackSize1-1);
        if cwtSigNo == 0 
            cwtSigNo =1;
        end
    end
    if k < stackSize2
        disp(['CWT correlation index ' num2str(l) ':: ' cwtSig ':' num2str(cwtSigNo) ', Signal stack 2:' num2str(k)])
    else
        conjSigNo= mod(k,stackSize2-1);
        if conjSigNo == 0
            conjSigNo = 1;
        end
        disp(['CWT correlation index ' num2str(l) ':: ' cwtSig ':' num2str(cwtSigNo) ', Signal stack 1:' num2str(conjSigNo)])
    end
end