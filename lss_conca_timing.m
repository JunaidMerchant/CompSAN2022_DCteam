function [design,trial_info] = conca_timing(TR)
% geneate timing files 
TR0 = [0;TR(:);TR(end)+10];
event = 0;
design =[];
trial_info = [];
for i = 2 : length(TR)+1
    % onset
    if (TR0(i) - TR0(i-1) > 1)
        onset = TR0(i);
    end
    if  (TR0(i+1) - TR0(i)) > 1 
        offset = TR0(i);
        event = event + 1;
        design = [design;[onset:offset]'];
        trial_info = [trial_info;event*ones(size([onset:offset]'))];
    end
end

