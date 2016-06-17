% simulates the dynamic response of an RD for multiple sinusoidals
% of given spatial and temporal frequencies
%
function varargout = simulateMultiSinusoidal(args)

duration = 5; % seconds

fps = 85; % Hz

spatialReso = 0.01; % degs

sep = 1; acAngle = 2.5; % degs

conds = [8, 0.1; 8 0.01]; % each row is [tf, sf] in [Hz, cpd]

[hpf, lpf] = getMantisTemporalFilters();

makePlot = ~nargout;

%% load overrides

if nargin, unpackStruct(args); end

%% calculations

frames = round(duration * fps);

sigma = acAngle / 2.34;

[~, imp] = genGaussian(sigma, spatialReso);

%% body

nconds = size(conds, 1);

ys = nan(nconds, frames);

for i=1:nconds
    
    c = conds(i, :); tf = c(1); sf = c(2);
    
    speed = tf/sf;
    
    t = (1:frames) / fps;
    
    pos = t*speed;
    
    pos1 = 1 + round(pos/spatialReso);
    pos2 = 1 + round((pos + sep)/spatialReso);
    
    sExtent = max(pos2);
    
    degs = (1:sExtent) * spatialReso;
    
    s = sin(2*pi*degs*sf);
    
    s2 = conv(s, imp, 'same');
    
    sin1 = s2(pos1);
    sin2 = s2(pos2);
    
    ys(i, :) = simulateReichardt(sin1, sin2, hpf, lpf);
    
end

if makePlot

    plot(ys');
    
else
    
    varargout{1} = ys;
    
end

end