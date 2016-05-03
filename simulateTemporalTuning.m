function varargout = simulateTemporalTuning(args)

sf = 0.1;

n = 100; % number of spatial frequency points

sep = 1; acAngle = 2.5; % degs

duration = 10;

[hpf, lpf] = getMantisTemporalFilters();

%% load overrides

if nargin, unpackStruct(args); end

%% body

makePlot = ~nargout;

tfs = logspace2(1e-1, 40, n);

conds = createTrial(tfs, sf);

args = struct('conds', conds, 'sep', sep, 'acAngle', acAngle, ...
    'hpf', hpf, 'lpf', lpf, 'duration', duration);

ys = simulateMultiSinusoidal(args);

steadyState = mean(ys, 2);

steadyState = steadyState / max(steadyState);

[~, ind] = max(steadyState);

fpref = tfs(ind);

%% output

if makePlot
    
    clf
    
    plot(tfs, steadyState);
    
    xlabel('Spatial Frequency (cpd)');
    
    title('RD Output');
    
    set(gca, 'xscale', 'log');
    
else
    
    varargout{1} = [tfs steadState];
    
    varargout{2} = fpref;
    
end

end