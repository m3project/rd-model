function [hpf, lpf] = getMantisTemporalFilters()

% assumes:
% - sampling frequency  = 85 Hz
% - tau_hpf = 40e-3
% - tau_lpf = 13e-3

% hard coded values for mantis
hpf_B = [0.87098     -0.87098];
hpf_A = [1     -0.74197];
lpf_B = [0.32711      0.32711];
lpf_A = [1     -0.34578];

hpf = @hpf_fun;
lpf = @lpf_fun;

    function y = hpf_fun(x)

        y =  filter(hpf_B, hpf_A, x);

    end

    function y = lpf_fun(x)
    
       y = filter(lpf_B, lpf_A, x);
        
    end

end