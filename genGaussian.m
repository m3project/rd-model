function [gauss, imp, x] = genGaussian(sigma, reso, extentSigmas)

if nargin<3, extentSigmas = 6; end

d = sigma * extentSigmas/2;

x = -d : reso : d; % degrees

imp = exp(-(x.^2)/(2*sigma^2));

imp = imp / sum(imp);

gauss = @gauss_f;

    function y = gauss_f(x)
       
        y = conv(x, imp, 'same');
        
    end

end