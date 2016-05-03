% fs : sampling frequency (Hz)
% tau_hpf : high pass filter time constant (sec)
% tau_lpf : low pass filter time constant (sec)
%
function [hpf, lpf] = genTemporalFilters(fs, tau_hpf, tau_lpf)

if nargin<1, fs = 85; end

if nargin<3
   
    % time constants for the praying mantis
    tau_hpf = 40e-3;
    tau_lpf = 13e-3;

end

hfc = 1/(2*pi*tau_hpf); % HPF cutoff frequency (Hz)
lfc = 1/(2*pi*tau_lpf); % LPF cutoff frequency (Hz)

[hpf_B, hpf_A] = butter(1, hfc/(fs/2), 'high');
[lpf_B, lpf_A] = butter(1, lfc/(fs/2), 'low');

hpf = @hpf_fun;
lpf = @lpf_fun;

    function y = hpf_fun(x)

        y =  filter(hpf_B, hpf_A, x);

    end

    function y = lpf_fun(x)
    
       y = filter(lpf_B, lpf_A, x);
        
    end

end