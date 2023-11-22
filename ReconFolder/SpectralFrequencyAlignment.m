function [AlignedSpectra, loc]=SpectralFrequencyAlignment(Spectra,xaxis,Param,Referenceloc)
AlignedSpectra=zeros(size(Spectra));
% Define a range for water signal -> [-1.5 1.5] ppm
lowerend=0.2;%4.2
upperend=15.4;%15.4
water_range=find((xaxis > lowerend) & (xaxis < upperend));
disp(strcat('Water range for aligning spectra is ',num2str(lowerend),' to ',num2str(upperend),' ppm.'))
if Referenceloc==0
    disp('No reference given from perivous scan. Aligning the spectra per voxel base.' )
    
    [~, loc]=max(real(Spectra(water_range,:)),[],1);
    loc=loc+water_range(1)-1;
    Frequencyshift=xaxis(loc);
    
    for m=1:prod(Param.CSIdims)
        AlignedSpectra(:,m) = (interp1(xaxis, Spectra(:,m), xaxis-4.7+Frequencyshift(m))).';
    end
    AlignedSpectra(isnan(AlignedSpectra))=0;
    AlignedSpectra=reshape(AlignedSpectra,size(Spectra));
    loc=Frequencyshift;
else
    disp('Aligning the spectra with previous scan.' )
    
    Frequencyshift=Referenceloc;
    for m=1:prod(Param.CSIdims)
        AlignedSpectra(:,m) = (interp1(xaxis, Spectra(:,m), xaxis-4.7+Frequencyshift(m))).';
    end
    AlignedSpectra(isnan(AlignedSpectra))=0;
    AlignedSpectra=reshape(AlignedSpectra,size(Spectra));
    loc=Referenceloc;
end


end

