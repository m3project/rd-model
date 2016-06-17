function varargout = simulateSpatioTemporalTuning(args)

sep = 1; acAngle = 2.5; % degs

duration = 4;

n = 80;

nContours = 10;

sfs = logspace2(1e-3, 1, n);

tfs = logspace2(1e-1, 40, n);

[hpf, lpf] = getMantisTemporalFilters();

%% load overrides

if nargin, unpackStruct(args); end

%% body

makePlot = ~nargout;

conds = createTrial(tfs, sfs);

conds = sortrows(conds);

args = struct('conds', conds, 'sep', sep, 'acAngle', acAngle, ...
    'hpf', hpf, 'lpf', lpf, 'duration', duration, 'spatialReso', 0.1);

ys = simulateMultiSinusoidal(args);

steadyState = mean(ys, 2);

steadyState = steadyState / max(steadyState);

B = reshape(steadyState, [length(sfs) length(tfs)]);

con = getContours(sfs, tfs, B, nContours);

if makePlot
    
    clf; hold on
    
    c1 = [0.99 0 0];
    c2 = [1 1 1];
    
    for i=1:nContours
        
        a = i/(nContours+1);
        
        col = c1 * a + c2 * (1-a);
    
        plot(con{i}.data(:, 1), con{i}.data(:, 2), 'color', col);
    
    end
    
    xlabel('Spatial Frequency (cpd)');
    
    ylabel('Temporal Frequency (Hz)');
    
    axis xy
    
    grid on; box on;
  
end

if nargout; varargout{1} = con; end

end

function con = getContours(sfs, tfs, B, nContours)

D = contourc(sfs, tfs, B', nContours);

D = D';

i = 1;

con = {};

while i < size(D, 1)
    
    c.level = D(i, 1);
    
    c.npoints = D(i, 2) + 1;
    
    c.data = D(i+1:i+c.npoints-1, :);
    
    con{end+1} = c; %#ok<AGROW>
    
    i = i + c.npoints;
    
end

end