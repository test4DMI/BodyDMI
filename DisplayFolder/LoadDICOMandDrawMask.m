function DCM_Mask=LoadDICOMandDrawMask(Dataset)
fns = fieldnames(Dataset);
for k=1:size(fns,1)
    if ~isequal(strfind(fns{k},'Dyn'),1)
        fns{k}=[nan];
    end
end
fns=fns(find(cell2mat(cellfun(@(x)any(~isnan(x)),fns,'UniformOutput',false)))); % Drop noise data
Parameters=eval(strcat('Dataset.',string(fns(1)),'.Param;'));
clear Dataset
Startpath=cd;
[DICOMName, DICOMpath]=uigetfile('*.*');
cd(DICOMpath)
DCM_Mask.AxialImage=double(dicomread(DICOMName));
DCM_Mask.AxialDicomTagInfo=dicominfo(DICOMName);
cd(Startpath)
imageratio=Parameters.CSIdims(1)/Parameters.CSIdims(2);
ImageSize=[size(DCM_Mask.AxialImage,1) size(DCM_Mask.AxialImage,2)];
Filledpart=ImageSize(1)*(1-imageratio);
DCM_Mask.AxialImage=squeeze(DCM_Mask.AxialImage(ceil(Filledpart/2):(ImageSize(2)-floor(Filledpart/2)),:,:));
DCM_Mask.DrawnROImask=NaN(Parameters.CSIdims);
figROI=figure('WindowState','maximized');
sgtitle('Draw ROI','FontSize',24)

DCM_Mask.ax(1)=subplot(1,1,1);
imagesc(DCM_Mask.AxialImage(:,:,1).^0.4)
daspect([1 1 1]);
title('Axial anatomical','FontSize',24)
colormap(DCM_Mask.ax(1),gray)
set(gca, 'Layer','top')
axis on;
[rows, columns, ~] = size(DCM_Mask.AxialImage(:,:,1));
hold on;
for row = 1 : rows ./ Parameters.CSIdims(1) : rows
    line([1, columns], [row, row], 'Color', 'r','Linewidth',1.5);
end
for col = 1 : columns ./ Parameters.CSIdims(2) : columns
    line([col, col], [1, rows], 'Color', 'r','Linewidth',1.5);
end
%% Slider
SliderH1 = uicontrol('style','slider','position',[250 50 300 20],...
    'min',1, 'max', size(DCM_Mask.AxialImage,3),'Tag','slider1', 'Value',1,'SliderStep',[1/(size(DCM_Mask.AxialImage,3)-1) 0.1]);

TextH1 = uicontrol('style','text',...
    'position',[320 80 200 50],'FontSize',24,'String',strcat('Slice: ',num2str(round(SliderH1.Value))));

addlistener(SliderH1, 'Value', 'PostSet', @callbackfn1);

%% Start drawing ROI
ROICheck = uicontrol('Style','check','position',[800 50 300 20],'Value',0);
TextH2 = uicontrol('style','text','position',[700 80 200 50],'FontSize',20,'String',strcat('Draw ROI'));

addlistener(ROICheck, 'Value', 'PostSet', @callbackfn2);

%% Stop drawing ROI
ROIFinishCheck = uicontrol('Style','check','position',[1150 50 300 20],'Value',0);
TextH3 = uicontrol('style','text','position',[1050 80 300 50],'FontSize',20,'String',strcat('ROI completed'));

addlistener(ROIFinishCheck, 'Value', 'PostSet', @callbackfn3);

%% Save and Close GUI
CloseGUI = uicontrol('Style','pushbutton','position',[1450 50 100 20],'Value',0);
TextH4 = uicontrol('style','text','position',[1450 80 100 50],'FontSize',20,'String',strcat('Close'));
addlistener(CloseGUI, 'Value', 'PostSet', @callbackfn4);

    function callbackfn1(source, eventdata)
        slice          = round(get(eventdata.AffectedObject, 'Value'));

        if ROICheck.Value==1
            children = get(gca, 'children');
            delete(children(1));
            DCM_Mask.ax(1).Children(end).CData= DCM_Mask.AxialImage(:,:,slice).^0.4;
            TextH1.String = strcat('Slice: ',num2str(slice));
            DCM_Mask.DrawnROI=drawfreehand(DCM_Mask.ax(1),'Deletable',1);
            DCM_Mask.DrawnROImask(:,:,round(SliderH1.Value))=imresize(createMask(DCM_Mask.DrawnROI),[Parameters.CSIdims(1) Parameters.CSIdims(2)]);
            assignin("base",'DCM_Mask',DCM_Mask)
        elseif ROICheck.Value==0
            DCM_Mask.ax(1).Children(end).CData= DCM_Mask.AxialImage(:,:,slice).^0.4;
            TextH1.String = strcat('Slice: ',num2str(slice));
        end
    end

    function callbackfn2(source, eventdata)
        DrawROI          = boolean(get(eventdata.AffectedObject, 'Value'));
        if DrawROI==1
            DCM_Mask.DrawnROI=drawfreehand(DCM_Mask.ax(1),'Deletable',1);
            DCM_Mask.DrawnROImask(:,:,round(SliderH1.Value))=imresize(createMask(DCM_Mask.DrawnROI),[Parameters.CSIdims(1) Parameters.CSIdims(2)]);
            assignin("base",'DCM_Mask',DCM_Mask)
        else
            return
        end
    end

    function callbackfn3(source, eventdata)
        StopDrawROI          = boolean(get(eventdata.AffectedObject, 'Value'));
        if StopDrawROI==1
            ROICheck.Value=0;
            assignin("base",'DCM_Mask',DCM_Mask)

        end
    end

    function callbackfn4(source, eventdata)
        CloseGUI          = boolean(get(eventdata.AffectedObject, 'Value'));
        %         save ('DrawnMask.mat','DCM_Mask.DrawnROImask')
        %         whos('-file','DrawnMask.mat')
        close all;
    end

end
