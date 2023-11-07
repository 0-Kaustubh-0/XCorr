# Introduction

This is a `MATLAB` project that is meant to compute the [Wavelet cross-correlation][1] between two physiological signals and generate apporpriate metrics extracted from [fNIRS][2] data (its application is **NOT** limited to fNIRS data). [This article][3] describes the complete methodology utilizing the *Wavelet Cross-correlation technique* to compute the neural synchronization between several Musicians and Listeners.

> While the project is geared towards analyzing fNIRS data, you can still utilize the same function to compute the cross-correlation as well extract metrics relevant to your own data. 


## Dependencies

This project works solely on `MATLAB` and requires the following toolboxes to be installed:

* Signal Processing Toolbox
* Wavelet toolbox
* Economterics toolbox (for Granger-Causality test) 

> If you are using the **Software OpenGL** rendering for `MATLAB`, then you'll need to utlize the [silent installation][4] process in order to install relevant packages.


## Usage

While there is a function available for computing the Cross-correlation there are several other functions for utilizing this generated data to observe coehrence between multiple time-series.

Avaialble functions: 

* modifySignals()               - Trim and prepare the signals for X-correlation  
* computeCWT()                  - Compute CWT with signal stacks
* meanCoherence()               - Extract coherence metrics over bandwidth of interest
* plotThis()                    - Create plots with options
* main.m - Main MATLAB function loading the data and calling all other functions


#### Prepare the signals for X-correlation : modifySignals() 


    sig1,                       - Raw signal data stack/ singular
    sig2,                       - Raw signal data stack/ singular
    dsFactor,                   - (double) Downsampling factor
    trim                        - (double) Trimming length (signal should have same number of samples)

> NOTE : Signal stacks sig1, sig2 are returned as row vectors


#### Set Options

    createPlots = 1;            - Create plots for CWT
    shouldNormalize = 1;        - Normalize the data
    shouldLog = 1;              - Log transform the data


#### Compute CWT with signal stacks: signal1, signal2: computeCWT()

    signal1,                    - Signal stack 1 (nSignals, N)
    signal2,                    - Signal stack 2 (nSignals, N)
    fs,                         - (double) Sampling frequency
    createPlots                 - (string) Create XCorr | CWT | XWT plots


#### Extract coherence metrics over bandwidth of interest: meanCoherence()

    crossWT,                    - Cross-wavelet data for all many-many:: sig1-sig2 combinations
    crossWTReverse,             - Reverse cross-wavelet data for all many-many:: sig2-sig1 combinations *** (In order with sig1-sig2) ***
    fVec,                       - Frequency vector
    t,                          - Time vector
    BandwidthOfInterest,        - Bandwidth of interest for finding correlation ** Important to observe with
    shouldNormalize,            - Choose to normalize: Normalize the mean coherence to the maximum correlation value
    shouldLog,                  - Log transform the data if skewed
    NWindows                    - Number of windows


#### Plot selected graphs, options:plotThis()

   * Boxplot
   * Line plot for each correlation
   * t-maps/ heatmaps
   * regression analysis (R-Squared with ROC plots)

    option,                     - Option to select the plot to create:
    sig1,                       - signal stack 1
    sig2,                       - signal stack 2
    meanNarrowbandCoherence     - mean coherence values over specified bandwidth


#### Plots for windowed data depend on user need: plot for coherence between sig1 and sig 2 stacks by:

     - signal window
     - correlation between windows 


## Citation

This project is available under the Creative Commons license. If you utilize either the code or the refernce article for the same, please mention the respective source in your submission. 


[1]: https://pubmed.ncbi.nlm.nih.gov/16110773/
[2]: https://www.frontiersin.org/articles/10.3389/fnins.2020.00724/full
[3]: https://0-kaustubh-0.github.io/posts/Project-5_XWCorr/
[4]: https://www.mathworks.com/help/install/ug/install-noninteractively-silent-installation.html
