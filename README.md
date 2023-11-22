# BodyDMI
This repo contains bunch of code packages to reconstruct, quantify and visualize deuterium MRSI data for BodyDMI project.

To install the package download the repository and unzip it. Open Matlab and run SetupBodyDMITool function to set up path's.
After setting up you can start with running Reconpackage at the folder you would like to work at.

1-Reconpackage -> To reconstruct (dynamic) 2H MRSI data  
2-MaskPackage -> To draw mask to set an VOI for AMARES fitting  
3-Quantifypackage -> To fit DMI signal with previously prepared priorknowledge file and save fitted amplitudes to an excel file  
4-Show_Dicom_Spectra -> Plot (dynamic) spectra, fits and residual from voxel of choice  
![image](https://github.com/ayhangursan/BodyDMI/assets/30341974/d86f071f-930b-464e-bff5-f29c28c355f5)


Sections related to implementation of AMARES in MATLAB is taken from OXSA toolbox.  
Please cite:  
OXSA: An open-source magnetic resonance spectroscopy analysis toolbox in MATLAB  
Lucian A. B. Purvis ,William T. Clarke,Luca Biasiolli,Ladislav Valkovič,Matthew D. Robson,Christopher T. Rodgers  
https://doi.org/10.1371/journal.pone.0185356
