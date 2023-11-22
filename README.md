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


5-Show single voxel fit with seperate metabolite fits  
example use: ShowAmaresfit(V10570.Dyn4.spectradata,V10570.Dyn4.DMI_AMARES_Results,AP,RL,FH,V10570.Dyn4.xaxis,V10570.Dyn4.Param,V10570.Dyn4.Referenceloc)  
![image](https://github.com/ayhangursan/BodyDMI/assets/30341974/d76e724b-2f03-49b0-9507-9faf22f2c6dd)

6- Generate spectra overlay (Axial and Coronal): showAxial2Hspectra or showCoronal2Hspectra  
example use: showAxial2Hspectra(V10570.Dyn6.PhasedCombspectraZF,8,V10570.Dyn6.xaxiszerofill)  
Once the figure is loaded, which may take couple of seconds, copy the figure and paste it to a PPT slide.  
Remove the background color and resize the image with respect to the background image.   
![image](https://github.com/ayhangursan/BodyDMI/assets/30341974/16a52478-2950-45f1-b346-a521ce416629)


Sections related to implementation of AMARES in MATLAB is taken from OXSA toolbox.  
Please cite:  
OXSA: An open-source magnetic resonance spectroscopy analysis toolbox in MATLAB  
Lucian A. B. Purvis ,William T. Clarke,Luca Biasiolli,Ladislav Valkovič,Matthew D. Robson,Christopher T. Rodgers  
https://doi.org/10.1371/journal.pone.0185356
