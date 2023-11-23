function ResultMaps=GenerateAMARESmapsMasked(AMARESoutput)
% Dunction to generate matabolite maps.

% Only AMARES cell input is needed.
% Number of metabolites are not important but the number assigned to
% metabolite(same order from AMARES) needed to be know by the user to show
% the map for that metabolite(Example: Choline = 3)

% Ayhan Gursan, UMC Utrecht 2021
% a.gursan@umcutrecht.nl

% AMARESmatrix=cell2mat(AMARESoutput);
maskedelements=find(~cellfun(@isempty,AMARESoutput));
Amp_map=zeros(numel(AMARESoutput),size(AMARESoutput{maskedelements(1)}.amplitude,2)); % Metabolite amplitude
LW_map=zeros(numel(AMARESoutput),size(AMARESoutput{maskedelements(1)}.linewidth,2)); % Metabolite linewidth
ChemShift_map=zeros(numel(AMARESoutput),size(AMARESoutput{maskedelements(1)}.chemShift,2)); % Metabolite chemical shift
Phase_map=zeros(numel(AMARESoutput),size(AMARESoutput{maskedelements(1)}.phase,2)); % Metabolite phase

for m=1:numel(maskedelements)
    m=maskedelements(m);
    Amp_map(m,:)=AMARESoutput{m}.amplitude;
    LW_map(m,:)=AMARESoutput{m}.linewidth;
    ChemShift_map(m,:)=AMARESoutput{m}.chemShift;
    Phase_map(m,:)=AMARESoutput{m}.phase(1);  
end

ResultMaps.Amplitude=reshape(Amp_map,[size(AMARESoutput) size(AMARESoutput{maskedelements(1)}.amplitude,2)]);
ResultMaps.Linewidth=reshape(LW_map,[size(AMARESoutput) size(AMARESoutput{maskedelements(1)}.linewidth,2)]);
ResultMaps.ChemicalShift=reshape(ChemShift_map,[size(AMARESoutput) size(AMARESoutput{maskedelements(1)}.chemShift,2)]);
ResultMaps.Phase_map=reshape(Phase_map,[size(AMARESoutput) size(AMARESoutput{maskedelements(1)}.phase,2)]);
