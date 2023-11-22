function ResultMaps=GenerateAMARESmaps(AMARESoutput)
% Dunction to generate matabolite maps.

% Only AMARES cell input is needed.
% Number of metabolites are not important but the number assigned to
% metabolite(same order from AMARES) needed to be know by the user to show
% the map for that metabolite(Example: Choline = 3)

% Ayhan Gursan, UMC Utrecht 2021
% a.gursan@umcutrecht.nl

AMARESmatrix=cell2mat(AMARESoutput);

Amp_map=zeros(numel(AMARESmatrix),size(AMARESmatrix(1).amplitude,2)); % Metabolite amplitude
LW_map=zeros(numel(AMARESmatrix),size(AMARESmatrix(1).amplitude,2)); % Metabolite linewidth
ChemShift_map=zeros(numel(AMARESmatrix),size(AMARESmatrix(1).amplitude,2)); % Metabolite chemical shift
Phase_map=zeros(numel(AMARESmatrix),size(AMARESmatrix(1).amplitude,2)); % Metabolite phase

for m=1:numel(AMARESmatrix)
    Amp_map(m,:)=AMARESmatrix(m).amplitude;
    LW_map(m,:)=AMARESmatrix(m).linewidth;
    ChemShift_map(m,:)=AMARESmatrix(m).chemShift;
    Phase_map(m,:)=AMARESmatrix(m).phase(1);
    
end

ResultMaps.Amplitude=reshape(Amp_map,[size(AMARESmatrix) size(AMARESmatrix(1).amplitude,2)]);
ResultMaps.Linewidth=reshape(LW_map,[size(AMARESmatrix) size(AMARESmatrix(1).amplitude,2)]);
ResultMaps.ChemicalShift=reshape(ChemShift_map,[size(AMARESmatrix) size(AMARESmatrix(1).amplitude,2)]);
ResultMaps.Phase_map=reshape(Phase_map,[size(AMARESmatrix) size(AMARESmatrix(1).amplitude,2)]);
