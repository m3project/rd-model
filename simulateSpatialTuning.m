function varargout = simulateSpatialTuning(args)

tf = 8;

n = 100; % number of spatial frequency points

sep = 1; acAngle = 2.5; % degs

duration = 0.5;

[hpf, lpf] = getMantisTemporalFilters();

%% load overrides

if nargin, unpackStruct(args); end

%% body

makePlot = ~nargout;

sfs = logspace2(1e-3, 1, n);

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
    
    varargout{1} = [sfs steadState];
    
    varargout{2} = fpref;
    
end

end