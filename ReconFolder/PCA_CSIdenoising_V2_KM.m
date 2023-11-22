function denoisedCSI_spec=PCA_CSIdenoising_V2_KM(spec_data,patch_size,Parameters)
%% PCA based denoising of CSI data
% Eliminate eigenvalues fitting marchenko pasteur distrubition

% Calculate eigenvalues for each patch. Eigen values coming from noise should represent a
% Marchenko-Pastur distribution. Calculate threshold and set eigen values
% below this threshold to zero. Same approach Martijn Froeling used.
%%
disp('Starting PCA based denoising.')
disp(strcat('Patch size:',num2str(patch_size)))

NP=size(spec_data,1);
extended_data=repmat(spec_data,[1 3 3 3]);
N1 = Parameters.CSIdims(1);
N2 = Parameters.CSIdims(2);
N3 = Parameters.CSIdims(3);
denoisedCSI_spec=zeros(NP,N1,N2,N3);

n=patch_size^3;

% Denoise by elimination eigenvalues equal/below noise eigenvalues

% data_temp = zeros(NP,patch_size^3); For loop structure
% data_temp = zeros(NP,patch_size,patch_size,patch_size);

for mm=1:prod(Parameters.CSIdims)
    
    [Grid_row,Grid_col,Grid_slice]=ind2sub([N1 N2 N3],mm);
    %Optimized by KM-Start
%                 for m=1:n %For loop structure
%                     [row,col,slice]=ind2sub([patch_size patch_size patch_size],m);
%                     data_temp(:,m) = extended_data(:,Grid_row+row+(N1-ceil(patch_size/2)),Grid_col+col+(N2-ceil(patch_size/2)),Grid_slice+slice+(N3-ceil(patch_size/2)));
%                 end

%Works faster with logical index operatos. Difficult to read but works
%faster for matlab.
    data_temp= reshape(extended_data(:,(Grid_row+N1-ceil(patch_size/2))<1:3*N1 & 1:3*N1<(Grid_row+N1+ceil(patch_size/2)),(Grid_col+N2-ceil(patch_size/2))<1:3*N2 & 1:3*N2<(Grid_col+N2+ceil(patch_size/2)),(Grid_slice+N3-ceil(patch_size/2))<1:3*N3 & 1:3*N3<(Grid_slice+N3+ceil(patch_size/2))),[NP n]);
    signalpatch = cat(1,real(data_temp),imag(data_temp)).';
    %Optimized by KM-Finish
    
    denoisedpatch=DenoiseMatrix_V2(signalpatch).';
    denoisedCSI_spec(:,Grid_row,Grid_col,Grid_slice)=complex(denoisedpatch(1:NP,ceil(n/2)),denoisedpatch(NP+1:end,ceil(n/2)));
end

disp('Finished PCA based denoising.')
end
