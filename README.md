# BodyDMI
This repo contains bunch of code packages to reconstruct, quantify and visualize deuterium MRSI data for BodyDMI project.

To install the package download the repository and unzip it to a folder of your preference.  
Open Matlab and run SetupBodyDMITool function to set up paths for the functions.  
After setting up you can start with running Reconpackage at the folder you would like to work at.

1-Reconpackage -> To reconstruct (dynamic) 2H MRSI data  
    Reconstruction of 2H MRSI dataset either from a single channel or multi-channel acquisition. In the case of multi channel data, you will also be asked to provide a seperate noise scan.  
2-MaskPackage -> To draw mask to set an VOI for AMARES fitting
    This script loads a dicom file, which contains axial T1w images to draw a mask on the region of interest for further analysis and faster quantification.  
3-Quantifypackage -> To fit DMI signal with previously prepared priorknowledge file and save fitted amplitudes to an excel file
  This package fits MR signal using a prior knowledge file prepared before and saved under QuantifyFolder. There is also an option to fit denoised data.  
  Also, fitted amplitudes are saved to an excel file under the current folder directory.  
4-Show_Dicom_Spectra -> Plot (dynamic) spectra, fits and residual from voxel of choice
  This GUI allows plotting one voxel from the 3D dataset together with dynamics. Options to apodize(in Hertz) and zerofill (to times of original number of points) are given in the GUI.  
  If you would like to include total signal fit and the residual in the plot please set 'Show Fit'to 1.  
  
![image](https://github.com/ayhangursan/BodyDMI/assets/30341974/d86f071f-930b-464e-bff5-f29c28c355f5)


Sections related to implementation of AMARES in MATLAB is taken from OXSA toolbox.  
Please cite:  
OXSA: An open-source magnetic resonance spectroscopy analysis toolbox in MATLAB  
Lucian A. B. Purvis ,William T. Clarke,Luca Biasiolli,Ladislav Valkovič,Matthew D. Robson,Christopher T. Rodgers  
https://doi.org/10.1371/journal.pone.0185356
