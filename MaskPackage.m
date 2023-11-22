DatasetName=input("What is the name of the dataset you would like to display? (ie: V1111) ","s");
if isempty(DatasetName)
    DatasetName = 'TESTdataset'; disp(['Running: ',DatasetName])
end
eval(([DatasetName,'.DCM_Mask=LoadDICOMandDrawMask(',DatasetName,');']))
fig = gca;
if isvalid(fig)
    waitfor(fig);
end
eval(([DatasetName,'.DCM_Mask=DCM_Mask;']))
clear DCM_Mask fig