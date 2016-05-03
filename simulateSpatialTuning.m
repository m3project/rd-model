function varargout = simulateSpatialTuning(args)

tf = 8;

sep = 1; acAngle = 2.5; % degs

duration = 0.5;

sfs = logspace2(1e-3, 1, 100);

[hpf, lpf] = getMantisTemporalFilters();

%% load overrides

if nargin, unpackStruct(args); end

%% body

makePlot = ~nargout;

conds = createTrial(tf, sfs);

args = struct('conds', conds, 'sep', sep, 'acAngle', acAngle, ...
    'hpf', hpf, 'lpf', lpf, 'duration', duration);

ys = simulateMultiSinusoidal(args);

steadyState = mean(ys, 2);

steadyState = steadyState / max(steadyState);

[~, ind] = max(steadyState);

fpref = sfs(ind);

%% output

if makePlot
    
    clf
    
    plot(sfs, steadyState);
    
    xlabel('Spatial Frequency (cpd)');
    
    title('RD Output');
    
    set(gca, 'xscale', 'log');
    
else
    
    varargout{1} = sfs;
    
    varargout{2} = steadyState;
    
    varargout{3} = fpref;
    
end

end