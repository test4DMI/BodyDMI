clear variables
close all
clc
%% Paths
baseExportPath = fullfile(fileparts(mfilename('fullpath')));
addpath(fullfile(baseExportPath,'ReconFolder'))
addpath(fullfile(baseExportPath,'QuantifyFolder'))
addpath(fullfile(baseExportPath,'DisplayFolder'))
addpath(baseExportPath)
clear baseExportPath;
savepath
