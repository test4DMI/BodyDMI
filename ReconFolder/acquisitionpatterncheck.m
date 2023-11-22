function patternarray=acquisitionpatterncheck(rawdata)
dims=size(rawdata);
if numel(dims)==6
    weightedpattern=find(squeeze(sum(abs(rawdata),1)));
    B=zeros(dims(2:end));
    B(weightedpattern)=1;
    patternarray=sum(B,ndims(B));
else
    weightedpattern=find(squeeze(sum(abs(rawdata),1)));
    B=zeros(dims(2:end));
    B(weightedpattern)=1;
    patternarray=sum(B,ndims(B));    
end

% Single NSA scans result with wrong acquisition pattern matrix!
