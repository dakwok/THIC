# The Histological Inflammation Computation (THIC) software
This algorithm generates a MATLAB GUI that allows the user to analyze an H&amp;E stain of any epidermal cross section and output a score based on the the level of inflammation.
## Software and Code Details
This algorithm and guidance user interface (GUI) was written in MATLAB (version R2020b, 9.9.0.1467703). Download and load the script using the corresponding MATLAB version(s) and press "Run" to initialize the GUI. 
## Input Requirements
To properly load and analyze images, image files must be in either .JPEG or .jpg format. The Scale Bars folder must also be loaded with the proper magnification set into the software upon initialization. Select the proper magnification (4x, 10x, 20x) when the GUI initializes before pressing "Region Detection" or adjusting the "Threshold". If either the magnification of the input image is unknown or scaled area/perimeter values are not needed, simply select any magnification and proceed with the analysis.
## Running THIC GUI
- Open the thic_gui.m file with any compatible versions of MATLAB (previously described)
- Click 'Run' to initialize the GUI
- Click 'Browse' in the upper right box labeled 'Setup' and choose the folder containing the image files that you want to analyze. If the dropdown menu next to 'Browse' says 'Open Folder'. this means that a folder has not yet been selected.
- Click 'Upload' in the lower box labeled 'Intensity' and choose the folder containing the scale bars. Once the folder has been chosen, load the appropriate scale bar from the dropdown and press 'Calibrate'.
- Select image file from the dropdown in the 'Setup' box.
- Set the lower bound pixel luminance intensity in the 'Intensity' box with either the scrollbar or inputting a value between 0.00 and 1.00 in the entry box.
- Set the particle size threshold in the 'Particle Size Threshold' box on the upper right. Use either the scrollbar or the input number to remove small particles containing x number of pixels. (5000-8000 generally works for most epidermal H&E images)
- Adjust thresholds until the epidermis captured in the right screen matches the perimeter of the epidermis mapped on the left screen.
- Click 'Region Detection' to run the THIC algorithm on the image.
- Press 'Capture' to record the values. (ID = name of the file, Area (um^2) = scaled area based on the scale bar calibration used, Perimeter (um) = scaled perimeter based on the scale bar calibration used, Thickness Ratio = score for epidermal thickness)
 
(Last Updated June 15, 2021) 
 
 
  
  
