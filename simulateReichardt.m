function [fullEnergy, energy1, energy2] = simulateReichardt(input1, input2, hpf, lpf)

% calculate half-phase opponent energy

energy1 = hpf(input1) .* lpf(input2);

energy2 = hpf(input2) .* lpf(input1);

% calculate full opponent energy

fullEnergy = energy1 - energy2;

end