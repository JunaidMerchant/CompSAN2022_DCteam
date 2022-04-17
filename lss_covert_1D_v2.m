% create 1D timing files for top 5 subjects
% as well as csv files for four nuisance regressors (consider convolving nuisance reg with
% HRF)
% OX 03/21/22
% clear
tbl = readtable('TimeByActorCharacteristics_long.csv');
tbl.actor = regexprep(tbl.actor, ' ', '_');
character = tabulate(tbl.actor);
[a,idx] = sort(cell2mat(character(:,3)),'descend');
top_chars =  character(idx(1:5),1);
tbl.time_stamp = round(tbl.time_stamp/2*100);
nTR = 1364*100; % multiple by 100 for better accuracy
for i = 1 : 5 % top 5 characters 
    idx = strcmp(tbl.actor,top_chars{i});
    TR = tbl.time_stamp(idx);
    [design{i},trial_info{i}] = conca_timing_v2(TR);
end
% make sure no 2 characters appear simultaneously 
d = tabulate(vertcat(design{:}));
multiple_char = d(find(d(:,2)>1),1); % TRs with multiple characters
for i = 1 : length(multiple_char)
    for j = 1 : length(design)
        idx = find(design{j}==multiple_char(i));
        if ~isempty(idx)
            design{j}(idx) = [];
            trial_info{j}(idx) = [];
        end
    end
end
% get onset of TRs and duration and generate 1D file per Andy's example
% http://andysbrainblog.blogspot.com/2012/06/duration-modulation-in-afni.html
for i = 1 : 5
    event = unique(trial_info{i});
    nevent = length(event);
    onset = zeros(nevent,1);
    duration = zeros(nevent,1);
    for j = 1 : nevent
        onset(j) = design{i}(find(trial_info{i}==event(j),1,'first'));
        offset = design{i}(find(trial_info{i}==event(j),1,'last'));
        duration(j) = offset - onset(j) + 10;
    end
    fid = fopen([top_chars{i} '.1D'],'w');
    fprintf(fid,'%.2f:%.2f ',[onset duration]'/100);
    fclose(fid);
end

% output face area pct, sharpness, brightness, and confidence as nuisance regressor
nTR = 1364;
nuisance = zeros(nTR,5);
tbl = readtable('AllFaces_long.xlsx');
tbl.time_stamp = round(tbl.time_stamp/2);
for i = 1 : nTR
    idx = find(tbl.time_stamp==i);
    if ~isempty(idx)
        nuisance(i,1) = mean(tbl.area_percent(idx));
        nuisance(i,2) = mean(tbl.sharpness(idx));
        nuisance(i,3) = mean(tbl.brightness(idx));
        nuisance(i,4) = mean(tbl.confidence(idx));
        nuisance(i,5) = 1;
    end
end
nuisance0 = downsample(nuisance,100);
nuisance_reg = array2table(nuisance,'VariableNames',{'area_pct','sharpness','brightness','confidence','face'});
writetable(nuisance_reg,'nuisance_reg.csv')