%let pgm=altair-slc-openradioss-python-scripted-for-cell-phone-drop-no-gui;

%stop_submission;

Altair slc openradioss python scripted for cell phone drop no gui

A complete self-contained reproducible example is presented that is entirely scripted, no
GUI or mouse surfing requeried.

SOURCE
https://openradioss.atlassian.net/wiki/spaces/OPENRADIOSS/pages/11141156/Cell+Phone+Drop+Test

There are only two files you need to run this simulation.

  1 Use cell_phone_drop_0001.rad (directly from repository.
  2 run the powersshell script to unzip cell_phone_drop.zip and create cell_phone_drop_0000.rad,
    or download https://openradioss.atlassian.net/wiki/download/attachments/11141156/Cell_Phone_Drop.zip?api=v2
    to get cell_phone_drop_0000.rad. I made no changes to the 0000 rad file.
  3 I  experimented with a 3D simulation, it is easy to edit the 0001.rad for a faster and smaaler 2D simulation.
    Just use the shell option instead of the brick option.
    /ANIM/SHELL/TENS/STRESS/ALL
    /ANIM/SHELL/TENS/STRAIN/ALL
  4 The only  input you need are these files in d:/rad
      Cell_Phone_Drop_0000.rad
      Cell_Phone_Drop_0001.rad

Too long to post here see github
https://github.com/rogerjdeangelis/altair-slc-openradioss-python-script-for-cell-phone-drop-simulation-no-gui

Openradioss simulation
https://drive.google.com/file/d/1LYE3loLaqLB-m05IfM_Ie3HzRcjLUpuw/view?usp=drive_link
also downloadable from this repository, cell_animation.mp4

First Frame https://github.com/rogerjdeangelis/altair-slc-openradioss-python-script-for-cell-phone-drop-simulation-no-gui/blob/main/frame_0001.png
Last Frame  https://github.com/rogerjdeangelis/altair-slc-openradioss-python-script-for-cell-phone-drop-simulation-no-gui/blob/main/frame_0101.png

From this analysis

Graphical Analysis - See below for Summary Tables
Energy_evolution   https://github.com/rogerjdeangelis/altair-slc-openradioss-python-script-for-cell-phone-drop-simulation-no-gui/blob/main/energy_evolution.png
Energy_balance     https://github.com/rogerjdeangelis/altair-slc-openradioss-python-script-for-cell-phone-drop-simulation-no-gui/blob/main/energybalance.png
Time_step_history  https://github.com/rogerjdeangelis/altair-slc-openradioss-python-script-for-cell-phone-drop-simulation-no-gui/blob/main/timestephistory.png
X_momentumevolve   https://github.com/rogerjdeangelis/altair-slc-openradioss-python-script-for-cell-phone-drop-simulation-no-gui/blob/main/xmomentumevolve.png
Y_momentumevolve   https://github.com/rogerjdeangelis/altair-slc-openradioss-python-script-for-cell-phone-drop-simulation-no-gui/blob/main/ymomentumevolve.png

Summary Tables (Too large to save in github - see below for descriptions of the tables)

   D:/wpswrkx/simout.sas7bdat            1,000 KB (in this repo)
   D:/wpswrkx/global_energy.sas7bdat       101 KB (in this repo)
   D:/wpswrkx/gps_data.sas7bdat     25,967,504 KB (not included also associated large csv files)
   D:/wpswrkx/cell_data.sas7bdat    13,152,220 KB (not included also associated large csv files))

  CONTENTS

   1 Preparation
   1 Get github inputs
   2 Get animation & time history
   3 Time history table
   4 Csv to history table
   5 Many plots
      Energy_evolution
      Energy_balance
      Time_step_history
      X_momentumevolve
      Y_momentumevolve
   6 Animation to vtk file
   7 Vtk to vkthdf
   8 vkthdf to csv
   9 vkthdf stress strain tensor tables
  10 Vtk to mp4
  
 For macros see
 https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories
 
Related Repos
https://github.com/rogerjdeangelis/utl-altair-slc-enhanced-openradioss-tensile-strength-simulation-python-no-gui-no-mouse-surfing
https://github.com/rogerjdeangelis/utl-altair-slc-python-script-to-run-openradioss-tensile-strength-simulation
https://github.com/rogerjdeangelis/utl-altair-slc-post-processing-radioss-files-using-openradioss
https://github.com/rogerjdeangelis/utl-personal-altair-slc-with-matlab-sympy-and-r-finite-element-cold-plate-heat-transfer

/*
 _                                        _   _
/ |  _ __  _ __ ___ _ __   __ _ _ __ __ _| |_(_) ___  _ __
| | | `_ \| `__/ _ \ `_ \ / _` | `__/ _` | __| |/ _ \| `_ \
| | | |_) | | |  __/ |_) | (_| | | | (_| | |_| | (_) | | | |
|_| | .__/|_|  \___| .__/ \__,_|_|  \__,_|\__|_|\___/|_| |_|
    |_|            |_|
*/

libname workx "d:/wpswrkx";

MOST OF THE INSTALLS ARE ONLY NEEDED FOR THE ANIMATION, YOU MAY NOT NEED STEPS III-V IF
YOU ARE NOT INTERESTED DIN THE ANIMATION. INTEL API IS NEEDED FOR CUSTOMIZATION OF PENRADIOSS
OR PARALLEL PROCESSING?
There are many python tools you can easily add to the script below for graphics and summary tables.


I INSTALL OPENRADIOSS
---------------------

 a  Go to https://github.com/OpenRadioss/OpenRadioss/releases
 b  Download openradioss_win64.zip
 c  Create directory c:/openradioss
 d  From the unzipped file copy all folders, see below, to c:/openradioss
    The result should look like

    c:/openradioss (should look like)

      <DIR>   exec
      <DIR>   extlib
      <DIR>   hm_cfg_files
      <DIR>   licenses
      <DIR>   openradioss_gui


II  INSTALL INTEL OPENAPI TOOLKIT YOU NEED TO INSTALL VERSION 2 FROM THE ARCHIVES
-----------------------------------------------------------------------------

 a  https://www.intel.com/content/www/us/en/developer/articles/tool/oneapi-archive.html
 b  It automaticall installs at C:/Program Files (x86)/Intel/oneapi


III INSTALL VISUAL STUDIO
-------------------------

 a  https://visualstudio.microsoft.com/vs/community/
 b  C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools


IV  INSTALL FFMPEG
------------------

 a  https://www.gyan.dev/ffmpeg/builds/
 b  C:\Program Files\ffmpeg
 c  esential version
 d  unzip and save to c:/program files


V   INSTALL PARAVIEW
--------------------

 a  https://www.paraview.org/download/
 b  It will install at C:\Program Files\ParaView-6.1.0-Windows-Python3.12-msvc2017-AMD64


VI  Download SLC macros and place in your autocall library for instance c:/wpsoto (also in this repo)
-----------------------------------------------------------------------------------------------------
 a  https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories
 b  utlfkil
 d  slc_pvbegin  /*-- runs a virtual python ---*/
 e  slc_pvend
 f  slc_psbegin  /*--- runs powershell      ---*/
 g  slc_psend



VII YOU NEED TO PUT THIS IN YOUR AUTOEXEC
-----------------------------------------

  a libname workx "d:/wpswrkx";
  b or set in betewen each section below
    (many many sections. I suggest you put it in your autoexec ---*/


/*---
 ____              _          _ _   _           _      _                   _
|___ \   __ _  ___| |_   __ _(_) |_| |__  _   _| |__  (_)_ __  _ __  _   _| |_ ___
  __) | / _` |/ _ \ __| / _` | | __| `_ \| | | | `_ \ | | `_ \| `_ \| | | | __/ __|
 / __/ | (_| |  __/ |_ | (_| | | |_| | | | |_| | |_) || | | | | |_) | |_| | |_\__ \
|_____| \__, |\___|\__| \__, |_|\__|_| |_|\__,_|_.__/ |_|_| |_| .__/ \__,_|\__|___/
        |___/           |___/                                 |_|

You do not need to run this. You can manually  create d:/rad and download the rad files from this repp

What powershell is doing ( you can do the following manually)

  1 deletes d:/rad directory if it exists
  2 recreate empty d:/rad
  3 copy files from github
    Cell_Phone_Drop_0000.rad
    Cell_Phone_Drop_0001.rad

---*/

/*--- clear workx data ---*/
libname workx "d:/wpswrkx";  /*--- put in autoexec ---*/

proc datasets lib=workx kill;
run;

%slc_psbegin;
cards4;

# Deletes d:/rad and all subdirectories/files, recreates the folder, then
# downloads the OpenRadioss input files from your GitHub repository.

$targetDir = "D:\rad"

# 1. Remove the directory and everything inside it (forcefully, recursively)
if (Test-Path $targetDir) {
    Write-Host "Removing existing directory: $targetDir" -ForegroundColor Yellow
    Remove-Item -Path $targetDir -Recurse -Force
}

# 2. Recreate the empty directory
Write-Host "Creating fresh directory: $targetDir" -ForegroundColor Yellow
New-Item -Path $targetDir -ItemType Directory -Force | Out-Null

# 3. download and unzip creating d:/rad/Cell_Phone_Drop_0000.rad
$rawUrl = "https://raw.githubusercontent.com/rogerjdeangelis/altair-slc-openradioss-python-script-for-cell-phone-drop-simulation-no-gui/main/Cell_Phone_Drop_0000.zip"
$localZipFile = "D:\rad\Cell_Phone_Drop_0000.zip"
$destDir = "D:\rad"

Write-Host "Downloading zip file from GitHub..." -ForegroundColor Yellow

# Download the file using Invoke-WebRequest
try {
    Invoke-WebRequest -Uri $rawUrl -OutFile $localZipFile
    Write-Host "Download complete: $localZipFile" -ForegroundColor Green
} catch {
    Write-Host "Download failed: $_" -ForegroundColor Red
    exit 1
}

# Check if download succeeded
if (Test-Path $localZipFile) {
    Write-Host "Extracting Cell_Phone_Drop_0000.rad to $destDir..." -ForegroundColor Yellow

    # Extract the contents of the zip file directly to D:\rad
    Expand-Archive -Path $localZipFile -DestinationPath $destDir -Force

    # Verify the extracted file
    $extractedFile = Join-Path $destDir "Cell_Phone_Drop_0000.rad"
    if (Test-Path $extractedFile) {
        Write-Host "Successfully extracted: $extractedFile" -ForegroundColor Green

        # Show file details
        $fileInfo = Get-Item $extractedFile
        Write-Host "File size: $($fileInfo.Length) bytes" -ForegroundColor Cyan
        Write-Host "Last modified: $($fileInfo.LastWriteTime)" -ForegroundColor Cyan
    } else {
        Write-Host "Warning: Cell_Phone_Drop_0000.rad not found in zip" -ForegroundColor Yellow

        # FIXED: Proper string concatenation - avoid colon after variable
        Write-Host ""
        Write-Host "Contents extracted to $destDir :" -ForegroundColor Cyan
        Get-ChildItem -Path $destDir -Filter "Cell_Phone_Drop*" | Format-Table Name, Length -AutoSize
    }

    # Delete the zip file after extraction to save space
    Remove-Item -Path $localZipFile -Force
    Write-Host "Deleted zip file: $localZipFile" -ForegroundColor DarkGray

} else {
    Write-Host "Failed to download zip file" -ForegroundColor Red
}

# 4. download Cell_Phone_Drop_0001.rad
$sourceUrl = "https://raw.githubusercontent.com/rogerjdeangelis/altair-slc-openradioss-python-script-for-cell-phone-drop-simulation-no-gui/refs/heads/main/Cell_Phone_Drop_0001.rad"
$destinationPath = "D:\rad\Cell_Phone_Drop_0001.rad"

Write-Host "Downloading file..." -ForegroundColor Yellow
try {
    Invoke-WebRequest -Uri $sourceUrl -OutFile $destinationPath
    Write-Host "Success! File saved to: $destinationPath" -ForegroundColor Green
} catch {
    Write-Host "Download failed: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "Done!" -ForegroundColor Green
;;;;
%slc_psend;

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

/**************************************************************************************************************************/
/*  Altair SLC                                                                                                            */
/*  Removing existing directory: D:\rad                                                                                   */
/*  Creating fresh directory: D:\rad                                                                                      */
/*  Downloading zip file from GitHub...                                                                                   */
/*  Download complete: D:\rad\Cell_Phone_Drop_0000.zip                                                                    */
/*  Extracting Cell_Phone_Drop_0000.rad to D:\rad...                                                                      */
/*  Successfully extracted: D:\rad\Cell_Phone_Drop_0000.rad                                                               */
/*  File size: 42378237 bytes                                                                                             */
/*  Last modified: 05/17/2026 10:56:28                                                                                    */
/*  Deleted zip file: D:\rad\Cell_Phone_Drop_0000.zip                                                                     */
/*  Downloading file...                                                                                                   */
/*  Success! File saved to: D:\rad\Cell_Phone_Drop_0001.rad                                                               */
/*  Done!                                                                                                                 */
/*                                                                                                                        */
/*  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/
/*  DIRECTORY OF D:\RAD                                                                                                   */
/*  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/
/*                                                                                                                        */
/*    Contents of D:\rad :                                                                                                */
/*    Name                               Length                                                                           */
/*    ----                               ------                                                                           */
/*    Cell_Phone_Drop_0000.rad           41.385 KB                                                                        */
/*    Cell_Phone_Drop_0001.rad                1 KB                                                                        */
/*                                                                                                                        */
/*    Script completed.                                                                                                   */
/*                                                                                                                        */
/*  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/
/*  Cell_Phone_Drop_0001.rad                                                                                              */
/*  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/
/*                                                                                                                        */
/*  d:/rad/Cell_Phone_Drop_0001.rad                                                                                       */
/*                                                                                                                        */
/*  /ANIM/DT                                                                                                              */
/*  #   TSTART     TFREQ                                                                                                  */
/*  0.000000 1e-6                                                                                                         */
/*  # --- ADD STRESS AND STRAIN OUTPUT FOR BRICK ELEMENTS ---                                                             */
/*  /ANIM/BRICK/TENS/STRESS/ALL                                                                                           */
/*  /ANIM/BRICK/TENS/STRAIN/ALL                                                                                           */
/*  # --- CONTINUE WITH OTHER ANIM CARDS ---                                                                              */
/*  /ANIM/GPS/TENS                                                                                                        */
/*  /DT1TET10                                                                                                             */
/*  /NEGVOL/STOP                                                                                                          */
/*  /PARITH/OFF                                                                                                           */
/*  # Emax Mmax Nmax NTH NANIM NERR_POSIT                                                                                 */
/*  0.99 0.05 0 1 1 1                                                                                                     */
/*  /TFILE/0                                                                                                              */
/*  #            dT_HIS                                                                                                   */
/*  1e-7                                                                                                                  */
/*  /RUN/Cell_Phone_Drop/1/                                                                                               */
/*                 1e-4                                                                                                   */
/*                                                                                                                        */
/*  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/
/*  Cell_Phone_Drop_0001.rad                                                                                              */
/*  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx*/
/*                                                                                                                        */
/*  #RADIOSS STARTER                                                                                                      */
/*  # Copyright (C) 2022 Altair Engineering Inc. ("Holder")                                                               */
/*  # Model is licensed by Holder under CC BY-NC 4.0                                                                      */
/*  # (https://creativecommons.org/licenses/by-nc/4.0/legalcode).                                                         */
/*  #---1----|----2----|----3----|----4----|----5----|----6----|----7----|----8----|----9----|---10----|                  */
/*  /BEGIN                                                                                                                */
/*  Cell_Phone_Drop                                                                                                       */
/*        2022         0                                                                                                  */
/*                    Mg                  mm                   s                                                          */
/*                    Mg                  mm                   s                                                          */
/*  #---1----|----2----|----3----|----4----|----5----|----6----|----7----|----8----|----9----|---10----|                  */
/*  #-  1. CONTROL CARDS:                                                                                                 */
/*  #---1----|----2----|----3----|----4----|----5----|----6----|----7----|----8----|----9----|---10----|                  */
/*  /TITLE                                                                                                                */
/*                                                                                                                        */
/*  #---1----|----2----|----3----|----4----|----5----|----6----|----7----|----8----|----9----|---10----|                  */
/*  /DEFAULT/INTER/TYPE2                                                                                                  */
/*                                                                                                                        */
/*  #                       Ignore  Spotflag             Isearch      Idel                                                */
/*                               3        27                   0         0                                                */
/*  #                                                                 Istf                                                */
/*                                                                       0                                                */
/*  #---1----|----2----|----3----|----4----|----5----|----6----|----7----|----8----|----9----|---10----|                  */
/*  /DEF_SOLID                                                                                                            */
/*  #  I_SOLID    ISMSTR     ICPRE             ITETRA4  ITETRA10      IMAS    IFRAME                                      */
/*           0        -2        -2                   0         2         0        -2                                      */
/*  #---1----|----2----|----3----|----4----|----5----|----6----|----7----|----8----|----9----|---10----|                  */
/*  #-  2. MATERIALS:                                                                                                     */
/*  #---1----|----2----|----3----|----4----|----5----|----6----|----7----|----8----|----9----|---10----|                  */
/*  /MAT/PLAS_TAB/1                                                                                                       */
/*  polymer_unfilled_plastic                                                                                              */
/*  #              RHO_I                                                                                                  */
/*                1.1E-9                   0                                                                              */
/*  #                  E                  Nu           Eps_p_max               Eps_t               Eps_m                  */
/*                  2000                  .4                   0                   0                   0                  */
/*  #  N_funct  F_smooth              C_hard               F_cut               Eps_f                  VP                  */
/*           1         0                   0                   0                   0                   0                  */
/*  #  fct_IDp              Fscale   Fct_IDE                EInf                  CE                                      */
/*           0                   0         0                   0                   0                                      */
/*  # func_ID1  func_ID2  func_ID3  func_ID4  func_ID5                                                                    */
/*           1                                                                                                            */
/*  #           Fscale_1            Fscale_2            Fscale_3            Fscale_4            Fscale_5                  */
/*                     1                                                                                                  */
/*  #          Eps_dot_1           Eps_dot_2           Eps_dot_3           Eps_dot_4           Eps_dot_5                  */
/*                     0                                                                                                  */
/*  #---1----|----2----|----3----|----4----|----5----|----6----|----7----|----8----|----9----|---10----|                  */
/*                                                                                                                        */
/*  ....                                                                                                                  */
/*  ....                                                                                                                  */
/*  ....                                                                                                                  */
/*                                                                                                                        */
/*  #---1----|----2----|----3----|----4----|----5----|----6----|----7----|----8----|----9----|---10----|                  */
/*  #- 10. RIGID WALLS:                                                                                                   */
/*  #---1----|----2----|----3----|----4----|----5----|----6----|----7----|----8----|----9----|---10----|                  */
/*  /RWALL/PLANE/1                                                                                                        */
/*  RigidWall18                                                                                                           */
/*  #  node_ID     Slide grnod_ID1 grnod_ID2                                                                              */
/*                     2         0         0                                                                              */
/*  #           D_search                fric            Diameter                ffac       ifq                            */
/*             32.578377                  .3                   0                   0         0                            */
/*  #                 XM                  YM                  ZM                                                          */
/*            -26.944114          -49.826285            3.587149                                                          */
/*  #               X_M1                Y_M1                Z_M1                                                          */
/*             -26.35408          -49.179045            4.069787                                                          */
/*  #---1----|----2----|----3----|----4----|----5----|----6----|----7----|----8----|----9----|---10----|                  */
/*  /END                                                                                                                  */
/*  #---1----|----2----|----3----|----4----|----5----|----6----|----7----|----8----|----9----|---10----|                  */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*                   _     _
(_)_ __  _ __  _   _| |_  | | ___   __ _
| | `_ \| `_ \| | | | __| | |/ _ \ / _` |
| | | | | |_) | |_| | |_  | | (_) | (_| |
|_|_| |_| .__/ \__,_|\__| |_|\___/ \__, |
        |_|                        |___/
*/

1                                          Altair SLC          12:00 Saturday, May 23, 2026

NOTE: Copyright 2002-2025 World Programming, an Altair Company
NOTE: Altair SLC 2026 (05.26.01.00.000758)
      Licensed to Roger DeAngelis
NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
NOTE: AUTOEXEC source line
1       +  ï»¿ods _all_ close;
           ^
ERROR: Expected a statement keyword : found "?"

NOTE: AUTOEXEC processing completed


Altair SLC

The DATASETS Procedure

         Directory

Libref           WORKX
Engine           SAS7BDAT
Physical Name    d:\wpswrkx
1         proc datasets lib=workx kill;
NOTE: No matching members in directory
2         run;
3
4         %slc_psbegin;
NOTE: Procedure datasets step took :
      real time : 0.091
      cpu time  : 0.046


5         cards4;

NOTE: The file 'c:\temp\ps_pgm.ps1' is:
      Filename='c:\temp\ps_pgm.ps1',
      Owner Name=SLC\suzie,
      File size (bytes)=0,
      Create Time=14:40:04 Mar 21 2026,
      Last Accessed=12:00:40 May 23 2026,
      Last Modified=12:00:40 May 23 2026,
      Lrecl=32767, Recfm=V

NOTE: 79 records were written to file 'c:\temp\ps_pgm.ps1'
      The minimum record length was 80
      The maximum record length was 180
NOTE: The data step took :
      real time : 0.005
      cpu time  : 0.000


6
7         # Deletes d:/rad and all subdirectories/files, recreates the folder, then
8         # downloads the OpenRadioss input files from your GitHub repository.
9
10        $targetDir = "D:\rad"
11
12        # 1. Remove the directory and everything inside it (forcefully, recursively)
13        if (Test-Path $targetDir) {
14            Write-Host "Removing existing directory: $targetDir" -ForegroundColor Yellow
15            Remove-Item -Path $targetDir -Recurse -Force
16        }
17
18        # 2. Recreate the empty directory
19        Write-Host "Creating fresh directory: $targetDir" -ForegroundColor Yellow
20        New-Item -Path $targetDir -ItemType Directory -Force | Out-Null
21
22        # 3. download and unzip creating d:/rad/Cell_Phone_Drop_0000.rad
23        $rawUrl = "https://raw.githubusercontent.com/rogerjdeangelis/altair-slc-openradioss-python-script-for-cell-phone-drop-simulation-no-gui/main/Cell_Phone_Drop_0000.zip"
24        $localZipFile = "D:\rad\Cell_Phone_Drop_0000.zip"
25        $destDir = "D:\rad"
26
27        Write-Host "Downloading zip file from GitHub..." -ForegroundColor Yellow
28
29        # Download the file using Invoke-WebRequest
30        try {
31            Invoke-WebRequest -Uri $rawUrl -OutFile $localZipFile
32            Write-Host "Download complete: $localZipFile" -ForegroundColor Green
33        } catch {
34            Write-Host "Download failed: $_" -ForegroundColor Red
35            exit 1
36        }
37
38        # Check if download succeeded
39        if (Test-Path $localZipFile) {
40            Write-Host "Extracting Cell_Phone_Drop_0000.rad to $destDir..." -ForegroundColor Yellow
41
42            # Extract the contents of the zip file directly to D:\rad
43            Expand-Archive -Path $localZipFile -DestinationPath $destDir -Force
44
45            # Verify the extracted file
46            $extractedFile = Join-Path $destDir "Cell_Phone_Drop_0000.rad"
47            if (Test-Path $extractedFile) {
48                Write-Host "Successfully extracted: $extractedFile" -ForegroundColor Green
49
50                # Show file details
51                $fileInfo = Get-Item $extractedFile
52                Write-Host "File size: $($fileInfo.Length) bytes" -ForegroundColor Cyan
53                Write-Host "Last modified: $($fileInfo.LastWriteTime)" -ForegroundColor Cyan
54            } else {
55                Write-Host "Warning: Cell_Phone_Drop_0000.rad not found in zip" -ForegroundColor Yellow
56
57                # FIXED: Proper string concatenation - avoid colon after variable
58                Write-Host ""
59                Write-Host "Contents extracted to $destDir :" -ForegroundColor Cyan
60                Get-ChildItem -Path $destDir -Filter "Cell_Phone_Drop*" | Format-Table Name, Length -AutoSize
61            }
62
63            # Delete the zip file after extraction to save space
64            Remove-Item -Path $localZipFile -Force
65            Write-Host "Deleted zip file: $localZipFile" -ForegroundColor DarkGray
66
67        } else {
68            Write-Host "Failed to download zip file" -ForegroundColor Red
69        }
70
71        # 4. download Cell_Phone_Drop_0001.rad
72        $sourceUrl = "https://raw.githubusercontent.com/rogerjdeangelis/altair-slc-openradioss-python-script-for-cell-phone-drop-simulation-no-gui/refs/heads/main/Cell_Phone_Drop_0001.rad"
73        $destinationPath = "D:\rad\Cell_Phone_Drop_0001.rad"
74
75        Write-Host "Downloading file..." -ForegroundColor Yellow
76        try {
77            Invoke-WebRequest -Uri $sourceUrl -OutFile $destinationPath
78            Write-Host "Success! File saved to: $destinationPath" -ForegroundColor Green
79        } catch {
80            Write-Host "Download failed: $_" -ForegroundColor Red
81        }
82
83        Write-Host ""
84        Write-Host "Done!" -ForegroundColor Green
85        ;;;;
86        %slc_psend;

NOTE: The infile rut is:
      Unnamed Pipe Access Device,
      Process=powershell.exe -executionpolicy bypass -file c:/temp/ps_pgm.ps1 >  c:/temp/ps_pgm.log,
      Lrecl=32756, Recfm=V

NOTE: No records were written to file PRINT

NOTE: No records were read from file rut
NOTE: The data step took :
      real time : 12.739
      cpu time  : 0.000



NOTE: The infile rut is:
      Unnamed Pipe Access Device,
      Process=powershell.exe -executionpolicy bypass -file c:/temp/ps_pgm.ps1 >  c:/temp/ps_pgm.log,
      Lrecl=32767, Recfm=V

NOTE: No records were written to file PRINT

NOTE: No records were read from file rut
NOTE: The data step took :
      real time : 15.682
      cpu time  : 0.031



NOTE: The infile 'c:\temp\ps_pgm.log' is:
      Filename='c:\temp\ps_pgm.log',
      Owner Name=SLC\suzie,
      File size (bytes)=455,
      Create Time=10:30:46 Mar 22 2026,
      Last Accessed=12:01:09 May 23 2026,
      Last Modified=12:01:09 May 23 2026,
      Lrecl=32767, Recfm=V

Removing existing directory: D:\rad
Creating fresh directory: D:\rad
Downloading zip file from GitHub...
Download complete: D:\rad\Cell_Phone_Drop_0000.zip
Extracting Cell_Phone_Drop_0000.rad to D:\rad...
Successfully extracted: D:\rad\Cell_Phone_Drop_0000.rad
File size: 42378237 bytes
Last modified: 05/17/2026 10:56:28
Deleted zip file: D:\rad\Cell_Phone_Drop_0000.zip
Downloading file...
Success! File saved to: D:\rad\Cell_Phone_Drop_0001.rad

Done!
NOTE: 13 records were read from file 'c:\temp\ps_pgm.log'
      The minimum record length was 0
      The maximum record length was 55
NOTE: 13 records were written to file PRINT

NOTE: The data step took :
      real time : 0.031
      cpu time  : 0.000


ERROR: Error printed on page 1

NOTE: Submitted statements took :
      real time : 28.695
      cpu time  : 0.125


/*____             _                _                 _   _               ___    _   _                                _
|___ /   __ _  ___| |_   __ _ _ __ (_)_ __ ___   __ _| |_(_) ___  _ __   ( _ )  | |_(_)_ __ ___   ___   ___  ___ _ __(_) ___  ___
  |_ \  / _` |/ _ \ __| / _` | `_ \| | `_ ` _ \ / _` | __| |/ _ \| `_ \  / _ \/\| __| | `_ ` _ \ / _ \ / __|/ _ \ `__| |/ _ \/ __|
 ___) || (_| |  __/ |_ | (_| | | | | | | | | | | (_| | |_| | (_) | | | || (_>  <| |_| | | | | | |  __/ \__ \  __/ |  | |  __/\__ \
|____/  \__, |\___|\__| \__,_|_| |_|_|_| |_| |_|\__,_|\__|_|\___/|_| |_| \___/\/ \__|_|_| |_| |_|\___| |___/\___|_|  |_|\___||___/
        |___/
*/

/*--- DO NOT RUN THIS                                                               ---*/
/*--- ONLY USE THIS DATASTEP IF YOU NEED TO CUSTOMIZE THE Cell_Phone_Drop_0001.rad  ---*/
/*--- YOU DO NOT NEED TO RUN THIS DATASTEP FOR THIS EXAMPLE                         ---*/

/*--- UNCOMMENT IF YOU NEED TO CUSTOMIZE
data _null_;
 file "d:/rad/Cell_Phone_Drop_0001.rad";
 input;
 _infile_=trim(_infile_);
 put _infile_;
 putlog _infile_;
cards4;
/ANIM/DT
#   TSTART     TFREQ
0.000000 1e-6
# --- ADD STRESS AND STRAIN OUTPUT FOR BRICK ELEMENTS ---
/ANIM/BRICK/TENS/STRESS/ALL
/ANIM/BRICK/TENS/STRAIN/ALL
# --- CONTINUE WITH OTHER ANIM CARDS ---
/ANIM/GPS/TENS
/DT1TET10
/NEGVOL/STOP
/PARITH/OFF
# Emax Mmax Nmax NTH NANIM NERR_POSIT
0.99 0.05 0 1 1 1
/TFILE/0
#            dT_HIS
1e-7
/RUN/Cell_Phone_Drop/1/
               1e-4
;;;;
run;
---*/


/*--- START HERE ---*/
/*--- START HERE ---*/

/*--- CREATE SIEMEN ANIMATION AND TIME HISTORY CSV FILE  ---*/

options validvarname=v7;
options set=PYTHONHOME "D:\py314";
proc python;
submit;
import os
import pandas as pd
import subprocess
from pathlib import Path

# ============================================================================
# CONFIGURATION
# ============================================================================

OPENRADIOSS_PATH = Path("C:/openradioss")
STARTER_EXE = OPENRADIOSS_PATH / "exec" / "starter_win64.exe"
ENGINE_EXE = OPENRADIOSS_PATH / "exec" / "engine_win64.exe"
TH_TO_CSV_EXE = OPENRADIOSS_PATH / "exec" / "th_to_csv_win64.exe"

MODEL_DIR = Path("D:/rad")
STARTER_FILE = "Cell_Phone_Drop_0000.rad"
ENGINE_FILE =  "Cell_Phone_Drop_0001.rad"

# Time history file (output from simulation)
TH_FILE = MODEL_DIR / "Cell_Phone_DropT01"
# CSV output file
CSV_FILE = MODEL_DIR / "results.csv"

SETVARS_PATH = Path("C:/Program Files (x86)/Intel/oneAPI/setvars.bat")
OMP_NUM_THREADS = "1"
KMP_STACKSIZE = "400m"

# ============================================================================
# ENVIRONMENT SETUP
# ============================================================================

def setup_environment():
    env = os.environ.copy()
    env["OPENRADIOSS_PATH"] = str(OPENRADIOSS_PATH)
    env["RAD_CFG_PATH"] = str(OPENRADIOSS_PATH / "hm_cfg_files")
    env["RAD_H3D_PATH"] = str(OPENRADIOSS_PATH / "extlib" / "h3d" / "lib" / "win64")
    env["OMP_NUM_THREADS"] = OMP_NUM_THREADS
    env["KMP_STACKSIZE"] = KMP_STACKSIZE

    hm_reader = OPENRADIOSS_PATH / "extlib" / "hm_reader" / "win64"
    if hm_reader.exists():
        env["PATH"] = str(hm_reader) + ";" + env.get("PATH", "")

    # Add tools directory to PATH for th_to_csv
    tools_dir = OPENRADIOSS_PATH / "tools"
    if tools_dir.exists():
        env["PATH"] = str(tools_dir) + ";" + env.get("PATH", "")

    return env

def run_cmd(cmd, cwd, env, log_file):
    """Run command and capture output to log file"""
    with open(log_file, 'w') as f:
        result = subprocess.run(cmd, shell=True, cwd=cwd, env=env,
                                stdout=f, stderr=subprocess.STDOUT, text=True)
    return result.returncode

def convert_th_to_csv(th_file, csv_file, env):
    """Convert time history binary file to CSV format"""
    if not th_file.exists():
        print(f"Warning: Time history file not found: {th_file}")
        return False

    if not TH_TO_CSV_EXE.exists():
        print(f"Warning: th_to_csv_win64.exe not found at {TH_TO_CSV_EXE}")
        return False

    print(f"Converting time history: {th_file.name} -> {csv_file.name}")

    # Run th_to_csv and redirect output to CSV file
    cmd = f'"{TH_TO_CSV_EXE}" "{th_file}"'

    try:
        with open(csv_file, 'w') as f:
            result = subprocess.run(cmd, shell=True, cwd=str(MODEL_DIR), env=env,
                                    stdout=f, stderr=subprocess.PIPE, text=True)

        if result.returncode == 0 and csv_file.exists() and csv_file.stat().st_size > 0:
            # Count lines to verify data
            with open(csv_file, 'r') as f:
                line_count = sum(1 for _ in f)
            print(f"  [OK] Created {csv_file.name} ({line_count} lines, {csv_file.stat().st_size / 1024:.1f} KB)")

            # Show first few lines as preview
            with open(csv_file, 'r') as f:
                header = f.readline().strip()
                first_data = f.readline().strip() if line_count > 1 else ""
            print(f"  Header: {header[:100]}...")
            return True
        else:
            print(f"  [FAILED] Conversion failed (exit code {result.returncode})")
            if result.stderr:
                print(f"    Error: {result.stderr[:200]}")
            return False
    except Exception as e:
        print(f"  [ERROR] {e}")
        return False

# ============================================================================
# MAIN EXECUTION
# ============================================================================

def main():
    print("=" * 60)
    print("OpenRadioss Tensile Test Simulation")
    print("=" * 60)

    # Quick verification
    if not STARTER_EXE.exists() or not ENGINE_EXE.exists():
        print("ERROR: OpenRadioss executables not found")
        return 1

    env = setup_environment()
    setvars = f'call "{SETVARS_PATH}" intel64 vs2022 > nul 2>&1 && ' if SETVARS_PATH.exists() else ""

    # Run Starter
    print("\n[1/3] Running Starter...")
    starter_input = MODEL_DIR / STARTER_FILE
    rc = run_cmd(f'{setvars}"{STARTER_EXE}" -i "{starter_input}"',
                  str(MODEL_DIR), env, MODEL_DIR / "starter.log")
    if rc != 0:
        print(f"Starter failed (exit {rc}). Check starter.log")
        return rc

    # Run Engine
    print("[2/3] Running Engine...")
    engine_input = MODEL_DIR / ENGINE_FILE
    rc = run_cmd(f'{setvars}"{ENGINE_EXE}" -i "{engine_input}"',
                  str(MODEL_DIR), env, MODEL_DIR / "engine.log")
    if rc != 0:
        print(f"Engine failed (exit {rc}). Check engine.log")
        return rc

    # List animation files created
    anim_files = list(MODEL_DIR.glob("*.A0*")) + list(MODEL_DIR.glob("*.h3d"))
    if anim_files:
        print(f"\nAnimation files created ({len(anim_files)}):")
        for f in sorted(anim_files):
            size_kb = f.stat().st_size / 1024
            print(f"  {f.name} ({size_kb:.1f} KB)")
    else:
        print("\nWarning: No animation files found")

    # Convert time history to CSV
    print("\n[3/3] Converting time history to CSV...")
    convert_th_to_csv(TH_FILE, CSV_FILE, env)

    # Summary
    print("\n" + "=" * 60)
    print("SIMULATION COMPLETE")
    print("=" * 60)
    print(f"Results saved to: {MODEL_DIR}")
    print(f"  - Time history CSV: {CSV_FILE.name}")
    print(f"  - Starter log: starter.log")
    print(f"  - Engine log: engine.log")
    if anim_files:
        print(f"  - Animation files: {len(anim_files)} files")

    # Verify CSV was created
    if CSV_FILE.exists():
        print(f"\nCSV file size: {CSV_FILE.stat().st_size / 1024:.1f} KB")
        print("You can now open results.csv in Excel or Python for analysis.")

    print("\nDone.")
    return 0

if __name__ == "__main__":
    exit(main());
endsubmit;
run;

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

/*************************************************************************************************************************/
/* ============================================================                                                          */
/* OpenRadioss Ceel Phone Drop Simulation                                                                                */
/* ============================================================                                                          */
/*                                                                                                                       */
/* [1/3] Running Starter...                                                                                              */
/* [2/3] Running Engine...                                                                                               */
/*                                                                                                                       */
/* Warning: No animation files found                                                                                     */
/*                                                                                                                       */
/* [3/3] Converting time history to CSV...                                                                               */
/* Converting time history: Cell_Phone_DropT01 -> results.csv                                                            */
/*   [OK] Created results.csv (6 lines, 0.2 KB)                                                                          */
/*                                                                                                                       */
/*   Header: ...                                                                                                         */
/*                                                                                                                       */
/* ============================================================                                                          */
/* SIMULATION COMPLETE                                                                                                   */
/* ============================================================                                                          */
/*                                                                                                                       */
/* Results saved to: D:\rad                                                                                              */
/*                                                                                                                       */
/*   - Time history CSV: results.csv                                                                                     */
/*   - Starter log: starter.log                                                                                          */
/*   - Engine log: engine.log                                                                                            */
/*                                                                                                                       */
/*                                                                                                                       */
/* CSV file size: 0.2 KB                                                                                                 */
/* You can now open results.csv in Excel or Python for analysis.                                                         */
/*                                                                                                                       */
/* Done.                                                                                                                 */
/*                                                                                                                       */
/* ======================================================================================================================*/
/* DIRECTORY OF D:\RAD                                                                                                   */
/* ======================================================================================================================*/
/*                                                                                                                       */
/* Directory of d:\rad                                                                                                   */
/*                                                                                                                       */
/*   Cell_Phone_DropA001              66,653,491                                                                         */
/*   Cell_Phone_DropA002              66,653,491                                                                         */
/*   ...                                                                                                                 */
/*   Cell_Phone_DropA100              66,653,491                                                                         */
/*   Cell_Phone_DropA101              66,653,491                                                                         */
/*                                                                                                                       */
/*   Cell_Phone_DropT01                  110,804                                                                         */
/*   Cell_Phone_Drop_0000.out          5,136,273                                                                         */
/*   Cell_Phone_Drop_0000.rad         42,378,237                                                                         */
/*   Cell_Phone_Drop_0000_0001.rst   286,678,657                                                                         */
/*   Cell_Phone_Drop_0001_0001.rst   266,764,345                                                                         */
/*   Cell_Phone_Drop_0001.out             29,131                                                                         */
/*   Cell_Phone_Drop_0001.rad                401                                                                         */
/*   starter.log                           4,517                                                                         */
/*   engine.log                           21,832                                                                         */
/*   Cell_Phone_DropT01.csv              306,099                                                                         */
/*   global_energy_data.csv               14,926                                                                         */
/*   results.csv                             138                                                                         */
/*                                                                                                                       */
/* ======================================================================================================================*/
/* STARTER LOG                                                                                                           */
/* ======================================================================================================================*/
/* ************************************************************************                                              */
/* **                        OpenRadioss Starter                         **                                              */
/* **            Non-linear Finite Element Analysis Software             **                                              */
/* **                                                                    **                                              */
/* **                  Windows 64 bits, Intel compiler                   **                                              */
/* **                      Double Precision Version                      **                                              */
/* **                                                                    **                                              */
/* ************************************************************************                                              */
/* ** OpenRadioss Software                                               **                                              */
/* ** COPYRIGHT (C) 1986-2026 Altair Engineering, Inc.                   **                                              */
/* ** Licensed under GNU Affero General Public License.                  **                                              */
/* ** See License file.                                                  **                                              */
/* ************************************************************************                                              */
/*                                                                                                                       */
/*  .. UNITS SYSTEM                                                                                                      */
/*  .. CONTROL VARIABLES                                                                                                 */
/*  .. STARTER RUNNING ON    1 THREAD                                                                                    */
/*  .. FUNCTIONS & TABLES                                                                                                */
/*  .. MATERIALS                                                                                                         */
/*  .. NODES                                                                                                             */
/*  .. PROPERTIES                                                                                                        */
/*  .. 3D SOLID ELEMENTS                                                                                                 */
/*  .. SUBSETS                                                                                                           */
/*  .. ELEMENT GROUPS                                                                                                    */
/*  .. PART GROUPS                                                                                                       */
/*  .. SURFACES                                                                                                          */
/*  .. NODE GROUP                                                                                                        */
/*  .. INITIAL VELOCITIES                                                                                                */
/*  .. DOMAIN DECOMPOSITION                                                                                              */
/*  .. ELEMENT GROUPS                                                                                                    */
/*  .. INTERFACES                                                                                                        */
/*  .. INTERFACE BUFFER INITIALIZATION                                                                                   */
/*                                                                                                                       */
/* WARNING ID :   1873                                                                                                   */
/* ** WARNING: CHECK TIED INTERFACE - PROJECTION ON 3 NODES SEGMENTS                                                     */
/*  .. RIGID WALLS                                                                                                       */
/*  .. RETURNS TO DOMAIN DECOMPOSITION FOR OPTIMIZATION                                                                  */
/*  .. DOMAIN DECOMPOSITION                                                                                              */
/*  .. ELEMENT GROUPS                                                                                                    */
/*  .. INTERFACES                                                                                                        */
/*  .. INTERFACE BUFFER INITIALIZATION                                                                                   */
/* ...                                                                                                                   */
/* ...                                                                                                                   */
/* ...                                                                                                                   */
/* ------------------------------------------------------------------------                                              */
/*                    ** COMPUTE TIME INFORMATION **                                                                     */
/*                                                                                                                       */
/*  EXECUTION STARTED      :      2026/05/22  17:25:05                                                                   */
/*  EXECUTION COMPLETED    :      2026/05/22  17:25:13                                                                   */
/*                                                                                                                       */
/*  ELAPSED TIME...........=          8.00 s                                                                             */
/*                                00:00:08                                                                               */
/* -                       -------------------------------------------------                                             */
/*                                                                                                                       */
/*      TERMINATION WITH WARNING                                                                                         */
/*      ------------------                                                                                               */
/*               0 ERROR(S)                                                                                              */
/*               6 WARNING(S)                                                                                            */
/*                                                                                                                       */
/* PLEASE CHECK LISTING FILE FOR FURTHER DETAILS                                                                         */
/*                                                                                                                       */
/* ======================================================================================================================*/
/* D:/RAD/ENGINE LOG                                                                                                    **/
/* ======================================================================================================================*/
/*                                                                                                                       */
/*   ************************************************************************                                            */
/*   **                                                                    **                                            */
/*   **                         OpenRadioss Engine                         **                                            */
/*   **            Non-linear Finite Element Analysis Software             **                                            */
/*   **                  Windows 64 bits, Intel compiler                   **                                            */
/*   **                      Double Precision Version                      **                                            */
/*   **                                                                    **                                            */
/*   ************************************************************************                                            */
/*   ** OpenRadioss Software                                               **                                            */
/*   ** COPYRIGHT (C) 1986-2026 Altair Engineering, Inc.                   **                                            */
/*   ** Licensed under GNU Affero General Public License.                  **                                            */
/*   ** See License file.                                                  **                                            */
/*   ************************************************************************                                            */
/*                                                                                                                       */
/*    ROOT: Cell_Phone_Drop  RESTART: 0001                                                                               */
/*    NUMBER OF HMPP PROCESSES     1                                                                                     */
/*    19/05/2026                                                                                                         */
/*    NC=       0 T= 0.0000E+00 DT= 9.9045E-09 ERR=  0.0% DM/M= 0.0000E+00                                               */
/*        ANIMATION FILE: Cell_Phone_DropA001 WRITTEN                                                                    */
/*    NC=     100 T= 9.9045E-07 DT= 9.9045E-09 ERR=  0.0% DM/M= 0.0000E+00                                               */
/*    ELAPSED TIME=         32.58 s  REMAINING TIME=       3256.37 s                                                     */
/*        ANIMATION FILE: Cell_Phone_DropA002 WRITTEN                                                                    */
/*    NC=     200 T= 1.9809E-06 DT= 9.9045E-09 ERR=  0.0% DM/M= 0.0000E+00                                               */
/*    ELAPSED TIME=         63.91 s  REMAINING TIME=       3162.44 s                                                     */
/*        ANIMATION FILE: Cell_Phone_DropA003 WRITTEN                                                                    */
/*    NC=     300 T= 2.9713E-06 DT= 9.9045E-09 ERR=  0.0% DM/M= 0.0000E+00                                               */
/*    ELAPSED TIME=         95.35 s  REMAINING TIME=       3113.62 s                                                     */
/*                                                                                                                       */
/*    ...                                                                                                                */
/*    ...                                                                                                                */
/*                          ** SUMMARY **                                                                                */
/*                                                                                                                       */
/*    PROC  CONTSORT  CONTFOR   ELEMENT   KINCOND   INTEG     IO        T0        ASM       RESOL                        */
/*     1   .1625E+03 .9375E-01 .2829E+04 .6688E+01 .5188E+02 .7162E+02 .1627E+03 .6250E-01 .3209E+04                     */
/*                                                                                                                       */
/*                     ** CUMULATIVE CPU TIME SUMMARY **                                                                 */
/*                                                                                                                       */
/*    ONTACT SORTING.............: .1625E+03     5.06 %                                                                  */
/*    ONTACT FORCES..............: .9375E-01     0.00 %                                                                  */
/*    LEMENT FORCES..............: .2829E+04    88.17 %                                                                  */
/*    INEMATIC COND..............: .6688E+01     0.21 %                                                                  */
/*    NTEGRATION.................: .5188E+02     1.62 %                                                                  */
/*    SSEMBLING..................: .6250E-01     0.00 %                                                                  */
/*    THERS (including I/O)......: .1585E+03     4.94 %                                                                  */
/*    OTAL.......................: .3209E+04   100.00 %                                                                  */
/*                                                                                                                       */
/*                     ** MEMORY USAGE STATISTICS **                                                                     */
/*                                                                                                                       */
/*    OTAL MEMORY USED .........................:      503 MB                                                            */
/*    AXIMUM MEMORY PER PROCESSOR...............:      503 MB                                                            */
/*    INIMUM MEMORY PER PROCESSOR...............:      503 MB                                                            */
/*    VERAGE MEMORY PER PROCESSOR...............:      503 MB                                                            */
/*                                                                                                                       */
/*                     ** DISK USAGE STATISTICS **                                                                       */
/*                                                                                                                       */
/*    OTAL DISK SPACE USED .....................:       1858 MB                                                          */
/*    NIMATION/H3D/TH/OUTP SIZE ................:       1603 MB                                                          */
/*    ESTART FILE SIZE .........................:        254 MB                                                          */
/*                                                                                                                       */
/*    LAPSED TIME     =       0:53:38  minutes                                                                           */
  /*                                                                                                                     */
/* ======================================================================================================================*/
/*  D:/RAD/RESULTS.CSV                                                                                                   */
/* ======================================================================================================================*/
/*  T01 TO CSV CONVERTER                                                                                                 */
/*                                                                                                                       */
/*  FILE    = D:\rad\Cell_Phone_DropT01                                                                                  */
/*  OUTPUT FILE    = D:\rad\Cell_Phone_DropT01.csv                                                                       */
/*   ** CONVERSION COMPLETED                                                                                             */
/*                                                                                                                       */
/* ======================================================================================================================*/
/*  Cell_Phone_Drop CSVs                                                                                                 */
/* ======================================================================================================================*/
/*                                                                                                                       */
/*   d:/rad                                                                                                              */
/*      D:\rad\Cell_Phone_DropT01.csv                                                                                    */
/*      D:\rad\global_energy_data.csv                                                                                    */
/*      D:\rad\results.csv                                                                                               */
/*                                                                                                                       */
/*                                                                                                                       */
/* ======================================================================================================================*/
/*  D:\rad\Cell_Phone_DropT01.csv                                                                                        */
/* ======================================================================================================================*/
/*                                                                                                                       */
/*  Middle Observation(500 ) of table = workx.simout - Total Obs 1000                                                    */
/*                                                                                                                       */
/*   -- CHARACTER --                                                                                                     */
/*  Variable                        Typ    Value                                                                         */
/*                                                                                                                       */
/*  SIMULATION                       C14   Cell Drop Test                                                                */
/*                                                                                                                       */
/*   -- NUMERIC --                                                                                                       */
/*  TIME                             N8    0.0000499086                                                                  */
/*  INTERNAL_ENERGY                  N8        7.656168                                                                  */
/*  KINETIC_ENERGY                   N8        389.6605                                                                  */
/*  X_MOMENTUM                       N8      -0.0852198                                                                  */
/*  Y_MOMENTUM                       N8     -0.09353658                                                                  */
/*  Z_MOMENTUM                       N8     -0.07004944                                                                  */
/*  MASS                             N8    0.0000270143                                                                  */
/*  TIME_STEP                        N8      9.90443E-9                                                                  */
/*  ROTATION_ENERGY                  N8               0                                                                  */
/*  EXTERNAL_WORK                    N8      -0.1683699                                                                  */
/*  SPRING_ENERGY                    N8               0                                                                  */
/*  CONTACT_ENERGY                   N8    0.0008799649                                                                  */
/*  HOURGLASS_ENERGY                 N8    3.031299E-13                                                                  */
/*  ELASTIC_CONTACT_ENERGY           N8    0.0008779599                                                                  */
/*  FRICTIONAL_CONTACT_ENERGY        N8               0                                                                  */
/*  DAMPING_CONTACT_ENERGY           N8     2.004972E-6                                                                  */
/*  PLASTIC_WORK                     N8        1.035731                                                                  */
/*  ADDED_MASS                       N8    -1.93124E-18                                                                  */
/*  PERCENTAGE_ADDED_MASS            N8    -7.14893E-12                                                                  */
/*  INLET_MASS                       N8               0                                                                  */
/*  OUTLET_MASS                      N8               0                                                                  */
/*  INLET_ENERGY                     N8               0                                                                  */
/*  OUTLET_ENERGY                    N8               0                                                                  */
/*  ENERGY_BALANCE                   N8    -2359.784427                                                                  */
/*  PLASTIC_FRACTION                 N8    0.1352805999                                                                  */
/*************************************************************************************************************************/

/*                                    _ _                 _
  ___  _ __   ___ _ __  _ __ __ _  __| (_) ___  ___ ___  | | ___   __ _
 / _ \| `_ \ / _ \ `_ \| `__/ _` |/ _` | |/ _ \/ __/ __| | |/ _ \ / _` |
| (_) | |_) |  __/ | | | | | (_| | (_| | | (_) \__ \__ \ | | (_) | (_| |
 \___/| .__/ \___|_| |_|_|  \__,_|\__,_|_|\___/|___/___/ |_|\___/ \__, |
      |_|                                                         |___/
*/

1                                          Altair SLC            17:25 Friday, May 22, 2026

NOTE: Copyright 2002-2025 World Programming, an Altair Company
NOTE: Altair SLC 2026 (05.26.01.00.000758)
      Licensed to Roger DeAngelis
NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
NOTE: AUTOEXEC source line
1       +  ï»¿ods _all_ close;
           ^
ERROR: Expected a statement keyword : found "?"

NOTE: AUTOEXEC processing completed

1         data _null_;
2          file "d:/rad/Cell_Phone_Drop_0001.rad";
3          input;
4          _infile_=trim(_infile_);
5          put _infile_;
6          putlog _infile_;
7         cards4;

NOTE: The file 'd:\rad\Cell_Phone_Drop_0001.rad' is:
      Filename='d:\rad\Cell_Phone_Drop_0001.rad',
      Owner Name=SLC\suzie,
      File size (bytes)=0,
      Create Time=17:25:00 May 22 2026,
      Last Accessed=17:25:00 May 22 2026,
      Last Modified=17:25:00 May 22 2026,
      Lrecl=32767, Recfm=V

/ANIM/DT
#   TSTART     TFREQ
0.000000 1e-6
# --- ADD STRESS AND STRAIN OUTPUT FOR BRICK ELEMENTS ---
/ANIM/BRICK/TENS/STRESS/ALL
/ANIM/BRICK/TENS/STRAIN/ALL
# --- CONTINUE WITH OTHER ANIM CARDS ---
/ANIM/GPS/TENS
/DT1TET10
/NEGVOL/STOP
/PARITH/OFF
# Emax Mmax Nmax NTH NANIM NERR_POSIT
0.99 0.05 0 1 1 1
/TFILE/0
#            dT_HIS
1e-7
/RUN/Cell_Phone_Drop/1/
               1e-4
NOTE: 18 records were written to file 'd:\rad\Cell_Phone_Drop_0001.rad'
      The minimum record length was 4
      The maximum record length was 57
NOTE: The data step took :
      real time : 0.000
      cpu time  : 0.015


8         /ANIM/DT
9         #   TSTART     TFREQ
10        0.000000 1e-6
11        # --- ADD STRESS AND STRAIN OUTPUT FOR BRICK ELEMENTS ---
12        /ANIM/BRICK/TENS/STRESS/ALL
13        /ANIM/BRICK/TENS/STRAIN/ALL
14        # --- CONTINUE WITH OTHER ANIM CARDS ---
15        /ANIM/GPS/TENS
16        /DT1TET10
17        /NEGVOL/STOP
18        /PARITH/OFF
19        # Emax Mmax Nmax NTH NANIM NERR_POSIT
20        0.99 0.05 0 1 1 1
21        /TFILE/0
22        #            dT_HIS
23        1e-7
24        /RUN/Cell_Phone_Drop/1/
25                       1e-4
26        ;;;;
27        run;
28
29
30        /*--- START HERE ---*/
31        /*--- START HERE ---*/
32
33        /*--- CREATE SIEMEN ANIMATION AND TIME HISTORY CSV FILE  ---*/
34
35        options validvarname=v7;
36        options set=PYTHONHOME "D:\py314";
37        proc python;
38        submit;
39        import os
40        import pandas as pd
41        import subprocess
42        from pathlib import Path
43
44        # ============================================================================
45        # CONFIGURATION
46        # ============================================================================
47
48        OPENRADIOSS_PATH = Path("C:/openradioss")
49        STARTER_EXE = OPENRADIOSS_PATH / "exec" / "starter_win64.exe"
50        ENGINE_EXE = OPENRADIOSS_PATH / "exec" / "engine_win64.exe"
51        TH_TO_CSV_EXE = OPENRADIOSS_PATH / "exec" / "th_to_csv_win64.exe"
52
53        MODEL_DIR = Path("D:/rad")
54        STARTER_FILE = "Cell_Phone_Drop_0000.rad"
55        ENGINE_FILE =  "Cell_Phone_Drop_0001.rad"
56
57        # Time history file (output from simulation)
58        TH_FILE = MODEL_DIR / "Cell_Phone_DropT01"
59        # CSV output file
60        CSV_FILE = MODEL_DIR / "results.csv"
61
62        SETVARS_PATH = Path("C:/Program Files (x86)/Intel/oneAPI/setvars.bat")
63        OMP_NUM_THREADS = "1"
64        KMP_STACKSIZE = "400m"
65
66        # ============================================================================
67        # ENVIRONMENT SETUP
68        # ============================================================================
69
70        def setup_environment():
71            env = os.environ.copy()
72            env["OPENRADIOSS_PATH"] = str(OPENRADIOSS_PATH)
73            env["RAD_CFG_PATH"] = str(OPENRADIOSS_PATH / "hm_cfg_files")
74            env["RAD_H3D_PATH"] = str(OPENRADIOSS_PATH / "extlib" / "h3d" / "lib" / "win64")
75            env["OMP_NUM_THREADS"] = OMP_NUM_THREADS
76            env["KMP_STACKSIZE"] = KMP_STACKSIZE
77
78            hm_reader = OPENRADIOSS_PATH / "extlib" / "hm_reader" / "win64"
79            if hm_reader.exists():
80                env["PATH"] = str(hm_reader) + ";" + env.get("PATH", "")
81
82            # Add tools directory to PATH for th_to_csv
83            tools_dir = OPENRADIOSS_PATH / "tools"
84            if tools_dir.exists():
85                env["PATH"] = str(tools_dir) + ";" + env.get("PATH", "")
86
87            return env
88
89        def run_cmd(cmd, cwd, env, log_file):
90            """Run command and capture output to log file"""
91            with open(log_file, 'w') as f:
92                result = subprocess.run(cmd, shell=True, cwd=cwd, env=env,
93                                        stdout=f, stderr=subprocess.STDOUT, text=True)
94            return result.returncode
95
96        def convert_th_to_csv(th_file, csv_file, env):
97            """Convert time history binary file to CSV format"""
98            if not th_file.exists():
99                print(f"Warning: Time history file not found: {th_file}")
100               return False
101
102           if not TH_TO_CSV_EXE.exists():
103               print(f"Warning: th_to_csv_win64.exe not found at {TH_TO_CSV_EXE}")
104               return False
105
106           print(f"Converting time history: {th_file.name} -> {csv_file.name}")
107
108           # Run th_to_csv and redirect output to CSV file
109           cmd = f'"{TH_TO_CSV_EXE}" "{th_file}"'
110
111           try:
112               with open(csv_file, 'w') as f:
113                   result = subprocess.run(cmd, shell=True, cwd=str(MODEL_DIR), env=env,
114                                           stdout=f, stderr=subprocess.PIPE, text=True)
115
116               if result.returncode == 0 and csv_file.exists() and csv_file.stat().st_size > 0:
117                   # Count lines to verify data
118                   with open(csv_file, 'r') as f:
119                       line_count = sum(1 for _ in f)
120                   print(f"  [OK] Created {csv_file.name} ({line_count} lines, {csv_file.stat().st_size / 1024:.1f} KB)")
121
122                   # Show first few lines as preview
123                   with open(csv_file, 'r') as f:
124                       header = f.readline().strip()
125                       first_data = f.readline().strip() if line_count > 1 else ""
126                   print(f"  Header: {header[:100]}...")
127                   return True
128               else:
129                   print(f"  [FAILED] Conversion failed (exit code {result.returncode})")
130                   if result.stderr:
131                       print(f"    Error: {result.stderr[:200]}")
132                   return False
133           except Exception as e:
134               print(f"  [ERROR] {e}")
135               return False
136
137       # ============================================================================
138       # MAIN EXECUTION
139       # ============================================================================
140
141       def main():
142           print("=" * 60)
143           print("OpenRadioss Tensile Test Simulation")
144           print("=" * 60)
145
146           # Quick verification
147           if not STARTER_EXE.exists() or not ENGINE_EXE.exists():
148               print("ERROR: OpenRadioss executables not found")
149               return 1
150
151           env = setup_environment()
152           setvars = f'call "{SETVARS_PATH}" intel64 vs2022 > nul 2>&1 && ' if SETVARS_PATH.exists() else ""
153
154           # Run Starter
155           print("\n[1/3] Running Starter...")
156           starter_input = MODEL_DIR / STARTER_FILE
157           rc = run_cmd(f'{setvars}"{STARTER_EXE}" -i "{starter_input}"',
158                         str(MODEL_DIR), env, MODEL_DIR / "starter.log")
159           if rc != 0:
160               print(f"Starter failed (exit {rc}). Check starter.log")
161               return rc
162
163           # Run Engine
164           print("[2/3] Running Engine...")
165           engine_input = MODEL_DIR / ENGINE_FILE
166           rc = run_cmd(f'{setvars}"{ENGINE_EXE}" -i "{engine_input}"',
167                         str(MODEL_DIR), env, MODEL_DIR / "engine.log")
168           if rc != 0:
169               print(f"Engine failed (exit {rc}). Check engine.log")
170               return rc
171
172           # List animation files created
173           anim_files = list(MODEL_DIR.glob("*.A0*")) + list(MODEL_DIR.glob("*.h3d"))
174           if anim_files:
175               print(f"\nAnimation files created ({len(anim_files)}):")
176               for f in sorted(anim_files):
177                   size_kb = f.stat().st_size / 1024
178                   print(f"  {f.name} ({size_kb:.1f} KB)")
179           else:
180               print("\nWarning: No animation files found")
181
182           # Convert time history to CSV
183           print("\n[3/3] Converting time history to CSV...")
184           convert_th_to_csv(TH_FILE, CSV_FILE, env)
185
186           # Summary
187           print("\n" + "=" * 60)
188           print("SIMULATION COMPLETE")
189           print("=" * 60)
190           print(f"Results saved to: {MODEL_DIR}")
191           print(f"  - Time history CSV: {CSV_FILE.name}")
192           print(f"  - Starter log: starter.log")
193           print(f"  - Engine log: engine.log")
194           if anim_files:
195               print(f"  - Animation files: {len(anim_files)} files")
196
197           # Verify CSV was created
198           if CSV_FILE.exists():
199               print(f"\nCSV file size: {CSV_FILE.stat().st_size / 1024:.1f} KB")
200               print("You can now open results.csv in Excel or Python for analysis.")
201
202           print("\nDone.")
203           return 0
204
205       if __name__ == "__main__":
206           exit(main());
207       endsubmit;

NOTE: Submitting statements to Python:


208       run;
NOTE: Procedure python step took :
      real time : 1:36:57.719
      cpu time  : 0:00:00.031


ERROR: Error printed on page 1

NOTE: Submitted statements took :
      real time : 1:36:57.787
      cpu time  : 0:00:00.109

/*  _                      _          _     _     _                    _        _     _
| || |     ___ _____   __ | |_ ___   | |__ (_)___| |_ ___  _ __ _   _ | |_ __ _| |__ | | ___
| || |_   / __/ __\ \ / / | __/ _ \  | `_ \| / __| __/ _ \| `__| | | || __/ _` | `_ \| |/ _ \
|__   _| | (__\__ \\ V /  | || (_) | | | | | \__ \ || (_) | |  | |_| || || (_| | |_) | |  __/
   |_|    \___|___/ \_/    \__\___/  |_| |_|_|___/\__\___/|_|   \__, | \__\__,_|_.__/|_|\___|
                                                                |___/
*/

options ls=255;
data workx.simraw ;

 retain simulation "Cell Drop Test";

 infile 'D:\rad\Cell_Phone_DropT01.csv' delimiter = ',' MISSOVER DSD lrecl=384 firstobs=2 ;

  informat
    TIME
    INTERNAL_ENERGY
    KINETIC_ENERGY
    X_MOMENTUM
    Y_MOMENTUM
    Z_MOMENTUM
    MASS
    TIME_STEP
    ROTATION_ENERGY
    EXTERNAL_WORK
    SPRING_ENERGY
    CONTACT_ENERGY
    HOURGLASS_ENERGY
    ELASTIC_CONTACT_ENERGY
    FRICTIONAL_CONTACT_ENERGY
    DAMPING_CONTACT_ENERGY
    PLASTIC_WORK
    ADDED_MASS
    PERCENTAGE_ADDED_MASS
    INLET_MASS
    OUTLET_MASS
    INLET_ENERGY
    OUTLET_ENERGY  best32.;

   input
     time
     INTERNAL_ENERGY
     KINETIC_ENERGY
     X_MOMENTUM
     Y_MOMENTUM
     Z_MOMENTUM
     MASS
     TIME_STEP
     ROTATION_ENERGY
     EXTERNAL_WORK
     SPRING_ENERGY
     CONTACT_ENERGY
     HOURGLASS_ENERGY
     ELASTIC_CONTACT_ENERGY
     FRICTIONAL_CONTACT_ENERGY
     DAMPING_CONTACT_ENERGY
     PLASTIC_WORK
     ADDED_MASS
     PERCENTAGE_ADDED_MASS
     INLET_MASS
     OUTLET_MASS
     INLET_ENERGY
     OUTLET_ENERGY
     ;
 /*drop
    ADDED_MASS
    CONTACT_ENERGY
    DAMPING_CONTACT_ENERGY
    ELASTIC_CONTACT_ENERGY
    FRICTIONAL_CONTACT_ENERGY
    HOURGLASS_ENERGY
    INLET_ENERGY
    INLET_MASS
    MASS
    OUTLET_ENERGY
    OUTLET_MASS
    PERCENTAGE_ADDED_MASS
    ROTATION_ENERGY
    SPRING_ENERGY
    Z_MOMENTUM */
    ;
run;quit;

data workx.simout;

    set workx.simraw;

    /* Energy balance ratio */
    ENERGY_BALANCE = (INTERNAL_ENERGY + KINETIC_ENERGY) / EXTERNAL_WORK;

    /* Plastic work fraction */
    PLASTIC_FRACTION = PLASTIC_WORK / INTERNAL_ENERGY;

    /* Time step change flag */
    TIME_STEP_CHANGE = dif(TIME_STEP);

    label ENERGY_BALANCE = "Energy Balance Ratio"
          PLASTIC_FRACTION = "Plastic Work Fraction";
run;


options ls=255;
/* Generate summary statistics */
proc means data=workx.simout n mean std min max;
run;

/**************************************************************************************************************************/
/*  The MEANS Procedure                                                                                                   */
/* Variable                   Label                     N            Mean         Std Dev       Minimum         Maximum   */
/* --------------------------------------------------------------------------------------------------------------------   */
/* TIME                                              1000     0.000049955     0.000028882             0     0.000099905   */
/* INTERNAL_ENERGY                                   1000       9.7504340       8.3685970             0      26.9381700   */
/* KINETIC_ENERGY                                    1000     387.2435429       9.0085575   368.2010000     397.5139000   */
/* X_MOMENTUM                                        1000      -0.0848547       0.0012631    -0.0862590      -0.0821144   */
/* Y_MOMENTUM                                        1000      -0.0931235       0.0013634    -0.0946222      -0.0901083   */
/* Z_MOMENTUM                                        1000      -0.0699558     0.000482025    -0.0705585      -0.0689771   */
/* MASS                                              1000     0.000027014               0   0.000027014     0.000027014   */
/* TIME_STEP                                         1000    9.9043422E-9    1.825991E-13   9.903843E-9     9.904499E-9   */
/* ROTATION_ENERGY                                   1000               0               0             0               0   */
/* EXTERNAL_WORK                                     1000      -0.4822229       0.6324524    -2.2667960       0.0163111   */
/* SPRING_ENERGY                                     1000               0               0             0               0   */
/* CONTACT_ENERGY                                    1000       0.0012560       0.0010491             0       0.0032004   */
/* HOURGLASS_ENERGY                                  1000    4.4694815E-7    1.1014979E-6             0     5.900859E-6   */
/* ELASTIC_CONTACT_ENERGY                            1000       0.0012537       0.0010473             0       0.0031948   */
/* FRICTIONAL_CONTACT_ENERGY                         1000               0               0             0               0   */
/* DAMPING_CONTACT_ENERGY                            1000    2.3286848E-6    1.7819418E-6             0     5.653081E-6   */
/* PLASTIC_WORK                                      1000       2.1473965       2.5134786             0       8.5960570   */
/* ADDED_MASS                                        1000    -1.93124E-18               0  -1.93124E-18    -1.93124E-18   */
/* PERCENTAGE_ADDED_MASS                             1000    -7.14893E-12               0  -7.14893E-12    -7.14893E-12   */
/* INLET_MASS                                        1000               0               0             0               0   */
/* OUTLET_MASS                                       1000               0               0             0               0   */
/* INLET_ENERGY                                      1000               0               0             0               0   */
/* OUTLET_ENERGY                                     1000               0               0             0               0   */
/* ENERGY_BALANCE             Energy Balance Ratio    999        17615.51       195819.76   -3005506.34      3653617.78   */
/* PLASTIC_FRACTION           Plastic Work Fraction   999       0.1348256       0.1012003             0       0.3191032   */
/* TIME_STEP_CHANGE                                   999    -6.48649E-16    1.036254E-15        -2E-14           1E-15   */
/*                                                                                                                        */
/**************************************************************************************************************************/


/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

1                                          Altair SLC          12:58 Saturday, May 23, 2026

NOTE: Copyright 2002-2025 World Programming, an Altair Company
NOTE: Altair SLC 2026 (05.26.01.00.000758)
      Licensed to Roger DeAngelis
NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
NOTE: AUTOEXEC source line
1       +  ï»¿ods _all_ close;
           ^

NOTE: AUTOEXEC processing completed

1          options ls=255;
2         data workx.simraw ;
3
4          retain simulation "Cell Drop Test";
5
6          infile 'D:\rad\Cell_Phone_DropT01.csv' delimiter = ',' MISSOVER DSD lrecl=384 firstobs=2 ;
7
8           informat
9             TIME
10            INTERNAL_ENERGY
11            KINETIC_ENERGY
12            X_MOMENTUM
13            Y_MOMENTUM
14            Z_MOMENTUM
15            MASS
16            TIME_STEP
17            ROTATION_ENERGY
18            EXTERNAL_WORK
19            SPRING_ENERGY
20            CONTACT_ENERGY
21            HOURGLASS_ENERGY
22            ELASTIC_CONTACT_ENERGY
23            FRICTIONAL_CONTACT_ENERGY
24            DAMPING_CONTACT_ENERGY
25            PLASTIC_WORK
26            ADDED_MASS
27            PERCENTAGE_ADDED_MASS
28            INLET_MASS
29            OUTLET_MASS
30            INLET_ENERGY
31            OUTLET_ENERGY  best32.;
32
33           input
34             time
35             INTERNAL_ENERGY
36             KINETIC_ENERGY
37             X_MOMENTUM
38             Y_MOMENTUM
39             Z_MOMENTUM
40             MASS
41             TIME_STEP
42             ROTATION_ENERGY
43             EXTERNAL_WORK
44             SPRING_ENERGY
45             CONTACT_ENERGY
46             HOURGLASS_ENERGY
47             ELASTIC_CONTACT_ENERGY
48             FRICTIONAL_CONTACT_ENERGY
49             DAMPING_CONTACT_ENERGY
50             PLASTIC_WORK
51             ADDED_MASS
52             PERCENTAGE_ADDED_MASS
53             INLET_MASS
54             OUTLET_MASS
55             INLET_ENERGY
56             OUTLET_ENERGY
57             ;
58         /*drop
59            ADDED_MASS
60            CONTACT_ENERGY
61            DAMPING_CONTACT_ENERGY
62            ELASTIC_CONTACT_ENERGY
63            FRICTIONAL_CONTACT_ENERGY
64            HOURGLASS_ENERGY
65            INLET_ENERGY
66            INLET_MASS
67            MASS
68            OUTLET_ENERGY
69            OUTLET_MASS
70            PERCENTAGE_ADDED_MASS
71            ROTATION_ENERGY
72            SPRING_ENERGY
73            Z_MOMENTUM */
74            ;
75        run;

NOTE: The infile 'D:\rad\Cell_Phone_DropT01.csv' is:
      Filename='D:\rad\Cell_Phone_DropT01.csv',
      Owner Name=SLC\suzie,
      File size (bytes)=306099,
      Create Time=12:37:13 May 23 2026,
      Last Accessed=12:37:22 May 23 2026,
      Last Modified=19:01:57 May 22 2026,
      Lrecl=384, Recfm=V

NOTE: 1000 records were read from file 'D:\rad\Cell_Phone_DropT01.csv'
      The minimum record length was 303
      The maximum record length was 304
NOTE: Data set "WORKX.simraw" has 1000 observation(s) and 24 variable(s)
NOTE: The data step took :
      real time : 0.222
      cpu time  : 0.000


75      !     quit;
76
77        data workx.simout;
78
79            set workx.simraw;
80
81            /* Energy balance ratio */
82            ENERGY_BALANCE = (INTERNAL_ENERGY + KINETIC_ENERGY) / EXTERNAL_WORK;
83
84            /* Plastic work fraction */
85            PLASTIC_FRACTION = PLASTIC_WORK / INTERNAL_ENERGY;
86
87            /* Time step change flag */
88            TIME_STEP_CHANGE = dif(TIME_STEP);
89
90            label ENERGY_BALANCE = "Energy Balance Ratio"
91                  PLASTIC_FRACTION = "Plastic Work Fraction";
92        run;

NOTE: A divide by zero condition was detected at line 82 column 57
NOTE: Missing values resulted from performing arithmetic upon missing values.
      Each place is given by: (Number of times) at (Line):(Column)
      1 at 85:37   1 at 88:24
NOTE: 1000 observations were read from "WORKX.simraw"
NOTE: Data set "WORKX.simout" has 1000 observation(s) and 27 variable(s)
NOTE: The data step took :
      real time : 0.095
      cpu time  : 0.015


93
94
95        options ls=255;
96        /* Generate summary statistics */
97        proc means data=workx.simout n mean std min max;
98        run;
NOTE: 1000 observations were read from "WORKX.simout"
NOTE: Procedure means step took :
      real time : 0.508
      cpu time  : 0.046


99
ERROR: Error printed on page 1

NOTE: Submitted statements took :
      real time : 2.042
      cpu time  : 0.156


/*___                                       _       _
| ___|  _ __ ___   __ _ _ __  _   _   _ __ | | ___ | |_ ___
|___ \ | `_ ` _ \ / _` | `_ \| | | | | `_ \| |/ _ \| __/ __|
 ___) || | | | | | (_| | | | | |_| | | |_) | | (_) | |_\__ \
|____/ |_| |_| |_|\__,_|_| |_|\__, | | .__/|_|\___/ \__|___/
                              |___/  |_|
*/

%utlfkil(d:/rad/energy_evolution.png);

ods listing close;
ods graphics on / reset=all imagename="energy_evolution" outputfmt=png;
ods printer file="d:/rad/energy_evolution.png" dpi=100;
proc sgplot data=workx.simout;

    title "Energy Evolution - Early Phase (First 1 Time Unit)";
    title2 "Internal vs Kinetic Energy";

    series x=time y=INTERNAL_ENERGY /
           lineattrs=(color=blue thickness=2)
           name="Internal"
           legendlabel="Internal Energy";

    series x=time y=KINETIC_ENERGY /
           lineattrs=(color=red thickness=2)
           y2axis
           name="Kinetic"
           legendlabel="Kinetic Energy";

    series x=time y=PLASTIC_WORK /
           lineattrs=(color=green thickness=2 pattern=shortdash)
           name="Plastic"
           legendlabel="Plastic Work";

     refline 0.000027 / axis=x label="Impact"
                 lineattrs=(color=red pattern=dash thickness=1.5);

    inset "Impact: 0.000027 s"
          "Transition Kinetic"
          "to Internal Energy" /
          position=left border;

    xaxis label="Time" grid;
    yaxis label="Internal Energy & Plastic Work" grid;
    y2axis label="Kinetic Energy";

run;

ods printer close;
ods graphics off;
ods listing;


%utlfkil(d:/rad/ymomentumevolve.png);

ods listing close;
ods graphics on / reset=all imagename="ymomentumevolve" outputfmt=png;
ods printer file="d:/rad/ymomentumevolve.png" dpi=100;

proc sgplot data=workx.simout;
    title "Y-Momentum Evolution";
    title2 "Primary Direction Impulse";

    series x=time y=Y_MOMENTUM /
           lineattrs=(color=darkblue thickness=2)
           markerattrs=(color=darkblue symbol=circlefilled size=5);

    xaxis label="Time" grid;
    yaxis label="Y-Momentum" grid;
run;

ods printer close;
ods _all_ close;
ods listing;


%utlfkil(d:/rad/xmomentumevolve.png);

ods listing close;
ods graphics on / reset=all imagename="xmomentumevolve" outputfmt=png;
ods printer file="d:/rad/xmomentumevolve.png" dpi=100;

proc sgplot data=workx.simout;
    title "X-Momentum Evolution";
    title2 "Primary Direction Impulse";

    series x=time y=X_MOMENTUM /
           lineattrs=(color=darkblue thickness=2)
           markerattrs=(color=darkblue symbol=circlefilled size=5);

    xaxis label="Time" grid;
    yaxis label="X-Momentum" grid;
run;

ods printer close;
ods _all_ close;
ods listing;


%utlfkil(d:/rad/timestephistory.png);

ods listing close;
ods graphics on / reset=all imagename="timestephistory" outputfmt=png;
ods printer file="d:/rad/timestephistory.png" dpi=100;

/* Time step history with change detection */
proc sgplot data=workx.simout;
    title "Time Step Evolution";
    title2 "Solver Adaptation to Simulation Complexity";

    /* Use scatter for better visibility of changes */
    scatter x=time y=TIME_STEP /
            markerattrs=(color=red symbol=circle size=6);

    /* Smooth line through the points */
    pbspline x=time y=TIME_STEP /
             lineattrs=(color=blue thickness=1)
             nomarkers;

    xaxis label="Time" grid;
    yaxis label="Time Step"
          type=log /* Log scale often helpful for time step */
          logbase=10
          logstyle=linear
          grid;

    inset "Initial Time Step: 0.0002"
          "Final Time Step: 0. 018" /
          position=bottomright border;
run;quit;

ods printer close;
ods graphics off;
ods listing;

%utlfkil(d:/rad/energybalance.png);

ods listing close;
ods graphics on / reset=all imagename="energybalance" outputfmt=png;
ods printer file="d:/rad/energybalance.png" dpi=100;

/* Energy conservation check */
proc sgplot data=workx.simout;
    title "Energy Balance Verification";
    title2 "(Internal + Kinetic) / External Work";

     band x=time upper=1.0005 lower=0.9995 /
         fillattrs=(color=lightgreen transparency=0.7)
         legendlabel="±5% Tolerance";

    series x=time y=ENERGY_BALANCE /
           lineattrs=(color=black thickness=2);

    refline 1 / axis=y label="Perfect Conservation"
                lineattrs=(color=blue pattern=dash thickness=1.5);

    refline 0.000027 / axis=x label="Impact"
                lineattrs=(color=red pattern=dash thickness=1.5);

    xaxis label="Time" ;
    yaxis label="Energy Balance Ratio"
          /* values=(0.9995 to 1.0005 by 0.0002) */
          ;
run;

ods printer close;
ods graphics off;
ods listing;

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

%utlfkil(d:/rad/energy_evolution.png);

ods listing close;
ods graphics on / reset=all imagename="energy_evolution" outputfmt=png;
ods printer file="d:/rad/energy_evolution.png" dpi=100;
proc sgplot data=workx.simout;

    title "Energy Evolution - Early Phase (First 1 Time Unit)";
    title2 "Internal vs Kinetic Energy";

    series x=time y=INTERNAL_ENERGY /
           lineattrs=(color=blue thickness=2)
           name="Internal"
           legendlabel="Internal Energy";

    series x=time y=KINETIC_ENERGY /
           lineattrs=(color=red thickness=2)
           y2axis
           name="Kinetic"
           legendlabel="Kinetic Energy";

    series x=time y=PLASTIC_WORK /
           lineattrs=(color=green thickness=2 pattern=shortdash)
           name="Plastic"
           legendlabel="Plastic Work";

     refline 0.000027 / axis=x label="Impact"
                 lineattrs=(color=red pattern=dash thickness=1.5);

    inset "Impact: 0.000027 s"
          "Transition Kinetic"
          "to Internal Energy" /
          position=left border;

    xaxis label="Time" grid;
    yaxis label="Internal Energy & Plastic Work" grid;
    y2axis label="Kinetic Energy";

run;

ods printer close;
ods graphics off;
ods listing;


%utlfkil(d:/rad/ymomentumevolve.png);

ods listing close;
ods graphics on / reset=all imagename="ymomentumevolve" outputfmt=png;
ods printer file="d:/rad/ymomentumevolve.png" dpi=100;

proc sgplot data=workx.simout;
    title "Y-Momentum Evolution";
    title2 "Primary Direction Impulse";

    series x=time y=Y_MOMENTUM /
           lineattrs=(color=darkblue thickness=2)
           markerattrs=(color=darkblue symbol=circlefilled size=5);

    xaxis label="Time" grid;
    yaxis label="Y-Momentum" grid;
run;

ods printer close;
ods _all_ close;
ods listing;


%utlfkil(d:/rad/xmomentumevolve.png);

ods listing close;
ods graphics on / reset=all imagename="xmomentumevolve" outputfmt=png;
ods printer file="d:/rad/xmomentumevolve.png" dpi=100;

proc sgplot data=workx.simout;
    title "X-Momentum Evolution";
    title2 "Primary Direction Impulse";

    series x=time y=X_MOMENTUM /
           lineattrs=(color=darkblue thickness=2)
           markerattrs=(color=darkblue symbol=circlefilled size=5);

    xaxis label="Time" grid;
    yaxis label="X-Momentum" grid;
run;

ods printer close;
ods _all_ close;
ods listing;


%utlfkil(d:/rad/timestephistory.png);

ods listing close;
ods graphics on / reset=all imagename="timestephistory" outputfmt=png;
ods printer file="d:/rad/timestephistory.png" dpi=100;

/* Time step history with change detection */
proc sgplot data=workx.simout;
    title "Time Step Evolution";
    title2 "Solver Adaptation to Simulation Complexity";

    /* Use scatter for better visibility of changes */
    scatter x=time y=TIME_STEP /
            markerattrs=(color=red symbol=circle size=6);

    /* Smooth line through the points */
    pbspline x=time y=TIME_STEP /
             lineattrs=(color=blue thickness=1)
             nomarkers;

    xaxis label="Time" grid;
    yaxis label="Time Step"
          type=log /* Log scale often helpful for time step */
          logbase=10
          logstyle=linear
          grid;

    inset "Initial Time Step: 0.0002"
          "Final Time Step: 0. 018" /
          position=bottomright border;
run;quit;

ods printer close;
ods graphics off;
ods listing;

%utlfkil(d:/rad/energybalance.png);

ods listing close;
ods graphics on / reset=all imagename="energybalance" outputfmt=png;
ods printer file="d:/rad/energybalance.png" dpi=100;

/* Energy conservation check */
proc sgplot data=workx.simout;
    title "Energy Balance Verification";
    title2 "(Internal + Kinetic) / External Work";

     band x=time upper=1.0005 lower=0.9995 /
         fillattrs=(color=lightgreen transparency=0.7)
         legendlabel="Â±5% Tolerance";

    series x=time y=ENERGY_BALANCE /
           lineattrs=(color=black thickness=2);

    refline 1 / axis=y label="Perfect Conservation"
                lineattrs=(color=blue pattern=dash thickness=1.5);

    refline 0.000027 / axis=x label="Impact"
                lineattrs=(color=red pattern=dash thickness=1.5);

    xaxis label="Time" ;
    yaxis label="Energy Balance Ratio"
          /* values=(0.9995 to 1.0005 by 0.0002) */
          ;
run;

ods printer close;
ods graphics off;
ods listing;

/*__                    _                 _   _               _               _   _       __ _ _
 / /_    __ _ _ __ ___ (_)_ __ ___   __ _| |_(_) ___  _ __   | |_ ___  __   _| |_| | __  / _(_) | ___  ___
| `_ \  / _` | `_ ` _ \| | `_ ` _ \ / _` | __| |/ _ \| `_ \  | __/ _ \ \ \ / / __| |/ / | |_| | |/ _ \/ __|
| (_) || (_| | | | | | | | | | | | | (_| | |_| | (_) | | | | | || (_) | \ V /| |_|   <  |  _| | |  __/\__ \
 \___/  \__,_|_| |_| |_|_|_| |_| |_|\__,_|\__|_|\___/|_| |_|  \__\___/   \_/  \__|_|\_\ |_| |_|_|\___||___/
*/
*/

/*--- CONVERT ANIMATION FILES TO VTK ---*/

options validvarname=v7;
options set=PYTHONHOME "D:\py314";
proc python;
submit;
import subprocess
import os
from pathlib import Path

# Binary-safe conversion
rad_dir = Path("D:/rad")
converter = Path("C:/openradioss/exec/anim_to_vtk_win64.exe")

# Find all ANIM files (no extension, contains pattern)
anim_files = [f for f in rad_dir.iterdir()
              if f.is_file() and "Cell_Phone_DropA" in f.name and f.suffix == ""]

for anim_file in sorted(anim_files):
    output_file = anim_file.with_suffix(".vtk")
    print(f"Converting: {anim_file.name}")

    # Binary-safe: Use subprocess with stdout capture as bytes
    result = subprocess.run(
        [str(converter), str(anim_file)],
        capture_output=True,
        check=False
    )

    # Write binary output directly (no text conversion)
    with open(output_file, 'wb') as f:
        f.write(result.stdout)

    if result.returncode == 0 and output_file.stat().st_size > 0:
        # Verify VTK header
        with open(output_file, 'rb') as f:
            if f.read(5) == b'# vtk':
                print(f"  [OK] Valid VTK file ({output_file.stat().st_size} bytes)")
            else:
                print(f"  [WARNING] Invalid VTK header")
    else:
        print(f"  [FAILED] Return code: {result.returncode}")
endsubmit;
run;

/**************************************************************************************************************************/
/*  Altair SLC                                                                                                            */
/*                                                                                                                        */
/* Converting: Cell_Phone_DropA001                                                                                        */
/*   [OK] Valid VTK file (63378912 bytes)                                                                                 */
/*                                                                                                                        */
/* Converting: Cell_Phone_DropA002                                                                                        */
/*   [OK] Valid VTK file (164322370 bytes)                                                                                */
/*                                                                                                                        */
/* Converting: Cell_Phone_DropA003                                                                                        */
/*   [OK] Valid VTK file (164949354 bytes)                                                                                */
/* ...                                                                                                                    */
/* ...                                                                                                                    */
/* Converting: Cell_Phone_DropA004                                                                                        */
/*   [OK] Valid VTK file (154571109 bytes)                                                                                */
/*                                                                                                                        */
/* Converting: Cell_Phone_DropA100                                                                                        */
/*   [OK] Valid VTK file (154524209 bytes)                                                                                */
/*                                                                                                                        */
/* Converting: Cell_Phone_DropA101                                                                                        */
/*   [OK] Valid VTK file (154473369 bytes)                                                                                */
/**************************************************************************************************************************/


1                                          Altair SLC          13:10 Saturday, May 23, 2026

NOTE: Copyright 2002-2025 World Programming, an Altair Company
NOTE: Altair SLC 2026 (05.26.01.00.000758)
      Licensed to Roger DeAngelis
NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
NOTE: AUTOEXEC source line
1       +  ï»¿ods _all_ close;
           ^
ERROR: Expected a statement keyword : found "?"
NOTE: Library workx assigned as follows:
      Engine:        SAS7BDAT
      Physical Name: d:\wpswrkx

NOTE: Library wpdx assigned as follows:
      Engine:        WPD
      Physical Name: d:\wpswrkx

NOTE: Library slchelp assigned as follows:
      Engine:        WPD
      Physical Name: C:\Progra~1\Altair\SLC\2026\sashelp


LOG:  13:10:01
NOTE: 1 record was written to file PRINT

NOTE: The data step took :
      real time : 0.031
      cpu time  : 0.000


NOTE: Format num2mis output
NOTE: Format $chr2mis output
NOTE: Procedure format step took :
      real time : 0.000
      cpu time  : 0.000

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

NOTE: AUTOEXEC processing completed

1          options validvarname=v7;
2         options set=PYTHONHOME "D:\py314";
3         proc python;
4         submit;
5         import subprocess
6         import os
7         from pathlib import Path
8
9         # Binary-safe conversion
10        rad_dir = Path("D:/rad")
11        converter = Path("C:/openradioss/exec/anim_to_vtk_win64.exe")
12
13        # Find all ANIM files (no extension, contains pattern)
14        anim_files = [f for f in rad_dir.iterdir()
15                      if f.is_file() and "Cell_Phone_DropA" in f.name and f.suffix == ""]
16
17        for anim_file in sorted(anim_files):
18            output_file = anim_file.with_suffix(".vtk")
19            print(f"Converting: {anim_file.name}")
20
21            # Binary-safe: Use subprocess with stdout capture as bytes
22            result = subprocess.run(
23                [str(converter), str(anim_file)],
24                capture_output=True,
25                check=False
26            )
27
28            # Write binary output directly (no text conversion)
29            with open(output_file, 'wb') as f:
30                f.write(result.stdout)
31
32            if result.returncode == 0 and output_file.stat().st_size > 0:
33                # Verify VTK header
34                with open(output_file, 'rb') as f:
35                    if f.read(5) == b'# vtk':
36                        print(f"  [OK] Valid VTK file ({output_file.stat().st_size} bytes)")
37                    else:
38                        print(f"  [WARNING] Invalid VTK header")
39            else:
40                print(f"  [FAILED] Return code: {result.returncode}")
41        endsubmit;

NOTE: Submitting statements to Python:


42        run;
NOTE: Procedure python step took :
      real time : 1:03:29.083
      cpu time  : 0:00:00.171


ERROR: Error printed on page 1

NOTE: Submitted statements took :
      real time : 1:03:29.225
      cpu time  : 0:00:00.234

/*____         _   _      _                _   _    _         _  __
|___  | __   _| |_| | __ | |_ ___   __   _| |_| | _| |__   __| |/ _|
   / /  \ \ / / __| |/ / | __/ _ \  \ \ / / __| |/ / `_ \ / _` | |_
  / /    \ V /| |_|   <  | || (_) |  \ V /| |_|   <| | | | (_| |  _|
 /_/      \_/  \__|_|\_\  \__\___/    \_/  \__|_|\_\_| |_|\__,_|_|

*/

%slc_pvpybegin;
cards4;
#!/usr/bin/env python
"""
Convert a series of VTK files into a single, transient VTKHDF file.
This script is designed to be run with ParaView's pvpython executable.
"""

from paraview.simple import *
import os
import glob

def convert_vtk_series_to_vtkhdf(file_pattern, output_file, compression_level=4):
    """
    Convert a series of VTK files into a single VTKHDF file.

    Args:
        file_pattern (str): Glob pattern matching your VTK files (e.g., "path/to/anim_*.vtk").
        output_file (str): Output filename (must end with .vtkhdf).
        compression_level (int): Compression level (0-9) for the HDF5 file.
                                 4 provides a good balance between size and speed.
    """
    # Get list of files sorted alphabetically
    vtk_files = sorted(glob.glob(file_pattern))

    if not vtk_files:
        print(f"ERROR: No files found matching pattern '{file_pattern}'")
        return

    print(f"Found {len(vtk_files)} VTK files to convert.")

    # Create a reader for the file series
    # Using LegacyVTKReader for .vtk files
    print("Loading file series...")
    reader = LegacyVTKReader(FileNames=vtk_files)

    # Save the data as a VTKHDF file
    print(f"Saving to {output_file}...")
    SaveData(
        output_file,
        proxy=reader,
        WriteAllTimeSteps=1,      # Save all time steps into one file
        CompressionLevel=compression_level
    )
    print("Conversion complete!")


if __name__ == "__main__":
    # --- CONFIGURATION ---
    # Update these paths for your specific case
    INPUT_FILE_PATTERN = "D:/rad/Cell_Phone_Drop*.vtk"  # e.g., Cell_Phone_DropA001.vtk, A002.vtk, etc.
    OUTPUT_FILE = "D:/rad/Cell_Phone_Drop.vtkhdf"

    convert_vtk_series_to_vtkhdf(INPUT_FILE_PATTERN, OUTPUT_FILE)
;;;;
%slc_pvpyend;

/**************************************************************************************************************************/
/* Altair SLC                                                                                                             */
/* Found 101 VTK files to convert.                                                                                        */
/* Loading file series...                                                                                                 */
/* Saving to D:/rad/Cell_Phone_Drop.vtkhdf...                                                                             */
/* Conversion complete!                                                                                                   */
/**************************************************************************************************************************/

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/


1                                          Altair SLC          14:20 Saturday, May 23, 2026

NOTE: Copyright 2002-2025 World Programming, an Altair Company
NOTE: Altair SLC 2026 (05.26.01.00.000758)
      Licensed to Roger DeAngelis
NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
NOTE: AUTOEXEC source line
1       +  ï»¿ods _all_ close;
           ^
ERROR: Expected a statement keyword : found "?"

NOTE: AUTOEXEC processing completed

1         %slc_pvpybegin;
The file c:/temp/py_pgm.py does not exist
2         cards4;

NOTE: The file 'c:\temp\py_pgmx.py' is:
      Filename='c:\temp\py_pgmx.py',
      Owner Name=SLC\suzie,
      File size (bytes)=0,
      Create Time=13:21:25 Jan 12 2026,
      Last Accessed=14:20:57 May 23 2026,
      Last Modified=14:20:57 May 23 2026,
      Lrecl=32767, Recfm=V

NOTE: 52 records were written to file 'c:\temp\py_pgmx.py'
      The minimum record length was 80
      The maximum record length was 103
NOTE: The data step took :
      real time : 0.000
      cpu time  : 0.000


3         #!/usr/bin/env python
4         """
5         Convert a series of VTK files into a single, transient VTKHDF file.
6         This script is designed to be run with ParaView's pvpython executable.
7         """
8
9         from paraview.simple import *
10        import os
11        import glob
12
13        def convert_vtk_series_to_vtkhdf(file_pattern, output_file, compression_level=4):
14            """
15            Convert a series of VTK files into a single VTKHDF file.
16
17            Args:
18                file_pattern (str): Glob pattern matching your VTK files (e.g., "path/to/anim_*.vtk").
19                output_file (str): Output filename (must end with .vtkhdf).
20                compression_level (int): Compression level (0-9) for the HDF5 file.
21                                         4 provides a good balance between size and speed.
22            """
23            # Get list of files sorted alphabetically
24            vtk_files = sorted(glob.glob(file_pattern))
25
26            if not vtk_files:
27                print(f"ERROR: No files found matching pattern '{file_pattern}'")
28                return
29
30            print(f"Found {len(vtk_files)} VTK files to convert.")
31
32            # Create a reader for the file series
33            # Using LegacyVTKReader for .vtk files
34            print("Loading file series...")
35            reader = LegacyVTKReader(FileNames=vtk_files)
36
37            # Save the data as a VTKHDF file
38            print(f"Saving to {output_file}...")
39            SaveData(
40                output_file,
41                proxy=reader,
42                WriteAllTimeSteps=1,      # Save all time steps into one file
43                CompressionLevel=compression_level
44            )
45            print("Conversion complete!")
46
47
48        if __name__ == "__main__":
49            # --- CONFIGURATION ---
50            # Update these paths for your specific case
51            INPUT_FILE_PATTERN = "D:/rad/Cell_Phone_Drop*.vtk"  # e.g., Cell_Phone_DropA001.vtk, A002.vtk, etc.
52            OUTPUT_FILE = "D:/rad/Cell_Phone_Drop.vtkhdf"
53
54            convert_vtk_series_to_vtkhdf(INPUT_FILE_PATTERN, OUTPUT_FILE)
55        ;;;;
56        %slc_pvpyend;

NOTE: The infile 'c:\temp\py_pgmx.py' is:
      Filename='c:\temp\py_pgmx.py',
      Owner Name=SLC\suzie,
      File size (bytes)=4304,
      Create Time=13:21:25 Jan 12 2026,
      Last Accessed=14:20:57 May 23 2026,
      Last Modified=14:20:57 May 23 2026,
      Lrecl=32767, Recfm=V

NOTE: The file 'c:\temp\py_pgm.py' is:
      Filename='c:\temp\py_pgm.py',
      Owner Name=SLC\suzie,
      File size (bytes)=0,
      Create Time=16:38:15 May 12 2026,
      Last Accessed=14:20:57 May 23 2026,
      Last Modified=14:20:57 May 23 2026,
      Lrecl=32767, Recfm=V

#!/usr/bin/env python
"""
Convert a series of VTK files into a single, transient VTKHDF file.
This script is designed to be run with ParaView's pvpython executable.
"""

from paraview.simple import *
import os
import glob

def convert_vtk_series_to_vtkhdf(file_pattern, output_file, compression_level=4):
    """
    Convert a series of VTK files into a single VTKHDF file.

    Args:
        file_pattern (str): Glob pattern matching your VTK files (e.g., "path/to/anim_*.vtk").
        output_file (str): Output filename (must end with .vtkhdf).
        compression_level (int): Compression level (0-9) for the HDF5 file.
                                 4 provides a good balance between size and speed.
    """
    # Get list of files sorted alphabetically
    vtk_files = sorted(glob.glob(file_pattern))

    if not vtk_files:
        print(f"ERROR: No files found matching pattern '{file_pattern}'")
        return

    print(f"Found {len(vtk_files)} VTK files to convert.")

    # Create a reader for the file series
    # Using LegacyVTKReader for .vtk files
    print("Loading file series...")
    reader = LegacyVTKReader(FileNames=vtk_files)

    # Save the data as a VTKHDF file
    print(f"Saving to {output_file}...")
    SaveData(
        output_file,
        proxy=reader,
        WriteAllTimeSteps=1,      # Save all time steps into one file
        CompressionLevel=compression_level
    )
    print("Conversion complete!")


if __name__ == "__main__":
    # --- CONFIGURATION ---
    # Update these paths for your specific case
    INPUT_FILE_PATTERN = "D:/rad/Cell_Phone_Drop*.vtk"  # e.g., Cell_Phone_DropA001.vtk, A002.vtk, etc.
    OUTPUT_FILE = "D:/rad/Cell_Phone_Drop.vtkhdf"

    convert_vtk_series_to_vtkhdf(INPUT_FILE_PATTERN, OUTPUT_FILE)
NOTE: 52 records were read from file 'c:\temp\py_pgmx.py'
      The minimum record length was 80
      The maximum record length was 103
NOTE: 52 records were written to file 'c:\temp\py_pgm.py'
      The minimum record length was 80
      The maximum record length was 103
NOTE: The data step took :
      real time : 0.015
      cpu time  : 0.000



NOTE: The infile rut is:
      Unnamed Pipe Access Device,
      Process=C:\Progra~1\ParaView-6.1.0-Windows-Python3.12-msvc2017-AMD64\bin\pvpython.exe c:/temp/py_pgm.py 2> c:/temp/py_pgm.log,
      Lrecl=32767, Recfm=V

Found 101 VTK files to convert.
Loading file series...
Saving to D:/rad/Cell_Phone_Drop.vtkhdf...
Conversion complete!
NOTE: 4 records were written to file PRINT

NOTE: 4 records were read from file rut
      The minimum record length was 20
      The maximum record length was 42
NOTE: The data step took :
      real time : 24:44.284
      cpu time  : 0:00.000



NOTE: The infile 'c:\temp\py_pgm.log' is:
      Filename='c:\temp\py_pgm.log',
      Owner Name=SLC\suzie,
      File size (bytes)=0,
      Create Time=11:45:37 May 12 2026,
      Last Accessed=14:20:57 May 23 2026,
      Last Modified=14:20:57 May 23 2026,
      Lrecl=32767, Recfm=V

NOTE: No records were read from file 'c:\temp\py_pgm.log'
NOTE: The data step took :
      real time : 0.000
      cpu time  : 0.000


ERROR: Error printed on page 1

NOTE: Submitted statements took :
      real time : 24:44.496
      cpu time  : 0:00.078


/*___         _   _       _  __   _
 ( _ ) __   _| |_| | ____| |/ _| | |_ ___     ___ _____   __
 / _ \ \ \ / / __| |/ / _` | |_  | __/ _ \   / __/ __\ \ / /
| (_) | \ V /| |_|   < (_| |  _| | || (_) | | (__\__ \\ V /
 \___/   \_/  \__|_|\_\__,_|_|    \__\___/   \___|___/ \_/

*/

/**************************************************************************************************************************/
/* Create CSVs                                                                                                            */
/*                                                                                                                        */
/* d:/rad                                                                                                                 */
/*   global_energy_data.csv                                                                                               */
/*   cell_data.csv                                                                                                        */
/*   gps_stress_data.csv                                                                                                  */
/**************************************************************************************************************************/

%slc_pvpybegin;
cards4;
#!/usr/bin/env python
"""
Extract ALL stress, strain, and energy data from VTKHDF.
Run with: pvpython this_script.py
"""

from paraview.simple import *
from paraview import servermanager
import csv
import os

# ------------------------------------------------------------
# CONFIGURATION
# ------------------------------------------------------------
VTKHDF_FILE = "D:/rad/Cell_Phone_Drop.vtkhdf"
OUTPUT_CSV = "D:/rad/simulation_data_complete.csv"

# ------------------------------------------------------------
# LOAD THE DATA
# ------------------------------------------------------------
print(f"Loading file: {VTKHDF_FILE}")
source = OpenDataFile(VTKHDF_FILE)
source.UpdatePipeline()

# ------------------------------------------------------------
# CHECK WHAT DATA IS AVAILABLE
# ------------------------------------------------------------
print("\n--- Available Data Arrays ---")
print(f"Point Data: {list(source.PointData.keys())}")
print(f"Cell Data: {list(source.CellData.keys())}")

# Get timesteps
timesteps = source.TimestepValues
print(f"\nNumber of timesteps: {len(timesteps)}")

# ------------------------------------------------------------
# CREATE AN INTEGRATE VARIABLES FILTER FOR GLOBAL TOTALS
# ------------------------------------------------------------
print("\nCalculating global integrated quantities...")
integrate = IntegrateVariables(Input=source)

# ------------------------------------------------------------
# METHOD 1: Export global integrated data (energy totals)
# ------------------------------------------------------------
print("\nSaving global integrated data...")
output_global = "D:/rad/global_energy_data.csv"
SaveData(output_global, proxy=integrate, WriteTimeSteps=1, Precision=12)
print(f"Global energy data saved to: {output_global}")

# ------------------------------------------------------------
# METHOD 2: Extract data for a specific point/region
# ------------------------------------------------------------
# If you want data for a specific point, use a threshold or clip filter
# For example, to get data for the entire model, you can export cell data

print("\nSaving cell data (if available)...")
if len(source.CellData.keys()) > 0:
    output_cell = "D:/rad/cell_data.csv"
    SaveData(output_cell, proxy=source, WriteTimeSteps=1,
             FieldAssociation='Cells', Precision=12)
    print(f"Cell data saved to: {output_cell}")

# ------------------------------------------------------------
# METHOD 3: Manual extraction of specific arrays
# ------------------------------------------------------------
print("\nExtracting specific arrays manually...")

# Get a list of arrays you want to extract
arrays_of_interest = ['GPS_SIGXX', 'GPS_SIGXY', 'GPS_SIGXZ', 'GPS_SIGYY',
                      'GPS_SIGZY', 'GPS_SIGZZ']

# Check which arrays actually exist
available_arrays = [arr for arr in arrays_of_interest if arr in source.PointData.keys()]

if available_arrays:
    # Create a calculator to extract just these arrays
    calculator = Calculator(Input=source)
    calculator.ResultArrayName = 'Extracted_Data'
    calculator.Function = ' '.join(available_arrays)

    output_extracted = "D:/rad/extracted_stress_data.csv"
    SaveData(output_extracted, proxy=calculator, WriteTimeSteps=1, Precision=12)
    print(f"Extracted stress data saved to: {output_extracted}")
else:
    print("No requested arrays found. Available arrays are:")
    print(f"  {list(source.PointData.keys())}")

print("\n--- Summary ---")
print(f"CSV files created in D:/rad/")
print("  - global_energy_data.csv: Total internal/kinetic energy over time")
print("  - cell_data.csv: Data for all cells (if available)")
print("  - extracted_stress_data.csv: Specific stress components")

# Verify files
for f in ['global_energy_data.csv', 'cell_data.csv', 'extracted_stress_data.csv']:
    path = f"D:/rad/{f}"
    if os.path.exists(path) and os.path.getsize(path) > 0:
        size_kb = os.path.getsize(path) / 1024
        print(f"  âœ“ {f} ({size_kb:.2f} KB)")
    elif os.path.exists(path):
        print(f"  âœ— {f} (0 bytes - no data)")
    else:
        print(f"  âœ— {f} (not created)")
;;;;
%slc_pvpyend;


/**************************************************************************************************************************/
/*  Altair SLC                                                                                                            */
/* Loading file: D:/rad/Cell_Phone_Drop.vtkhdf                                                                            */
/*                                                                                                                        */
/* --- Available Data Arrays ---                                                                                          */
/* Point Data: ['GPS_SIGXX', 'GPS_SIGXY', 'GPS_SIGXZ', 'GPS_SIGYY', 'GPS_SIGZY', 'GPS_SIGZZ', 'NODE_ID']                  */
/* Cell Data: ['3DELEM_Stra_Intg_Point111__', '3DELEM_Stra_Intg_Point112__', '3DELEM_Stra_Intg_Point121__',               */
/*  '3DELEM_Stra_Intg_Point122__', '3DELEM_Stra_Intg_Point211__', '3DELEM_Stra_Intg_Point212__',                          */
/*  '3DELEM_Stra_Intg_Point221__', '3DELEM_Stra_Intg_Point222                                                             */
/* __', '3DELEM_Strs_Intg_Point111__', '3DELEM_Strs_Intg_Point112__', '3DELEM_Strs_Intg_Point121__',                      */
/*  '3DELEM_Strs_Intg_Point122__', '3DELEM_Strs_Intg_Point211__', '3DELEM_Strs_Intg_Point212__',                          */
/*  '3DELEM_Strs_Intg_Point221__', '3DELEM_Strs_Intg_Point222__', 'E                                                      */
/* LEMENT_ID', 'EROSION_STATUS', 'PART_ID']                                                                               */
/*                                                                                                                        */
/* Number of timesteps: 101                                                                                               */
/*                                                                                                                        */
/* Calculating global integrated quantities...                                                                            */
/*                                                                                                                        */
/* Saving global integrated data...                                                                                       */
/* Global energy data saved to: D:/rad/global_energy_data.csv                                                             */
/*                                                                                                                        */
/* Saving cell data (if available)...                                                                                     */
/* Cell data saved to: D:/rad/cell_data.csv                                                                               */
/*                                                                                                                        */
/* Extracting point data (GPS stress components)...                                                                       */
/* GPS stress data saved to: D:/rad/gps_stress_data.csv                                                                   */
/* Available GPS arrays: ['GPS_SIGXX', 'GPS_SIGXY', 'GPS_SIGXZ', 'GPS_SIGYY', 'GPS_SIGZY', 'GPS_SIGZZ']                   */
/*                                                                                                                        */
/* --- Summary ---                                                                                                        */
/* CSV files created in D:/rad/:                                                                                          */
/*   [OK] global_energy_data.csv (14.58 KB)                                                                               */
/*        Header: "GPS_SIGXX","GPS_SIGXY","GPS_SIGXZ","GPS_SIGYY","GPS_SIGZY","GPS_SIGZZ","NODE_ID","Points:0","Points... */
/*   [OK] cell_data.csv (16662703.51 KB)                                                                                  */
/*        Header: "3DELEM_Stra_Intg_Point111__:0","3DELEM_Stra_Intg_Point111__:1","3DELEM_Stra_Intg_Point111__:2","3DE... */
/*   [OK] gps_stress_data.csv (3904411.47 KB)                                                                             */
/*        Header: "GPS_SIGXX","GPS_SIGXY","GPS_SIGXZ","GPS_SIGYY","GPS_SIGZY","GPS_SIGZZ","NODE_ID","Points:0","Points... */
/*                                                                                                                        */
/* Data extraction complete!                                                                                              */
/**************************************************************************************************************************/

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

1                                          Altair SLC          15:01 Saturday, May 23, 2026

NOTE: Copyright 2002-2025 World Programming, an Altair Company
NOTE: Altair SLC 2026 (05.26.01.00.000758)
      Licensed to Roger DeAngelis
NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
NOTE: AUTOEXEC source line
1       +  ï»¿ods _all_ close;
           ^
ERROR: Expected a statement keyword : found "?"

NOTE: AUTOEXEC processing completed

1          %slc_pvpybegin;
The file c:/temp/py_pgm.py does not exist
2         cards4;

NOTE: The file 'c:\temp\py_pgmx.py' is:
      Filename='c:\temp\py_pgmx.py',
      Owner Name=SLC\suzie,
      File size (bytes)=0,
      Create Time=13:21:25 Jan 12 2026,
      Last Accessed=15:01:36 May 23 2026,
      Last Modified=15:01:36 May 23 2026,
      Lrecl=32767, Recfm=V

NOTE: 103 records were written to file 'c:\temp\py_pgmx.py'
      The minimum record length was 80
      The maximum record length was 91
NOTE: The data step took :
      real time : 0.000
      cpu time  : 0.000


3         #!/usr/bin/env python
4         """
5         Extract ALL stress, strain, and energy data from VTKHDF.
6         Run with: pvpython this_script.py
7         """
8
9         from paraview.simple import *
10        from paraview import servermanager
11        import csv
12        import os
13
14        # ------------------------------------------------------------
15        # CONFIGURATION
16        # ------------------------------------------------------------
17        VTKHDF_FILE = "D:/rad/Cell_Phone_Drop.vtkhdf"
18        OUTPUT_CSV = "D:/rad/simulation_data_complete.csv"
19
20        # ------------------------------------------------------------
21        # LOAD THE DATA
22        # ------------------------------------------------------------
23        print(f"Loading file: {VTKHDF_FILE}")
24        source = OpenDataFile(VTKHDF_FILE)
25        source.UpdatePipeline()
26
27        # ------------------------------------------------------------
28        # CHECK WHAT DATA IS AVAILABLE
29        # ------------------------------------------------------------
30        print("\n--- Available Data Arrays ---")
31        print(f"Point Data: {list(source.PointData.keys())}")
32        print(f"Cell Data: {list(source.CellData.keys())}")
33
34        # Get timesteps
35        timesteps = source.TimestepValues
36        print(f"\nNumber of timesteps: {len(timesteps)}")
37
38        # ------------------------------------------------------------
39        # CREATE AN INTEGRATE VARIABLES FILTER FOR GLOBAL TOTALS
40        # ------------------------------------------------------------
41        print("\nCalculating global integrated quantities...")
42        integrate = IntegrateVariables(Input=source)
43
44        # ------------------------------------------------------------
45        # METHOD 1: Export global integrated data (energy totals)
46        # ------------------------------------------------------------
47        print("\nSaving global integrated data...")
48        output_global = "D:/rad/global_energy_data.csv"
49        SaveData(output_global, proxy=integrate, WriteTimeSteps=1, Precision=12)
50        print(f"Global energy data saved to: {output_global}")
51
52        # ------------------------------------------------------------
53        # METHOD 2: Extract cell data - CORRECTED FieldAssociation
54        # ------------------------------------------------------------
55        print("\nSaving cell data (if available)...")
56        if len(source.CellData.keys()) > 0:
57            output_cell = "D:/rad/cell_data.csv"
58            # CORRECTED: Use 'Cell Data' instead of 'Cells'
59            SaveData(output_cell, proxy=source, WriteTimeSteps=1,
60                     FieldAssociation='Cell Data', Precision=12)
61            print(f"Cell data saved to: {output_cell}")
62        else:
63            print("No cell data available")
64
65        # ------------------------------------------------------------
66        # METHOD 3: Extract point data (GPS stress components)
67        # ------------------------------------------------------------
68        print("\nExtracting point data (GPS stress components)...")
69
70        gps_arrays = ['GPS_SIGXX', 'GPS_SIGXY', 'GPS_SIGXZ', 'GPS_SIGYY', 'GPS_SIGZY', 'GPS_SIGZZ']
71        available_gps = [arr for arr in gps_arrays if arr in source.PointData.keys()]
72
73        if available_gps:
74            output_gps = "D:/rad/gps_stress_data.csv"
75            # CORRECTED: Use 'Point Data' instead of 'Points'
76            SaveData(output_gps, proxy=source, WriteTimeSteps=1,
77                     FieldAssociation='Point Data', Precision=12)
78            print(f"GPS stress data saved to: {output_gps}")
79            print(f"Available GPS arrays: {available_gps}")
80        else:
81            print("No GPS stress arrays found. Available point data:")
82            print(f"  {list(source.PointData.keys())}")
83
84        # ------------------------------------------------------------
85        # VERIFY FILES
86        # ------------------------------------------------------------
87        print("\n--- Summary ---")
88        print("CSV files created in D:/rad/:")
89
90        csv_files = ['global_energy_data.csv', 'cell_data.csv', 'gps_stress_data.csv']
91        for f in csv_files:
92            path = f"D:/rad/{f}"
93            if os.path.exists(path) and os.path.getsize(path) > 0:
94                size_kb = os.path.getsize(path) / 1024
95                print(f"  [OK] {f} ({size_kb:.2f} KB)")
96                # Show header preview
97                with open(path, 'r') as fh:
98                    header = fh.readline().strip()
99                    print(f"       Header: {header[:100]}...")
100           elif os.path.exists(path):
101               print(f"  [WARNING] {f} (0 bytes - no data)")
102           else:
103               print(f"  [MISSING] {f} (not created)")
104
105       print("\nData extraction complete!")
106       ;;;;
107       %slc_pvpyend;

NOTE: The infile 'c:\temp\py_pgmx.py' is:
      Filename='c:\temp\py_pgmx.py',
      Owner Name=SLC\suzie,
      File size (bytes)=8457,
      Create Time=13:21:25 Jan 12 2026,
      Last Accessed=15:01:36 May 23 2026,
      Last Modified=15:01:36 May 23 2026,
      Lrecl=32767, Recfm=V

NOTE: The file 'c:\temp\py_pgm.py' is:
      Filename='c:\temp\py_pgm.py',
      Owner Name=SLC\suzie,
      File size (bytes)=0,
      Create Time=16:38:15 May 12 2026,
      Last Accessed=15:01:37 May 23 2026,
      Last Modified=15:01:37 May 23 2026,

#!/usr/bin/env python
"""
Extract ALL stress, strain, and energy data from VTKHDF.
Run with: pvpython this_script.py
"""

from paraview.simple import *
from paraview import servermanager
import csv
import os

# ------------------------------------------------------------
# CONFIGURATION
# ------------------------------------------------------------
VTKHDF_FILE = "D:/rad/Cell_Phone_Drop.vtkhdf"
OUTPUT_CSV = "D:/rad/simulation_data_complete.csv"

# ------------------------------------------------------------
# LOAD THE DATA
# ------------------------------------------------------------
print(f"Loading file: {VTKHDF_FILE}")
source = OpenDataFile(VTKHDF_FILE)
source.UpdatePipeline()

# ------------------------------------------------------------
# CHECK WHAT DATA IS AVAILABLE
# ------------------------------------------------------------
print("\n--- Available Data Arrays ---")
print(f"Point Data: {list(source.PointData.keys())}")
print(f"Cell Data: {list(source.CellData.keys())}")

# Get timesteps
timesteps = source.TimestepValues
print(f"\nNumber of timesteps: {len(timesteps)}")

# ------------------------------------------------------------
# CREATE AN INTEGRATE VARIABLES FILTER FOR GLOBAL TOTALS
# ------------------------------------------------------------
print("\nCalculating global integrated quantities...")
integrate = IntegrateVariables(Input=source)

# ------------------------------------------------------------
# METHOD 1: Export global integrated data (energy totals)
# ------------------------------------------------------------
print("\nSaving global integrated data...")
output_global = "D:/rad/global_energy_data.csv"
SaveData(output_global, proxy=integrate, WriteTimeSteps=1, Precision=12)
print(f"Global energy data saved to: {output_global}")

# ------------------------------------------------------------
# METHOD 2: Extract cell data - CORRECTED FieldAssociation
# ------------------------------------------------------------
print("\nSaving cell data (if available)...")
if len(source.CellData.keys()) > 0:
    output_cell = "D:/rad/cell_data.csv"
    # CORRECTED: Use 'Cell Data' instead of 'Cells'
    SaveData(output_cell, proxy=source, WriteTimeSteps=1,
             FieldAssociation='Cell Data', Precision=12)
    print(f"Cell data saved to: {output_cell}")
else:
    print("No cell data available")

# ------------------------------------------------------------
# METHOD 3: Extract point data (GPS stress components)
# ------------------------------------------------------------
print("\nExtracting point data (GPS stress components)...")

gps_arrays = ['GPS_SIGXX', 'GPS_SIGXY', 'GPS_SIGXZ', 'GPS_SIGYY', 'GPS_SIGZY', 'GPS_SIGZZ']
available_gps = [arr for arr in gps_arrays if arr in source.PointData.keys()]

if available_gps:
    output_gps = "D:/rad/gps_stress_data.csv"
    # CORRECTED: Use 'Point Data' instead of 'Points'
    SaveData(output_gps, proxy=source, WriteTimeSteps=1,
             FieldAssociation='Point Data', Precision=12)
    print(f"GPS stress data saved to: {output_gps}")
    print(f"Available GPS arrays: {available_gps}")
else:
    print("No GPS stress arrays found. Available point data:")
    print(f"  {list(source.PointData.keys())}")

# ------------------------------------------------------------
# VERIFY FILES
# ------------------------------------------------------------
print("\n--- Summary ---")
print("CSV files created in D:/rad/:")

csv_files = ['global_energy_data.csv', 'cell_data.csv', 'gps_stress_data.csv']
for f in csv_files:
    path = f"D:/rad/{f}"
    if os.path.exists(path) and os.path.getsize(path) > 0:
        size_kb = os.path.getsize(path) / 1024
        print(f"  [OK] {f} ({size_kb:.2f} KB)")
        # Show header preview
        with open(path, 'r') as fh:
            header = fh.readline().strip()
            print(f"       Header: {header[:100]}...")
    elif os.path.exists(path):
        print(f"  [WARNING] {f} (0 bytes - no data)")
    else:
        print(f"  [MISSING] {f} (not created)")

print("\nData extraction complete!")
NOTE: 103 records were read from file 'c:\temp\py_pgmx.py'
      The minimum record length was 80
      The maximum record length was 91
NOTE: 103 records were written to file 'c:\temp\py_pgm.py'
      The minimum record length was 80
      The maximum record length was 91
NOTE: The data step took :
      real time : 0.015
      cpu time  : 0.000



NOTE: The infile rut is:
      Unnamed Pipe Access Device,
      Process=C:\Progra~1\ParaView-6.1.0-Windows-Python3.12-msvc2017-AMD64\bin\pvpython.exe c:/temp/py_pgm.py 2> c:/temp/py_pgm.log,
      Lrecl=32767, Recfm=V

Loading file: D:/rad/Cell_Phone_Drop.vtkhdf

--- Available Data Arrays ---
Point Data: ['GPS_SIGXX', 'GPS_SIGXY', 'GPS_SIGXZ', 'GPS_SIGYY', 'GPS_SIGZY', 'GPS_SIGZZ', 'NODE_ID']
Cell Data: ['3DELEM_Stra_Intg_Point111__', '3DELEM_Stra_Intg_Point112__', '3DELEM_Stra_Intg_Point121__',
 '3DELEM_Stra_Intg_Point122__', '3DELEM_Stra_Intg_Point211__', '3DELEM_Stra_Intg_Point212__',
 '3DELEM_Stra_Intg_Point221__', '3DELEM_Stra_Intg_Point222
__', '3DELEM_Strs_Intg_Point111__', '3DELEM_Strs_Intg_Point112__', '3DELEM_Strs_Intg_Point121__',
 '3DELEM_Strs_Intg_Point122__', '3DELEM_Strs_Intg_Point211__', '3DELEM_Strs_Intg_Point212__',
 '3DELEM_Strs_Intg_Point221__', '3DELEM_Strs_Intg_Point222__', 'E
LEMENT_ID', 'EROSION_STATUS', 'PART_ID']

Number of timesteps: 101

Calculating global integrated quantities...

Saving global integrated data...
Global energy data saved to: D:/rad/global_energy_data.csv

Saving cell data (if available)...
Cell data saved to: D:/rad/cell_data.csv

Extracting point data (GPS stress components)...
GPS stress data saved to: D:/rad/gps_stress_data.csv
Available GPS arrays: ['GPS_SIGXX', 'GPS_SIGXY', 'GPS_SIGXZ', 'GPS_SIGYY', 'GPS_SIGZY', 'GPS_SIGZZ']

--- Summary ---
CSV files created in D:/rad/:
  [OK] global_energy_data.csv (14.58 KB)
       Header: "GPS_SIGXX","GPS_SIGXY","GPS_SIGXZ","GPS_SIGYY","GPS_SIGZY","GPS_SIGZZ","NODE_ID","Points:0","Points...
  [OK] cell_data.csv (16662703.51 KB)
       Header: "3DELEM_Stra_Intg_Point111__:0","3DELEM_Stra_Intg_Point111__:1","3DELEM_Stra_Intg_Point111__:2","3DE...
  [OK] gps_stress_data.csv (3904411.47 KB)
       Header: "GPS_SIGXX","GPS_SIGXY","GPS_SIGXZ","GPS_SIGYY","GPS_SIGZY","GPS_SIGZZ","NODE_ID","Points:0","Points...

Data extraction complete!
NOTE: 32 records were written to file PRINT

NOTE: 30 records were read from file rut
      The minimum record length was 0
      The maximum record length was 550
NOTE: The data step took :
      real time : 45:03.706
      cpu time  : 0:00.015



NOTE: The infile 'c:\temp\py_pgm.log' is:
      Filename='c:\temp\py_pgm.log',
      Owner Name=SLC\suzie,
      File size (bytes)=0,
      Create Time=11:45:37 May 12 2026,
      Last Accessed=15:01:37 May 23 2026,
      Last Modified=15:01:37 May 23 2026,
      Lrecl=32767, Recfm=V

NOTE: No records were read from file 'c:\temp\py_pgm.log'
NOTE: The data step took :
      real time : 0.000
      cpu time  : 0.015


ERROR: Error printed on page 1

NOTE: Submitted statements took :
      real time : 45:03.945
      cpu time  : 0:00.156


/*___         _   _       _  __                    _         _
 / _ \ __   _| |_| | ____| |/ _|   ___ _____   __ | |_ ___  | |_ ___ _ __  ___  ___  _ __ ___
| (_) |\ \ / / __| |/ / _` | |_   / __/ __\ \ / / | __/ _ \ | __/ _ \ `_ \/ __|/ _ \| `__/ __|
 \__, | \ V /| |_|   < (_| |  _| | (__\__ \\ V /  | || (_) || ||  __/ | | \__ \ (_) | |  \__ \
   /_/   \_/  \__|_|\_\__,_|_|    \___|___/ \_/    \__\___/  \__\___|_| |_|___/\___/|_|  |___/
                       _
  __ _ _ __  ___   ___| |_ _ __ ___  ___ ___
 / _` | `_ \/ __| / __| __| `__/ _ \/ __/ __|
| (_| | |_) \__ \ \__ \ |_| | |  __/\__ \__ \
 \__, | .__/|___/ |___/\__|_|  \___||___/___/
 |___/|_|
*/

data workx.gps_data(drop=empty);
    infile "D:/rad/gps_stress_data.csv" dsd dlm=',' firstobs=2 missover;

    /* Optional: add labels */
    label
        GPS_SIGXX = "Stress XX at GPS sensor (MPa)"
        GPS_SIGXY = "Stress XY shear at GPS sensor (MPa)"
        GPS_SIGXZ = "Stress XZ shear at GPS sensor (MPa)"
        GPS_SIGYY = "Stress YY at GPS sensor (MPa)"
        GPS_SIGZY = "Stress ZY shear at GPS sensor (MPa)"
        GPS_SIGZZ = "Stress ZZ at GPS sensor (MPa)"
        NODE_ID   = "Node identification number"
        Points_0  = "X-coordinate (mm)"
        Points_1  = "Y-coordinate (mm)"
        Points_2  = "Z-coordinate (mm)"
    ;

    input
        GPS_SIGXX
        GPS_SIGXY
        GPS_SIGXZ
        GPS_SIGYY
        GPS_SIGZY
        GPS_SIGZZ
        NODE_ID
        Points_0
        Points_1
        Points_2
        empty best32.
    ;
run;


options ls=255;
/* Generate summary statistics */
proc means data=WORKX.GPS_DATA n mean std min max;
run;

/*********************************************************************************************************************/
/* SUMMARY WORKX.GPS_DATA                                                                                            */
/* Variable     Label                                      N         Mean     Std Dev       Minimum     Maximum      */
/* ------------------------------------------------------------------------------------------------------------      */
/* GPS_SIGXX    Stress XX at GPS sensor (MPa)       25,967,504   -0.1201058   1.8206776  -112.8840027  93.2063980    */
/* GPS_SIGXY    Stress XY shear at GPS sensor (MPa) 25,967,504   -0.1461755   0.9913128   -35.8805008  36.0896988    */
/* GPS_SIGXZ    Stress XZ shear at GPS sensor (MPa) 25,967,504   -0.0119538   0.5642735   -36.2535019  31.0499001    */
/* GPS_SIGYY    Stress YY at GPS sensor (MPa)       25,967,504   -0.2307818   1.7956183  -107.3489990  68.7621002    */
/* GPS_SIGZY    Stress ZY shear at GPS sensor (MPa) 25,967,504   -0.0099625   0.5652286   -35.4822006  31.1772995    */
/* GPS_SIGZZ    Stress ZZ at GPS sensor (MPa)       25,967,504   -0.0029594   1.0617416   -90.7462006  81.6155014    */
/* NODE_ID      Node identification number          25,967,504    131298.19    75310.39             0   264182.00    */
/* Points_0     X-coordinate (mm)                   25,967,504    0.0468387  16.9236693   -84.3907013  30.5025005    */
/* Points_1     Y-coordinate (mm)                   25,967,504    0.5870174  28.7416700  -100.6689987  51.8307991    */
/* Points_2     Z-coordinate (mm)                   25,967,504    2.9888497   2.8933593   -47.2560005  54.4303017    */
/*********************************************************************************************************************/

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/
1                                          Altair SLC            14:21 Sunday, May 24, 2026

NOTE: Copyright 2002-2025 World Programming, an Altair Company
NOTE: Altair SLC 2026 (05.26.01.00.000758)
      Licensed to Roger DeAngelis
NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
NOTE: AUTOEXEC source line
1       +  ï»¿ods _all_ close;
           ^
ERROR: Expected a statement keyword : found "?"

NOTE: AUTOEXEC processing completed

1          data workx.gps_data(drop=empty);
2             infile "D:/rad/gps_stress_data.csv" dsd dlm=',' firstobs=2 missover;
3
4             /* Optional: add labels */
5             label
6                 GPS_SIGXX = "Stress XX at GPS sensor (MPa)"
7                 GPS_SIGXY = "Stress XY shear at GPS sensor (MPa)"
8                 GPS_SIGXZ = "Stress XZ shear at GPS sensor (MPa)"
9                 GPS_SIGYY = "Stress YY at GPS sensor (MPa)"
10                GPS_SIGZY = "Stress ZY shear at GPS sensor (MPa)"
11                GPS_SIGZZ = "Stress ZZ at GPS sensor (MPa)"
12                NODE_ID   = "Node identification number"
13                Points_0  = "X-coordinate (mm)"
14                Points_1  = "Y-coordinate (mm)"
15                Points_2  = "Z-coordinate (mm)"
16            ;
17
18            input
19                GPS_SIGXX
20                GPS_SIGXY
21                GPS_SIGXZ
22                GPS_SIGYY
23                GPS_SIGZY
24                GPS_SIGZZ
25                NODE_ID
26                Points_0
27                Points_1
28                Points_2
29                empty best32.
30            ;
31        run;

NOTE: The infile 'D:\rad\gps_stress_data.csv' is:
      Filename='D:\rad\gps_stress_data.csv',
      Owner Name=SLC\suzie,
      File size (bytes)=3998117346,
      Create Time=15:39:38 May 23 2026,
      Last Accessed=14:15:50 May 24 2026,
      Last Modified=15:46:40 May 23 2026,
      Lrecl=32767, Recfm=V

NOTE: 25967504 records were read from file 'D:\rad\gps_stress_data.csv'
      The minimum record length was 23
      The maximum record length was 171
NOTE: Data set "WORKX.gps_data" has 25967504 observation(s) and 10 variable(s)
NOTE: The data step took :
      real time : 1:32.687
      cpu time  : 1:32.343


32
33
34        options ls=255;
35        /* Generate summary statistics */
36        proc means data=WORKX.GPS_DATA n mean std min max;
37        run;
NOTE: 25967504 observations were read from "WORKX.GPS_DATA"
NOTE: Procedure means step took :
      real time : 8.719
      cpu time  : 8.687


38
ERROR: Error printed on page 1

NOTE: Submitted statements took :
      real time : 1:41.517
      cpu time  : 1:41.109

/*        _ _       _       _
  ___ ___| | |   __| | __ _| |_ __ _
 / __/ _ \ | |  / _` |/ _` | __/ _` |
| (_|  __/ | | | (_| | (_| | || (_| |
 \___\___|_|_|  \__,_|\__,_|\__\__,_|

*/


data WORKX.cell_DATA(drop=empty); /*--- csv has extra comma on the end of all records ---*/

infile "d:/rad/cell_data.csv" delimiter = ',' MISSOVER DSD firstobs=2;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* These variables are the strain tensor components at specific                                                           */
/* integration points within each 3D brick element in your cell phone drop simulation.                                    */
/*                                                                                                                        */
/* 3D Element        Part            Meaning                                                                              */
/*                                                                                                                        */
/* 1st Columnm      Dim3_DELEM        3D Element (brick/hexahedron element)                                               */
/*                  Stra              Strain (as opposed to Strs for Stress)                                              */
/*                  Intg_Point        Integration point (Gauss point within the element)                                  */
/*                  111               Integration point location indices                                                  */
/*                  :0                Tensor component index                                                              */
/*                  ...                                                                                                   */
/*                  ...                                                                                                   */
/* 149th Column     Dim3_DELEM        3D Element (brick/hexahedron element)                                               */
/*                  Stra              Strain (as opposed to Strs for Stress)                                              */
/*                  Intg_Point        Integration point (Gauss point within the element)                                  */
/*                  222               Integration point location indices                                                  */
/*                  :8                Tensor component index                                                              */
/**************************************************************************************************************************/


label
    ELEMENT_ID     = "Element identification number"

    Dim3_ELEM_Stra_Intg_Point111_0 = "Strain exx at integration point 111 (bottom-lower-left)"
    Dim3_ELEM_Stra_Intg_Point111_1 = "Strain eyy at integration point 111 (bottom-lower-left)"
    Dim3_ELEM_Stra_Intg_Point111_2 = "Strain ezz at integration point 111 (bottom-lower-left)"
    Dim3_ELEM_Stra_Intg_Point111_3 = "Shear strain exy at integration point 111"
    Dim3_ELEM_Stra_Intg_Point111_4 = "Shear strain eyz at integration point 111"
    Dim3_ELEM_Stra_Intg_Point111_5 = "Shear strain ezx at integration point 111"
    Dim3_ELEM_Stra_Intg_Point111_6 = "Additional Component (if needed)"
    Dim3_ELEM_Stra_Intg_Point111_7 = "Additional Component (if needed)"
    Dim3_ELEM_Stra_Intg_Point111_8 = "Additional Component (if needed)"
;

input
    Dim3_ELEM_Stra_Intg_Point111_0
    Dim3_ELEM_Stra_Intg_Point111_1
    Dim3_ELEM_Stra_Intg_Point111_2
    Dim3_ELEM_Stra_Intg_Point111_3
    Dim3_ELEM_Stra_Intg_Point111_4
    Dim3_ELEM_Stra_Intg_Point111_5
    Dim3_ELEM_Stra_Intg_Point111_6
    Dim3_ELEM_Stra_Intg_Point111_7
    Dim3_ELEM_Stra_Intg_Point111_8
    Dim3_ELEM_Stra_Intg_Point112_0
    Dim3_ELEM_Stra_Intg_Point112_1
    Dim3_ELEM_Stra_Intg_Point112_2
    Dim3_ELEM_Stra_Intg_Point112_3
    Dim3_ELEM_Stra_Intg_Point112_4
    Dim3_ELEM_Stra_Intg_Point112_5
    Dim3_ELEM_Stra_Intg_Point112_6
    Dim3_ELEM_Stra_Intg_Point112_7
    Dim3_ELEM_Stra_Intg_Point112_8
    Dim3_ELEM_Stra_Intg_Point121_0
    Dim3_ELEM_Stra_Intg_Point121_1
    Dim3_ELEM_Stra_Intg_Point121_2
    Dim3_ELEM_Stra_Intg_Point121_3
    Dim3_ELEM_Stra_Intg_Point121_4
    Dim3_ELEM_Stra_Intg_Point121_5
    Dim3_ELEM_Stra_Intg_Point121_6
    Dim3_ELEM_Stra_Intg_Point121_7
    Dim3_ELEM_Stra_Intg_Point121_8
    Dim3_ELEM_Stra_Intg_Point122_0
    Dim3_ELEM_Stra_Intg_Point122_1
    Dim3_ELEM_Stra_Intg_Point122_2
    Dim3_ELEM_Stra_Intg_Point122_3
    Dim3_ELEM_Stra_Intg_Point122_4
    Dim3_ELEM_Stra_Intg_Point122_5
    Dim3_ELEM_Stra_Intg_Point122_6
    Dim3_ELEM_Stra_Intg_Point122_7
    Dim3_ELEM_Stra_Intg_Point122_8
    Dim3_ELEM_Stra_Intg_Point211_0
    Dim3_ELEM_Stra_Intg_Point211_1
    Dim3_ELEM_Stra_Intg_Point211_2
    Dim3_ELEM_Stra_Intg_Point211_3
    Dim3_ELEM_Stra_Intg_Point211_4
    Dim3_ELEM_Stra_Intg_Point211_5
    Dim3_ELEM_Stra_Intg_Point211_6
    Dim3_ELEM_Stra_Intg_Point211_7
    Dim3_ELEM_Stra_Intg_Point211_8
    Dim3_ELEM_Stra_Intg_Point212_0
    Dim3_ELEM_Stra_Intg_Point212_1
    Dim3_ELEM_Stra_Intg_Point212_2
    Dim3_ELEM_Stra_Intg_Point212_3
    Dim3_ELEM_Stra_Intg_Point212_4
    Dim3_ELEM_Stra_Intg_Point212_5
    Dim3_ELEM_Stra_Intg_Point212_6
    Dim3_ELEM_Stra_Intg_Point212_7
    Dim3_ELEM_Stra_Intg_Point212_8
    Dim3_ELEM_Stra_Intg_Point221_0
    Dim3_ELEM_Stra_Intg_Point221_1
    Dim3_ELEM_Stra_Intg_Point221_2
    Dim3_ELEM_Stra_Intg_Point221_3
    Dim3_ELEM_Stra_Intg_Point221_4
    Dim3_ELEM_Stra_Intg_Point221_5
    Dim3_ELEM_Stra_Intg_Point221_6
    Dim3_ELEM_Stra_Intg_Point221_7
    Dim3_ELEM_Stra_Intg_Point221_8
    Dim3_ELEM_Stra_Intg_Point222_0
    Dim3_ELEM_Stra_Intg_Point222_1
    Dim3_ELEM_Stra_Intg_Point222_2
    Dim3_ELEM_Stra_Intg_Point222_3
    Dim3_ELEM_Stra_Intg_Point222_4
    Dim3_ELEM_Stra_Intg_Point222_5
    Dim3_ELEM_Stra_Intg_Point222_6
    Dim3_ELEM_Stra_Intg_Point222_7
    Dim3_ELEM_Stra_Intg_Point222_8
    Dim3_ELEM_Strs_Intg_Point111_0
    Dim3_ELEM_Strs_Intg_Point111_1
    Dim3_ELEM_Strs_Intg_Point111_2
    Dim3_ELEM_Strs_Intg_Point111_3
    Dim3_ELEM_Strs_Intg_Point111_4
    Dim3_ELEM_Strs_Intg_Point111_5
    Dim3_ELEM_Strs_Intg_Point111_6
    Dim3_ELEM_Strs_Intg_Point111_7
    Dim3_ELEM_Strs_Intg_Point111_8
    Dim3_ELEM_Strs_Intg_Point112_0
    Dim3_ELEM_Strs_Intg_Point112_1
    Dim3_ELEM_Strs_Intg_Point112_2
    Dim3_ELEM_Strs_Intg_Point112_3
    Dim3_ELEM_Strs_Intg_Point112_4
    Dim3_ELEM_Strs_Intg_Point112_5
    Dim3_ELEM_Strs_Intg_Point112_6
    Dim3_ELEM_Strs_Intg_Point112_7
    Dim3_ELEM_Strs_Intg_Point112_8
    Dim3_ELEM_Strs_Intg_Point121_0
    Dim3_ELEM_Strs_Intg_Point121_1
    Dim3_ELEM_Strs_Intg_Point121_2
    Dim3_ELEM_Strs_Intg_Point121_3
    Dim3_ELEM_Strs_Intg_Point121_4
    Dim3_ELEM_Strs_Intg_Point121_5
    Dim3_ELEM_Strs_Intg_Point121_6
    Dim3_ELEM_Strs_Intg_Point121_7
    Dim3_ELEM_Strs_Intg_Point121_8
    Dim3_ELEM_Strs_Intg_Point122_0
    Dim3_ELEM_Strs_Intg_Point122_1
    Dim3_ELEM_Strs_Intg_Point122_2
    Dim3_ELEM_Strs_Intg_Point122_3
    Dim3_ELEM_Strs_Intg_Point122_4
    Dim3_ELEM_Strs_Intg_Point122_5
    Dim3_ELEM_Strs_Intg_Point122_6
    Dim3_ELEM_Strs_Intg_Point122_7
    Dim3_ELEM_Strs_Intg_Point122_8
    Dim3_ELEM_Strs_Intg_Point211_0
    Dim3_ELEM_Strs_Intg_Point211_1
    Dim3_ELEM_Strs_Intg_Point211_2
    Dim3_ELEM_Strs_Intg_Point211_3
    Dim3_ELEM_Strs_Intg_Point211_4
    Dim3_ELEM_Strs_Intg_Point211_5
    Dim3_ELEM_Strs_Intg_Point211_6
    Dim3_ELEM_Strs_Intg_Point211_7
    Dim3_ELEM_Strs_Intg_Point211_8
    Dim3_ELEM_Strs_Intg_Point212_0
    Dim3_ELEM_Strs_Intg_Point212_1
    Dim3_ELEM_Strs_Intg_Point212_2
    Dim3_ELEM_Strs_Intg_Point212_3
    Dim3_ELEM_Strs_Intg_Point212_4
    Dim3_ELEM_Strs_Intg_Point212_5
    Dim3_ELEM_Strs_Intg_Point212_6
    Dim3_ELEM_Strs_Intg_Point212_7
    Dim3_ELEM_Strs_Intg_Point212_8
    Dim3_ELEM_Strs_Intg_Point221_0
    Dim3_ELEM_Strs_Intg_Point221_1
    Dim3_ELEM_Strs_Intg_Point221_2
    Dim3_ELEM_Strs_Intg_Point221_3
    Dim3_ELEM_Strs_Intg_Point221_4
    Dim3_ELEM_Strs_Intg_Point221_5
    Dim3_ELEM_Strs_Intg_Point221_6
    Dim3_ELEM_Strs_Intg_Point221_7
    Dim3_ELEM_Strs_Intg_Point221_8
    Dim3_ELEM_Strs_Intg_Point222_0
    Dim3_ELEM_Strs_Intg_Point222_1
    Dim3_ELEM_Strs_Intg_Point222_2
    Dim3_ELEM_Strs_Intg_Point222_3
    Dim3_ELEM_Strs_Intg_Point222_4
    Dim3_ELEM_Strs_Intg_Point222_5
    Dim3_ELEM_Strs_Intg_Point222_6
    Dim3_ELEM_Strs_Intg_Point222_7
    Dim3_ELEM_Strs_Intg_Point222_8
    ELEMENT_ID
    EROSION_STATUS
    PART_ID
    Cell_Type  empty  best32.;
  *if _n_=100000 then stop;
run;

options ls=255;
/* Generate summary statistics */
proc means data=WORKX.cell_DATA n mean std min max;
run;

/**************************************************************************************************************************/
/* Altair SLC  WORKX.cell_DATA                                                                                            */
/*                                             Summary statistics                                                         */
/* Variable                                 N            Mean         Std Dev         Minimum         Maximum             */
/*                                                                                                                        */
/* ELEMENT_ID                        13152220    195657.09416    97239.723857               0          331717             */
/* EROSION_STATUS                    13152220               1               0               1               1             */
/* PART_ID                           13152220    5.2176624174    6.8032303228               1              28             */
/* CELL_TYPE                         13152220    10.316648748    0.7301213482               9              12             */
/*                                                                                                                        */
/* STRAINS                                                                                                                */
/*                                                                                                                        */
/* DIM3_ELEM_STRA_INTG_POINT111_0    13152220    -0.000014957    0.0005172744    -0.066789597    0.0372005999             */
/* DIM3_ELEM_STRA_INTG_POINT111_1    13152220    -0.000015163    0.0005661846      -0.0287272     0.086145103             */
/* DIM3_ELEM_STRA_INTG_POINT111_2    13152220    -5.788045E-6    0.0004735127    -0.043223299    0.0618046001             */
/* DIM3_ELEM_STRA_INTG_POINT111_3    13152220    -0.000015163    0.0005661846      -0.0287272     0.086145103             */
/* DIM3_ELEM_STRA_INTG_POINT111_4    13152220    -0.000020453    0.0004383233    -0.034473501    0.0436667986             */
/* DIM3_ELEM_STRA_INTG_POINT111_5    13152220    -6.541845E-6    0.0004815602    -0.047846001    0.0630221963             */
/* DIM3_ELEM_STRA_INTG_POINT111_6    13152220    -5.788045E-6    0.0004735127    -0.043223299    0.0618046001             */
/* DIM3_ELEM_STRA_INTG_POINT111_7    13152220    -6.541845E-6    0.0004815602    -0.047846001    0.0630221963             */
/* DIM3_ELEM_STRA_INTG_POINT111_8    13152220    0.0000222444    0.0003619796    -0.056504901    0.0229783002             */
/* DIM3_ELEM_STRA_INTG_POINT112_0    13152220    -0.000011639    0.0004607151    -0.044824298    0.0411286987             */
/* DIM3_ELEM_STRA_INTG_POINT112_1    13152220    -0.000016108    0.0005735977    -0.031085299    0.0928945988             */
/* DIM3_ELEM_STRA_INTG_POINT112_2    13152220    -5.414497E-6     0.000475856      -0.0508161    0.0687439963             */
/* DIM3_ELEM_STRA_INTG_POINT112_3    13152220    -0.000016108    0.0005735977    -0.031085299    0.0928945988             */
/* DIM3_ELEM_STRA_INTG_POINT112_4    13152220    -0.000021294    0.0004487486    -0.034029901    0.0617262013             */
/* DIM3_ELEM_STRA_INTG_POINT112_5    13152220    -5.634763E-6    0.0004796541      -0.0479182    0.0685366988             */
/* DIM3_ELEM_STRA_INTG_POINT112_6    13152220    -5.414497E-6     0.000475856      -0.0508161    0.0687439963             */
/* DIM3_ELEM_STRA_INTG_POINT112_7    13152220    -5.634763E-6    0.0004796541      -0.0479182    0.0685366988             */
/* DIM3_ELEM_STRA_INTG_POINT112_8    13152220    0.0000195659    0.0003655412    -0.067204103    0.0232597999             */
/* DIM3_ELEM_STRA_INTG_POINT121_0    13152220    -0.000014243    0.0004773611    -0.041656401    0.0315479003             */
/* DIM3_ELEM_STRA_INTG_POINT121_1    13152220     -0.00001699    0.0005283069      -0.0303175    0.0939659029             */
/* DIM3_ELEM_STRA_INTG_POINT121_2    13152220    -5.551975E-6    0.0004307769    -0.040801998    0.0729108974             */
/* DIM3_ELEM_STRA_INTG_POINT121_3    13152220     -0.00001699    0.0005283069      -0.0303175    0.0939659029             */
/* DIM3_ELEM_STRA_INTG_POINT121_4    13152220    -0.000019834    0.0004545527    -0.055645999    0.0354184993             */
/* DIM3_ELEM_STRA_INTG_POINT121_5    13152220    -8.137129E-6    0.0004514711    -0.044802401    0.0648718029             */
/* DIM3_ELEM_STRA_INTG_POINT121_6    13152220    -5.551975E-6    0.0004307769    -0.040801998    0.0729108974             */
/* DIM3_ELEM_STRA_INTG_POINT121_7    13152220    -8.137129E-6    0.0004514711    -0.044802401    0.0648718029             */
/* DIM3_ELEM_STRA_INTG_POINT121_8    13152220     0.000022374    0.0003727394      -0.0538726    0.0276290998             */
/* DIM3_ELEM_STRA_INTG_POINT122_0    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT122_1    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT122_2    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT122_3    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT122_4    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT122_5    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT122_6    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT122_7    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT122_8    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT211_0    13152220    -0.000014868    0.0005104127      -0.0689345     0.037680801             */
/* DIM3_ELEM_STRA_INTG_POINT211_1    13152220    -0.000015559    0.0005503931      -0.0306668    0.0858421028             */
/* DIM3_ELEM_STRA_INTG_POINT211_2    13152220    -5.173088E-6    0.0004553422      -0.0397368    0.0581788011             */
/* DIM3_ELEM_STRA_INTG_POINT211_3    13152220    -0.000015559    0.0005503931      -0.0306668    0.0858421028             */
/* DIM3_ELEM_STRA_INTG_POINT211_4    13152220    -0.000020919    0.0004865431    -0.075473197    0.0385431014             */
/* DIM3_ELEM_STRA_INTG_POINT211_5    13152220    -7.248371E-6    0.0004811114       -0.051831    0.0674415007             */
/* DIM3_ELEM_STRA_INTG_POINT211_6    13152220    -5.173088E-6    0.0004553422      -0.0397368    0.0581788011             */
/* DIM3_ELEM_STRA_INTG_POINT211_7    13152220    -7.248371E-6    0.0004811114       -0.051831    0.0674415007             */
/* DIM3_ELEM_STRA_INTG_POINT211_8    13152220    0.0000225552    0.0003711396    -0.059320498    0.0199983008             */
/* DIM3_ELEM_STRA_INTG_POINT212_0    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT212_1    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT212_2    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT212_3    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT212_4    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT212_5    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT212_6    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT212_7    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT212_8    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT221_0    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT221_1    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT221_2    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT221_3    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT221_4    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT221_5    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT221_6    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT221_7    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT221_8    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT222_0    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT222_1    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT222_2    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT222_3    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT222_4    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT222_5    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT222_6    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT222_7    13152220               0               0               0               0             */
/* DIM3_ELEM_STRA_INTG_POINT222_8    13152220               0               0               0               0             */
/*                                                                                                                        */
/* STRESSES                                                                                                                       */
/*                                                                                                                        */
/* DIM3_ELEM_STRS_INTG_POINT111_0    13152220    -0.120076384    1.4897233124    -112.2409973    68.295501709             */
/* DIM3_ELEM_STRS_INTG_POINT111_1    13152220    -0.140515967    0.8424705647    -27.49670029    30.081399918             */
/* DIM3_ELEM_STRS_INTG_POINT111_2    13152220     -0.00983193    0.5153076458    -28.51880074    26.682899475             */
/* DIM3_ELEM_STRS_INTG_POINT111_3    13152220    -0.140515967    0.8424705647    -27.49670029    30.081399918             */
/* DIM3_ELEM_STRS_INTG_POINT111_4    13152220    -0.227282297     1.451523419    -115.3440018    47.465499878             */
/* DIM3_ELEM_STRS_INTG_POINT111_5    13152220     -0.01093683    0.5068469861    -29.29490089    24.471700668             */
/* DIM3_ELEM_STRS_INTG_POINT111_6    13152220     -0.00983193    0.5153076458    -28.51880074    26.682899475             */
/* DIM3_ELEM_STRS_INTG_POINT111_7    13152220     -0.01093683    0.5068469861    -29.29490089    24.471700668             */
/* DIM3_ELEM_STRS_INTG_POINT111_8    13152220    -0.003813428    0.9135924239    -107.7919998    62.587799072             */
/* DIM3_ELEM_STRS_INTG_POINT112_0    13152220    -0.117725377    1.4363552573    -128.0480042    62.070701599             */
/* DIM3_ELEM_STRS_INTG_POINT112_1    13152220     -0.14328069    0.8406739232    -28.11860085    29.990699768             */
/* DIM3_ELEM_STRS_INTG_POINT112_2    13152220    -0.009076626    0.5349670851     -27.9211998    26.826799393             */
/* DIM3_ELEM_STRS_INTG_POINT112_3    13152220     -0.14328069    0.8406739232    -28.11860085    29.990699768             */
/* DIM3_ELEM_STRS_INTG_POINT112_4    13152220    -0.230938827    1.4700011438    -123.1230011    44.703399658             */
/* DIM3_ELEM_STRS_INTG_POINT112_5    13152220    -0.009841181    0.4988816513    -30.82439995    23.216499329             */
/* DIM3_ELEM_STRS_INTG_POINT112_6    13152220    -0.009076626    0.5349670851     -27.9211998    26.826799393             */
/* DIM3_ELEM_STRS_INTG_POINT112_7    13152220    -0.009841181    0.4988816513    -30.82439995    23.216499329             */
/* DIM3_ELEM_STRS_INTG_POINT112_8    13152220    -0.007157854    0.9107224307    -131.0319977    42.670799255             */
/* DIM3_ELEM_STRS_INTG_POINT121_0    13152220    -0.116476122    1.4037202684    -117.0080032    74.212402344             */
/* DIM3_ELEM_STRS_INTG_POINT121_1    13152220    -0.142357138    0.8226374952    -27.89760017    30.727399826             */
/* DIM3_ELEM_STRS_INTG_POINT121_2    13152220    -0.009151369    0.4859245685    -27.16670036    26.794799805             */
/* DIM3_ELEM_STRS_INTG_POINT121_3    13152220    -0.142357138    0.8226374952    -27.89760017    30.727399826             */
/* DIM3_ELEM_STRS_INTG_POINT121_4    13152220    -0.221522815    1.3976728038    -157.2859955    58.991798401             */
/* DIM3_ELEM_STRS_INTG_POINT121_5    13152220    -0.012184155    0.4861105266     -29.1590004    23.203399658             */
/* DIM3_ELEM_STRS_INTG_POINT121_6    13152220    -0.009151369    0.4859245685    -27.16670036    26.794799805             */
/* DIM3_ELEM_STRS_INTG_POINT121_7    13152220    -0.012184155    0.4861105266     -29.1590004    23.203399658             */
/* DIM3_ELEM_STRS_INTG_POINT121_8    13152220    0.0008503627    0.7993188045    -110.8590012     61.52519989             */
/* DIM3_ELEM_STRS_INTG_POINT122_0    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT122_1    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT122_2    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT122_3    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT122_4    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT122_5    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT122_6    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT122_7    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT122_8    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT211_0    13152220    -0.120049483    1.5159829347    -130.6699982    68.435798645             */
/* DIM3_ELEM_STRS_INTG_POINT211_1    13152220    -0.140199161    0.8424688502    -28.94529915    30.041500092             */
/* DIM3_ELEM_STRS_INTG_POINT211_2    13152220    -0.008961691    0.5012292328    -29.01370049    26.557699204             */
/* DIM3_ELEM_STRS_INTG_POINT211_3    13152220    -0.140199161    0.8424688502    -28.94529915    30.041500092             */
/* DIM3_ELEM_STRS_INTG_POINT211_4    13152220    -0.227744426    1.5414251357    -127.1039963    48.518600464             */
/* DIM3_ELEM_STRS_INTG_POINT211_5    13152220    -0.011590062    0.5143034596    -29.78779984    24.642299652             */
/* DIM3_ELEM_STRS_INTG_POINT211_6    13152220    -0.008961691    0.5012292328    -29.01370049    26.557699204             */
/* DIM3_ELEM_STRS_INTG_POINT211_7    13152220    -0.011590062    0.5143034596    -29.78779984    24.642299652             */
/* DIM3_ELEM_STRS_INTG_POINT211_8    13152220    -0.003645413    0.9343321689    -103.9189987    57.078800201             */
/* DIM3_ELEM_STRS_INTG_POINT212_0    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT212_1    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT212_2    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT212_3    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT212_4    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT212_5    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT212_6    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT212_7    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT212_8    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT221_0    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT221_1    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT221_2    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT221_3    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT221_4    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT221_5    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT221_6    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT221_7    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT221_8    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT222_0    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT222_1    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT222_2    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT222_3    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT222_4    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT222_5    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT222_6    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT222_7    13152220               0               0               0               0             */
/* DIM3_ELEM_STRS_INTG_POINT222_8    13152220               0               0               0               0             */
/**************************************************************************************************************************/

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/
1                                          Altair SLC            13:34 Sunday, May 24, 2026

NOTE: Copyright 2002-2025 World Programming, an Altair Company
NOTE: Altair SLC 2026 (05.26.01.00.000758)
      Licensed to Roger DeAngelis
NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
NOTE: AUTOEXEC source line
1       +  ï»¿ods _all_ close;
           ^
ERROR: Expected a statement keyword : found "?"

NOTE: AUTOEXEC processing completed

1
2         data WORKX.GPS_DATA(drop=empty); /*--- csv has extra comma on the end of all records ---*/
3
4         infile "d:/rad/cell_data.csv" delimiter = ',' MISSOVER DSD firstobs=2;
5
6         /**************************************************************************************************************************/
7         /*                                                                                                                        */
8         /* These variables are the strain tensor components at specific                                                           */
9         /* integration points within each 3D brick element in your cell phone drop simulation.                                    */
10        /*                                                                                                                        */
11        /* 3D Element        Part            Meaning                                                                              */
12        /*                                                                                                                        */
13        /* 1st Columnm      Dim3_DELEM        3D Element (brick/hexahedron element)                                               */
14        /*                  Stra              Strain (as opposed to Strs for Stress)                                              */
15        /*                  Intg_Point        Integration point (Gauss point within the element)                                  */
16        /*                  111               Integration point location indices                                                  */
17        /*                  :0                Tensor component index                                                              */
18        /*                  ...                                                                                                   */
19        /*                  ...                                                                                                   */
20        /* 149th Column     Dim3_DELEM        3D Element (brick/hexahedron element)                                               */
21        /*                  Stra              Strain (as opposed to Strs for Stress)                                              */
22        /*                  Intg_Point        Integration point (Gauss point within the element)                                  */
23        /*                  222               Integration point location indices                                                  */
24        /*                  :8                Tensor component index                                                              */
25        /**************************************************************************************************************************/
26
27
28        label
29            ELEMENT_ID     = "Element identification number"
30
31            Dim3_ELEM_Stra_Intg_Point111_0 = "Strain exx at integration point 111 (bottom-lower-left)"
32            Dim3_ELEM_Stra_Intg_Point111_1 = "Strain eyy at integration point 111 (bottom-lower-left)"
33            Dim3_ELEM_Stra_Intg_Point111_2 = "Strain ezz at integration point 111 (bottom-lower-left)"
34            Dim3_ELEM_Stra_Intg_Point111_3 = "Shear strain exy at integration point 111"
35            Dim3_ELEM_Stra_Intg_Point111_4 = "Shear strain eyz at integration point 111"
36            Dim3_ELEM_Stra_Intg_Point111_5 = "Shear strain ezx at integration point 111"
37            Dim3_ELEM_Stra_Intg_Point111_6 = "Additional Component (if needed)"
38            Dim3_ELEM_Stra_Intg_Point111_7 = "Additional Component (if needed)"
39            Dim3_ELEM_Stra_Intg_Point111_8 = "Additional Component (if needed)"
40        ;
41
42        input
43            Dim3_ELEM_Stra_Intg_Point111_0
44            Dim3_ELEM_Stra_Intg_Point111_1
45            Dim3_ELEM_Stra_Intg_Point111_2
46            Dim3_ELEM_Stra_Intg_Point111_3
47            Dim3_ELEM_Stra_Intg_Point111_4
48            Dim3_ELEM_Stra_Intg_Point111_5
49            Dim3_ELEM_Stra_Intg_Point111_6
50            Dim3_ELEM_Stra_Intg_Point111_7
51            Dim3_ELEM_Stra_Intg_Point111_8
52            Dim3_ELEM_Stra_Intg_Point112_0
53            Dim3_ELEM_Stra_Intg_Point112_1
54            Dim3_ELEM_Stra_Intg_Point112_2
55            Dim3_ELEM_Stra_Intg_Point112_3
56            Dim3_ELEM_Stra_Intg_Point112_4
57            Dim3_ELEM_Stra_Intg_Point112_5
58            Dim3_ELEM_Stra_Intg_Point112_6
59            Dim3_ELEM_Stra_Intg_Point112_7
60            Dim3_ELEM_Stra_Intg_Point112_8
61            Dim3_ELEM_Stra_Intg_Point121_0
62            Dim3_ELEM_Stra_Intg_Point121_1
63            Dim3_ELEM_Stra_Intg_Point121_2
64            Dim3_ELEM_Stra_Intg_Point121_3
65            Dim3_ELEM_Stra_Intg_Point121_4
66            Dim3_ELEM_Stra_Intg_Point121_5
67            Dim3_ELEM_Stra_Intg_Point121_6
68            Dim3_ELEM_Stra_Intg_Point121_7
69            Dim3_ELEM_Stra_Intg_Point121_8
70            Dim3_ELEM_Stra_Intg_Point122_0
71            Dim3_ELEM_Stra_Intg_Point122_1
72            Dim3_ELEM_Stra_Intg_Point122_2
73            Dim3_ELEM_Stra_Intg_Point122_3
74            Dim3_ELEM_Stra_Intg_Point122_4
75            Dim3_ELEM_Stra_Intg_Point122_5
76            Dim3_ELEM_Stra_Intg_Point122_6
77            Dim3_ELEM_Stra_Intg_Point122_7
78            Dim3_ELEM_Stra_Intg_Point122_8
79            Dim3_ELEM_Stra_Intg_Point211_0
80            Dim3_ELEM_Stra_Intg_Point211_1
81            Dim3_ELEM_Stra_Intg_Point211_2
82            Dim3_ELEM_Stra_Intg_Point211_3
83            Dim3_ELEM_Stra_Intg_Point211_4
84            Dim3_ELEM_Stra_Intg_Point211_5
85            Dim3_ELEM_Stra_Intg_Point211_6
86            Dim3_ELEM_Stra_Intg_Point211_7
87            Dim3_ELEM_Stra_Intg_Point211_8
88            Dim3_ELEM_Stra_Intg_Point212_0
89            Dim3_ELEM_Stra_Intg_Point212_1
90            Dim3_ELEM_Stra_Intg_Point212_2
91            Dim3_ELEM_Stra_Intg_Point212_3
92            Dim3_ELEM_Stra_Intg_Point212_4
93            Dim3_ELEM_Stra_Intg_Point212_5
94            Dim3_ELEM_Stra_Intg_Point212_6
95            Dim3_ELEM_Stra_Intg_Point212_7
96            Dim3_ELEM_Stra_Intg_Point212_8
97            Dim3_ELEM_Stra_Intg_Point221_0
98            Dim3_ELEM_Stra_Intg_Point221_1
99            Dim3_ELEM_Stra_Intg_Point221_2
100           Dim3_ELEM_Stra_Intg_Point221_3
101           Dim3_ELEM_Stra_Intg_Point221_4
102           Dim3_ELEM_Stra_Intg_Point221_5
103           Dim3_ELEM_Stra_Intg_Point221_6
104           Dim3_ELEM_Stra_Intg_Point221_7
105           Dim3_ELEM_Stra_Intg_Point221_8
106           Dim3_ELEM_Stra_Intg_Point222_0
107           Dim3_ELEM_Stra_Intg_Point222_1
108           Dim3_ELEM_Stra_Intg_Point222_2
109           Dim3_ELEM_Stra_Intg_Point222_3
110           Dim3_ELEM_Stra_Intg_Point222_4
111           Dim3_ELEM_Stra_Intg_Point222_5
112           Dim3_ELEM_Stra_Intg_Point222_6
113           Dim3_ELEM_Stra_Intg_Point222_7
114           Dim3_ELEM_Stra_Intg_Point222_8
115           Dim3_ELEM_Strs_Intg_Point111_0
116           Dim3_ELEM_Strs_Intg_Point111_1
117           Dim3_ELEM_Strs_Intg_Point111_2
118           Dim3_ELEM_Strs_Intg_Point111_3
119           Dim3_ELEM_Strs_Intg_Point111_4
120           Dim3_ELEM_Strs_Intg_Point111_5
121           Dim3_ELEM_Strs_Intg_Point111_6
122           Dim3_ELEM_Strs_Intg_Point111_7
123           Dim3_ELEM_Strs_Intg_Point111_8
124           Dim3_ELEM_Strs_Intg_Point112_0
125           Dim3_ELEM_Strs_Intg_Point112_1
126           Dim3_ELEM_Strs_Intg_Point112_2
127           Dim3_ELEM_Strs_Intg_Point112_3
128           Dim3_ELEM_Strs_Intg_Point112_4
129           Dim3_ELEM_Strs_Intg_Point112_5
130           Dim3_ELEM_Strs_Intg_Point112_6
131           Dim3_ELEM_Strs_Intg_Point112_7
132           Dim3_ELEM_Strs_Intg_Point112_8
133           Dim3_ELEM_Strs_Intg_Point121_0
134           Dim3_ELEM_Strs_Intg_Point121_1
135           Dim3_ELEM_Strs_Intg_Point121_2
136           Dim3_ELEM_Strs_Intg_Point121_3
137           Dim3_ELEM_Strs_Intg_Point121_4
138           Dim3_ELEM_Strs_Intg_Point121_5
139           Dim3_ELEM_Strs_Intg_Point121_6
140           Dim3_ELEM_Strs_Intg_Point121_7
141           Dim3_ELEM_Strs_Intg_Point121_8
142           Dim3_ELEM_Strs_Intg_Point122_0
143           Dim3_ELEM_Strs_Intg_Point122_1
144           Dim3_ELEM_Strs_Intg_Point122_2
145           Dim3_ELEM_Strs_Intg_Point122_3
146           Dim3_ELEM_Strs_Intg_Point122_4
147           Dim3_ELEM_Strs_Intg_Point122_5
148           Dim3_ELEM_Strs_Intg_Point122_6
149           Dim3_ELEM_Strs_Intg_Point122_7
150           Dim3_ELEM_Strs_Intg_Point122_8
151           Dim3_ELEM_Strs_Intg_Point211_0
152           Dim3_ELEM_Strs_Intg_Point211_1
153           Dim3_ELEM_Strs_Intg_Point211_2
154           Dim3_ELEM_Strs_Intg_Point211_3
155           Dim3_ELEM_Strs_Intg_Point211_4
156           Dim3_ELEM_Strs_Intg_Point211_5
157           Dim3_ELEM_Strs_Intg_Point211_6
158           Dim3_ELEM_Strs_Intg_Point211_7
159           Dim3_ELEM_Strs_Intg_Point211_8
160           Dim3_ELEM_Strs_Intg_Point212_0
161           Dim3_ELEM_Strs_Intg_Point212_1
162           Dim3_ELEM_Strs_Intg_Point212_2
163           Dim3_ELEM_Strs_Intg_Point212_3
164           Dim3_ELEM_Strs_Intg_Point212_4
165           Dim3_ELEM_Strs_Intg_Point212_5
166           Dim3_ELEM_Strs_Intg_Point212_6
167           Dim3_ELEM_Strs_Intg_Point212_7
168           Dim3_ELEM_Strs_Intg_Point212_8
169           Dim3_ELEM_Strs_Intg_Point221_0
170           Dim3_ELEM_Strs_Intg_Point221_1
171           Dim3_ELEM_Strs_Intg_Point221_2
172           Dim3_ELEM_Strs_Intg_Point221_3
173           Dim3_ELEM_Strs_Intg_Point221_4
174           Dim3_ELEM_Strs_Intg_Point221_5
175           Dim3_ELEM_Strs_Intg_Point221_6
176           Dim3_ELEM_Strs_Intg_Point221_7
177           Dim3_ELEM_Strs_Intg_Point221_8
178           Dim3_ELEM_Strs_Intg_Point222_0
179           Dim3_ELEM_Strs_Intg_Point222_1
180           Dim3_ELEM_Strs_Intg_Point222_2
181           Dim3_ELEM_Strs_Intg_Point222_3
182           Dim3_ELEM_Strs_Intg_Point222_4
183           Dim3_ELEM_Strs_Intg_Point222_5
184           Dim3_ELEM_Strs_Intg_Point222_6
185           Dim3_ELEM_Strs_Intg_Point222_7
186           Dim3_ELEM_Strs_Intg_Point222_8
187           ELEMENT_ID
188           EROSION_STATUS
189           PART_ID
190           Cell_Type  empty  best32.;
191         *if _n_=100000 then stop;
192       run;

NOTE: The infile 'd:\rad\cell_data.csv' is:
      Filename='d:\rad\cell_data.csv',
      Owner Name=SLC\suzie,
      File size (bytes)=17062608392,
      Create Time=15:02:30 May 23 2026,
      Last Accessed=13:32:37 May 24 2026,
      Last Modified=15:39:38 May 23 2026,
      Lrecl=32767, Recfm=V

NOTE: 13152220 records were read from file 'd:\rad\cell_data.csv'
      The minimum record length was 295
      The maximum record length was 1526
NOTE: Data set "WORKX.GPS_DATA" has 13152220 observation(s) and 148 variable(s)
NOTE: The data step took :
      real time : 7:48.324
      cpu time  : 7:45.562


193
194       options ls=255;
195       /* Generate summary statistics */
196       proc means data=WORKX.GPS_DATA n mean std min max;
197       run;
NOTE: 13152220 observations were read from "WORKX.GPS_DATA"
NOTE: Procedure means step took :
      real time : 1:03.708
      cpu time  : 1:03.421


ERROR: Error printed on page 1

NOTE: Submitted statements took :
      real time : 8:52.130
      cpu time  : 8:49.062

/*     _       _           _
  __ _| | ___ | |__   __ _| |   ___ _ __   ___ _ __ __ _ _   _
 / _` | |/ _ \| `_ \ / _` | |  / _ \ `_ \ / _ \ `__/ _` | | | |
| (_| | | (_) | |_) | (_| | | |  __/ | | |  __/ | | (_| | |_| |
 \__, |_|\___/|_.__/ \__,_|_|  \___|_| |_|\___|_|  \__, |\__, |
 |___/                                             |___/ |___/
*/

data WORKX.GLOBAL_ENERGY(drop=empty);  /*--- handle extra comma ---*/

infile "d:/rad/global_energy_data.csv" delimiter = ',' MISSOVER DSD lrecl=32756 firstobs=2 ;

label
             GPS_SIGXX = "Stress XX at GPS sensor (MPa)"
             GPS_SIGXY = "Stress XY shear at GPS sensor (MPa)"
             GPS_SIGXZ = "Stress XZ shear at GPS sensor (MPa)"
             GPS_SIGYY = "Stress YY at GPS sensor (MPa)"
             GPS_SIGZY = "Stress ZY shear at GPS sensor (MPa)"
             GPS_SIGZZ = "Stress ZZ at GPS sensor (MPa)"
             NODE_ID   = "Node identification number"
             Points_0  = "X-coordinate (mm)"
             Points_1  = "Y-coordinate (mm)"
             Points_2  = "Z-coordinate (mm)"
;

input
            GPS_SIGXX
            GPS_SIGXY
            GPS_SIGXZ
            GPS_SIGYY
            GPS_SIGZY
            GPS_SIGZZ
            NODE_ID
            Points_0
            Points_1
            Points_2 empty best32.
;
run;

/**************************************************************************************************************************/
/*  Up to 40 obs from last table WORKX.GLOBAL_ENERGY total obs=101                                                        */
/*                                                                                                                        */
/*          GPS_      GPS_    GPS_        GPS_      GPS_      GPS_                                                        */
/* Obs     SIGXX     SIGXY    SIGXZ      SIGYY     SIGZY     SIGZZ       NODE_ID       POINTS_0    POINTS_1    POINTS_2   */
/*                                                                                                                        */
/*   1    0.0000    0.0000   0.00000    0.0000    0.0000    0.0000    467837775.55     0.054489    -16.4418     1.55229   */
/*   2   -0.9264   -0.2659  -0.20370   -0.9336   -0.0398   -0.5461    467836957.92     0.051291    -16.4453     1.54967   */
/*   3   -0.9207   -0.4198  -0.12195   -1.1652   -0.0598   -0.6451    467837083.51     0.048093    -16.4488     1.54705   */
/*   4   -1.0634   -0.6411  -0.05070   -1.8052   -0.0585   -1.3682    467837051.94     0.044907    -16.4523     1.54443   */
/*   5    0.2801   -0.9327  -0.20816   -1.6527    0.0509   -1.2113    467837882.58     0.041678    -16.4558     1.54181   */
/* ...                                                                                                                    */
/*  97   34.2001  -29.5875  -23.9653  -172.429   36.3439  -35.7879    467846983.80    -0.25343    -16.7797     1.30114    */
/*  98   35.4223  -26.3815  -24.2088  -168.140   36.9509  -35.6313    467845980.86    -0.25667    -16.7832     1.29853    */
/*  99   35.8986  -23.8377  -24.8308  -163.574   37.4212  -34.9684    467846127.08    -0.25988    -16.7867     1.29593    */
/* 100   36.6077  -21.5877  -24.6456  -158.930   37.6638  -33.9796    467846387.48    -0.26311    -16.7903     1.29332    */
/* 101   36.9532  -19.1455  -24.7018  -154.589   37.5434  -33.0585    467844434.02    -0.26632    -16.7938     1.29071    */
/**************************************************************************************************************************/

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

1                                          Altair SLC            15:25 Sunday, May 24, 2026

NOTE: Copyright 2002-2025 World Programming, an Altair Company
NOTE: Altair SLC 2026 (05.26.01.00.000758)
      Licensed to Roger DeAngelis
NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
NOTE: AUTOEXEC source line
1       +  ï»¿ods _all_ close;
           ^
NOTE: AUTOEXEC processing completed

1         data WORKX.GLOBAL_ENERGY(drop=empty);  /*--- handle extra comma ---*/
2
3         infile "d:/rad/global_energy_data.csv" delimiter = ',' MISSOVER DSD lrecl=32756 firstobs=2 ;
4
5         label
6                      GPS_SIGXX = "Stress XX at GPS sensor (MPa)"
7                      GPS_SIGXY = "Stress XY shear at GPS sensor (MPa)"
8                      GPS_SIGXZ = "Stress XZ shear at GPS sensor (MPa)"
9                      GPS_SIGYY = "Stress YY at GPS sensor (MPa)"
10                     GPS_SIGZY = "Stress ZY shear at GPS sensor (MPa)"
11                     GPS_SIGZZ = "Stress ZZ at GPS sensor (MPa)"
12                     NODE_ID   = "Node identification number"
13                     Points_0  = "X-coordinate (mm)"
14                     Points_1  = "Y-coordinate (mm)"
15                     Points_2  = "Z-coordinate (mm)"
16        ;
17
18        input
19                    GPS_SIGXX
20                    GPS_SIGXY
21                    GPS_SIGXZ
22                    GPS_SIGYY
23                    GPS_SIGZY
24                    GPS_SIGZZ
25                    NODE_ID
26                    Points_0
27                    Points_1
28                    Points_2 empty best32.
29        ;
30        run;

NOTE: The infile 'd:\rad\global_energy_data.csv' is:
      Filename='d:\rad\global_energy_data.csv',
      Owner Name=SLC\suzie,
      File size (bytes)=14926,
      Create Time=14:51:20 May 23 2026,
      Last Accessed=15:17:38 Jun 01 2022,
      Last Modified=15:02:30 May 23 2026,
      Lrecl=32756, Recfm=V

NOTE: 101 records were read from file 'd:\rad\global_energy_data.csv'
      The minimum record length was 67
      The maximum record length was 153
NOTE: Data set "WORKX.GLOBAL_ENERGY" has 101 observation(s) and 10 variable(s)
NOTE: The data step took :
      real time : 0.018
      cpu time  : 0.015


ERROR: Error printed on page 1

NOTE: Submitted statements took :
      real time : 0.104
      cpu time  : 0.062
/*  ___                       _                         _  _     __                             _   _       _  __
/ |/ _ \   ___ _ __ ___  __ _| |_ ___   _ __ ___  _ __ | || |   / _|_ __ ___  _ __ ___   __   _| |_| | ____| |/ _|
| | | | | / __| `__/ _ \/ _` | __/ _ \ | `_ ` _ \| `_ \| || |_ | |_| `__/ _ \| `_ ` _ \  \ \ / / __| |/ / _` | |_
| | |_| || (__| | |  __/ (_| | ||  __/ | | | | | | |_) |__   _||  _| | | (_) | | | | | |  \ V /| |_|   < (_| |  _|
|_|\___/  \___|_|  \___|\__,_|\__\___| |_| |_| |_| .__/   |_|  |_| |_|  \___/|_| |_| |_|   \_/  \__|_|\_\__,_|_|
                                                 |_|
*/

 %slc_pvpybegin;
cards4;
#!/usr/bin/env python
"""
Convert VTKHDF to MP4 using GPS stress data (since element stress is zero).
"""

from paraview.simple import *
import os
import subprocess

# ============================================================
# CONFIGURATION
# ============================================================
VTKHDF_FILE = "D:/rad/Cell_Phone_Drop.vtkhdf"
OUTPUT_DIR = "D:/rad/frames"
OUTPUT_VIDEO = "D:/rad/animation.mp4"
FRAME_RATE = 30

IMAGE_WIDTH = 1920
IMAGE_HEIGHT = 1080

CAMERA_POSITION = [0, 0, 15]
CAMERA_FOCAL_POINT = [0, 0, 0]
CAMERA_VIEW_UP = [0, 1, 0]
USE_PARALLEL_PROJECTION = True
PARALLEL_SCALE = 5.0

# Use GPS point data since element stress is zero
COLOR_ARRAY = "GPS_SIGXX"  # Options: GPS_SIGXX, GPS_SIGYY, GPS_SIGZZ
COLOR_MAP = "Cool to Warm"

# ============================================================
# CREATE OUTPUT DIRECTORY
# ============================================================
os.makedirs(OUTPUT_DIR, exist_ok=True)

print("=" * 60)
print("VTKHDF to MP4 Converter (using GPS stress data)")
print("=" * 60)
print(f"Input file: {VTKHDF_FILE}")
print(f"Output video: {OUTPUT_VIDEO}")
print(f"Frame rate: {FRAME_RATE} fps")

# ============================================================
# LOAD THE VTKHDF FILE
# ============================================================
if not os.path.exists(VTKHDF_FILE):
    print(f"ERROR: File not found: {VTKHDF_FILE}")
    exit(1)

print("\nLoading VTKHDF file...")
source = OpenDataFile(VTKHDF_FILE)
source.UpdatePipeline()

timesteps = source.TimestepValues
num_frames = len(timesteps) if timesteps else 1
print(f"Found {num_frames} time steps")

# ============================================================
# DISPLAY AVAILABLE DATA ARRAYS
# ============================================================
print("\n--- Available Data Arrays ---")
print(f"Point Data: {list(source.PointData.keys())}")
print(f"Cell Data: {list(source.CellData.keys())}")

# ============================================================
# CREATE RENDER VIEW
# ============================================================
print("\nSetting up render view...")
renderView = CreateView('RenderView')
renderView.ViewSize = [IMAGE_WIDTH, IMAGE_HEIGHT]
AssignViewToLayout(renderView)

display = Show(source, renderView)
display.Representation = 'Surface'

# ============================================================
# APPLY COLORING USING GPS DATA
# ============================================================
print(f"\nApplying coloring using '{COLOR_ARRAY}'...")

if COLOR_ARRAY in source.PointData.keys():
    # Color by point data (GPS points)
    display.ColorArrayName = ['POINTS', COLOR_ARRAY]
    display.SetScalarBarVisibility(renderView, True)

    # Get the color transfer function
    lut = GetColorTransferFunction(COLOR_ARRAY)

    if COLOR_MAP == "Cool to Warm":
        lut.ColorSpace = 'Diverging'
    elif COLOR_MAP == "Jet":
        lut.ColorSpace = 'RGB'

    # Get the actual data range
    data_range = source.PointData.GetArray(COLOR_ARRAY).GetRange()
    print(f"  Data range: {data_range[0]:.6f} to {data_range[1]:.6f}")

    if data_range[1] > 0:
        lut.RescaleTransferFunction(data_range[0], data_range[1])
        print(f"  Color map '{COLOR_MAP}' applied")
    else:
        print("  WARNING: Data range is zero - no variation in data")
else:
    print(f"  ERROR: '{COLOR_ARRAY}' not found in Point Data")
    print("  Available Point Data arrays:", list(source.PointData.keys()))

display.Representation = 'Surface'
renderView.Background = [0.1, 0.2, 0.4]

# ============================================================
# SET UP CAMERA
# ============================================================
renderView.CameraPosition = CAMERA_POSITION
renderView.CameraFocalPoint = CAMERA_FOCAL_POINT
renderView.CameraViewUp = CAMERA_VIEW_UP

if USE_PARALLEL_PROJECTION:
    renderView.CameraParallelProjection = 1
    renderView.CameraParallelScale = PARALLEL_SCALE
else:
    renderView.CameraParallelProjection = 0

renderView.ResetCamera()
Render()

# ============================================================
# CONFIGURE ANIMATION
# ============================================================
animationScene = GetAnimationScene()
animationScene.NumberOfFrames = num_frames
animationScene.StartTime = 0
animationScene.EndTime = num_frames - 1
animationScene.PlayMode = 'Sequence'

# ============================================================
# SAVE FRAMES
# ============================================================
print(f"\nSaving {num_frames} frames to {OUTPUT_DIR}...")

for i in range(num_frames):
    animationScene.TimeKeeper.Time = i
    source.UpdatePipeline(i)
    Render()

    frame_file = os.path.join(OUTPUT_DIR, f"frame_{i+1:04d}.png")
    SaveScreenshot(frame_file, renderView, ImageResolution=[IMAGE_WIDTH, IMAGE_HEIGHT])

    if (i + 1) % 10 == 0 or (i + 1) == num_frames:
        print(f"  Saved frame {i+1}/{num_frames}")

print(f"\nFrames saved to: {OUTPUT_DIR}")

# ============================================================
# CONVERT TO MP4
# ============================================================
print("\n" + "=" * 50)
print("Converting PNG sequence to MP4...")
print("=" * 50)

ffmpeg_cmd = None
ffmpeg_paths = ['ffmpeg', 'C:\\ffmpeg\\bin\\ffmpeg.exe', 'D:\\ffmpeg\\bin\\ffmpeg.exe']

for path in ffmpeg_paths:
    try:
        subprocess.run([path, '-version'], capture_output=True, check=True)
        ffmpeg_cmd = path
        break
    except (subprocess.SubprocessError, FileNotFoundError):
        continue

if ffmpeg_cmd:
    input_pattern = os.path.join(OUTPUT_DIR, "frame_%04d.png").replace('\\', '/')
    output_video = OUTPUT_VIDEO.replace('\\', '/')

    ffmpeg_command = [
        ffmpeg_cmd, '-framerate', str(FRAME_RATE),
        '-i', input_pattern,
        '-vf', 'pad=1920:1062:(ow-iw)/2:(oh-ih)/2',
        '-c:v', 'libx264',
        '-pix_fmt', 'yuv420p',
        '-crf', '18',
        '-y', output_video
    ]

    print(f"Running FFmpeg...")
    try:
        result = subprocess.run(ffmpeg_command, capture_output=True, text=True)
        if result.returncode == 0 and os.path.exists(OUTPUT_VIDEO):
            size_mb = os.path.getsize(OUTPUT_VIDEO) / (1024 * 1024)
            print(f"\nSUCCESS! MP4 created: {OUTPUT_VIDEO}")
            print(f"File size: {size_mb:.2f} MB")
        else:
            print(f"\nFFmpeg failed. Run this command manually:")
            print(f'ffmpeg -framerate {FRAME_RATE} -i "{OUTPUT_DIR}/frame_%04d.png" -vf "pad=1920:1062:(ow-iw)/2:(oh-ih)/2" -c:v libx264 -pix_fmt yuv420p -crf 18 -y {OUTPUT_VIDEO}')
    except Exception as e:
        print(f"\nError: {e}")
        print(f'ffmpeg -framerate {FRAME_RATE} -i "{OUTPUT_DIR}/frame_%04d.png" -vf "pad=1920:1062:(ow-iw)/2:(oh-ih)/2" -c:v libx264 -pix_fmt yuv420p -crf 18 -y {OUTPUT_VIDEO}')
else:
    print("\nFFmpeg not found. Run this command manually:")
    print(f'ffmpeg -framerate {FRAME_RATE} -i "{OUTPUT_DIR}/frame_%04d.png" -vf "pad=1920:1062:(ow-iw)/2:(oh-ih)/2" -c:v libx264 -pix_fmt yuv420p -crf 18 -y {OUTPUT_VIDEO}')

print("\n" + "=" * 60)
print("PROCESS COMPLETE")
print("=" * 60)
print(f"Animation saved to: {OUTPUT_VIDEO}")
;;;;
%slc_pvpyend;


/**************************************************************************************************************************/
/*   Altair SLC                                                                                                           */
/*  ============================================================                                                          */
/*  VTKHDF to MP4 Converter (using GPS stress data)                                                                       */
/*  ============================================================                                                          */
/*  Input file: D:/rad/Cell_Phone_Drop.vtkhdf                                                                             */
/*  Output video: D:/rad/animation.mp4                                                                                    */
/*  Frame rate: 30 fps                                                                                                    */
/*                                                                                                                        */
/*  Loading VTKHDF file...                                                                                                */
/*  Found 101 time steps                                                                                                  */
/*                                                                                                                        */
/*  --- Available Data Arrays ---                                                                                         */
/*  Point Data: ['GPS_SIGXX', 'GPS_SIGXY', 'GPS_SIGXZ', 'GPS_SIGYY', 'GPS_SIGZY', 'GPS_SIGZZ', 'NODE_ID']                 */
/*  Cell Data: ['3DELEM_Stra_Intg_Point111__', '3DELEM_Stra_Intg_Point112__', '3DELEM_Stra_Intg_Point121__',              */
/*   '3DELEM_Stra_Intg_Point122__', '3DELEM_Stra_Intg_Point211__', '3DELEM_Stra_Intg_Point212__',                         */
/*   '3DELEM_Stra_Intg_Point221__', '3DELEM_Stra_Intg_Point222                                                            */
/*  __', '3DELEM_Strs_Intg_Point111__', '3DELEM_Strs_Intg_Point112__', '3DELEM_Strs_Intg_Point121__',                     */
/*   '3DELEM_Strs_Intg_Point122__', '3DELEM_Strs_Intg_Point211__', '3DELEM_Strs_Intg_Point212__',                         */
/*   '3DELEM_Strs_Intg_Point221__', '3DELEM_Strs_Intg_Point222__', 'E                                                     */
/*  LEMENT_ID', 'EROSION_STATUS', 'PART_ID']                                                                              */
/*                                                                                                                        */
/*  Setting up render view...                                                                                             */
/*                                                                                                                        */
/*  Applying coloring using 'GPS_SIGXX'...                                                                                */
/*    Data range: 0.000000 to 0.000000                                                                                    */
/*    WARNING: Data range is zero - no variation in data                                                                  */
/*                                                                                                                        */
/*  Saving 101 frames to D:/rad/frames...                                                                                 */
/*    Saved frame 10/101                                                                                                  */
/*    Saved frame 20/101                                                                                                  */
/*    Saved frame 30/101                                                                                                  */
/*    Saved frame 40/101                                                                                                  */
/*    Saved frame 50/101                                                                                                  */
/*    Saved frame 60/101                                                                                                  */
/*    Saved frame 70/101                                                                                                  */
/*    Saved frame 80/101                                                                                                  */
/*    Saved frame 90/101                                                                                                  */
/*    Saved frame 100/101                                                                                                 */
/*    Saved frame 101/101                                                                                                 */
/*                                                                                                                        */
/*  Frames saved to: D:/rad/frames                                                                                        */
/*                                                                                                                        */
/*  ==================================================                                                                    */
/*  Converting PNG sequence to MP4...                                                                                     */
/*  ==================================================                                                                    */
/*  Running FFmpeg...                                                                                                     */
/*                                                                                                                        */
/*  SUCCESS! MP4 created: D:/rad/animation.mp4                                                                            */
/*  File size: 0.21 MB                                                                                                    */
/*                                                                                                                        */
/*  ============================================================                                                          */
/*  PROCESS COMPLETE                                                                                                      */
/*  ============================================================                                                          */
/*  Animation saved to: D:/rad/animation.mp4                                                                              */
/**************************************************************************************************************************/

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

1                                          Altair SLC            16:01 Sunday, May 24, 2026

NOTE: Copyright 2002-2025 World Programming, an Altair Company
NOTE: Altair SLC 2026 (05.26.01.00.000758)
      Licensed to Roger DeAngelis
NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
NOTE: AUTOEXEC source line
1       +  ï»¿ods _all_ close;
           ^
ERROR: Expected a statement keyword : found "?"

NOTE: AUTOEXEC processing completed

1           %slc_pvpybegin;
The file c:/temp/py_pgm.py does not exist
2         cards4;

NOTE: The file 'c:\temp\py_pgmx.py' is:
      Filename='c:\temp\py_pgmx.py',
      Owner Name=SLC\suzie,
      File size (bytes)=0,
      Create Time=13:21:25 Jan 12 2026,
      Last Accessed=16:01:22 May 24 2026,
      Last Modified=16:01:22 May 24 2026,
      Lrecl=32767, Recfm=V

NOTE: 205 records were written to file 'c:\temp\py_pgmx.py'
      The minimum record length was 80
      The maximum record length was 181
NOTE: The data step took :
      real time : 0.000
      cpu time  : 0.015


3         #!/usr/bin/env python
4         """
5         Convert VTKHDF to MP4 using GPS stress data (since element stress is zero).
6         """
7
8         from paraview.simple import *
9         import os
10        import subprocess
11
12        # ============================================================
13        # CONFIGURATION
14        # ============================================================
15        VTKHDF_FILE = "D:/rad/Cell_Phone_Drop.vtkhdf"
16        OUTPUT_DIR = "D:/rad/frames"
17        OUTPUT_VIDEO = "D:/rad/animation.mp4"
18        FRAME_RATE = 30
19
20        IMAGE_WIDTH = 1920
21        IMAGE_HEIGHT = 1080
22
23        CAMERA_POSITION = [0, 0, 15]
24        CAMERA_FOCAL_POINT = [0, 0, 0]
25        CAMERA_VIEW_UP = [0, 1, 0]
26        USE_PARALLEL_PROJECTION = True
27        PARALLEL_SCALE = 5.0
28
29        # Use GPS point data since element stress is zero
30        COLOR_ARRAY = "GPS_SIGXX"  # Options: GPS_SIGXX, GPS_SIGYY, GPS_SIGZZ
31        COLOR_MAP = "Cool to Warm"
32
33        # ============================================================
34        # CREATE OUTPUT DIRECTORY
35        # ============================================================
36        os.makedirs(OUTPUT_DIR, exist_ok=True)
37
38        print("=" * 60)
39        print("VTKHDF to MP4 Converter (using GPS stress data)")
40        print("=" * 60)
41        print(f"Input file: {VTKHDF_FILE}")
42        print(f"Output video: {OUTPUT_VIDEO}")
43        print(f"Frame rate: {FRAME_RATE} fps")
44
45        # ============================================================
46        # LOAD THE VTKHDF FILE
47        # ============================================================
48        if not os.path.exists(VTKHDF_FILE):
49            print(f"ERROR: File not found: {VTKHDF_FILE}")
50            exit(1)
51
52        print("\nLoading VTKHDF file...")
53        source = OpenDataFile(VTKHDF_FILE)
54        source.UpdatePipeline()
55
56        timesteps = source.TimestepValues
57        num_frames = len(timesteps) if timesteps else 1
58        print(f"Found {num_frames} time steps")
59
60        # ============================================================
61        # DISPLAY AVAILABLE DATA ARRAYS
62        # ============================================================
63        print("\n--- Available Data Arrays ---")
64        print(f"Point Data: {list(source.PointData.keys())}")
65        print(f"Cell Data: {list(source.CellData.keys())}")
66
67        # ============================================================
68        # CREATE RENDER VIEW
69        # ============================================================
70        print("\nSetting up render view...")
71        renderView = CreateView('RenderView')
72        renderView.ViewSize = [IMAGE_WIDTH, IMAGE_HEIGHT]
73        AssignViewToLayout(renderView)
74
75        display = Show(source, renderView)
76        display.Representation = 'Surface'
77
78        # ============================================================
79        # APPLY COLORING USING GPS DATA
80        # ============================================================
81        print(f"\nApplying coloring using '{COLOR_ARRAY}'...")
82
83        if COLOR_ARRAY in source.PointData.keys():
84            # Color by point data (GPS points)
85            display.ColorArrayName = ['POINTS', COLOR_ARRAY]
86            display.SetScalarBarVisibility(renderView, True)
87
88            # Get the color transfer function
89            lut = GetColorTransferFunction(COLOR_ARRAY)
90
91            if COLOR_MAP == "Cool to Warm":
92                lut.ColorSpace = 'Diverging'
93            elif COLOR_MAP == "Jet":
94                lut.ColorSpace = 'RGB'
95
96            # Get the actual data range
97            data_range = source.PointData.GetArray(COLOR_ARRAY).GetRange()
98            print(f"  Data range: {data_range[0]:.6f} to {data_range[1]:.6f}")
99
100           if data_range[1] > 0:
101               lut.RescaleTransferFunction(data_range[0], data_range[1])
102               print(f"  Color map '{COLOR_MAP}' applied")
103           else:
104               print("  WARNING: Data range is zero - no variation in data")
105       else:
106           print(f"  ERROR: '{COLOR_ARRAY}' not found in Point Data")
107           print("  Available Point Data arrays:", list(source.PointData.keys()))
108
109       display.Representation = 'Surface'
110       renderView.Background = [0.1, 0.2, 0.4]
111
112       # ============================================================
113       # SET UP CAMERA
114       # ============================================================
115       renderView.CameraPosition = CAMERA_POSITION
116       renderView.CameraFocalPoint = CAMERA_FOCAL_POINT
117       renderView.CameraViewUp = CAMERA_VIEW_UP
118
119       if USE_PARALLEL_PROJECTION:
120           renderView.CameraParallelProjection = 1
121           renderView.CameraParallelScale = PARALLEL_SCALE
122       else:
123           renderView.CameraParallelProjection = 0
124
125       renderView.ResetCamera()
126       Render()
127
128       # ============================================================
129       # CONFIGURE ANIMATION
130       # ============================================================
131       animationScene = GetAnimationScene()
132       animationScene.NumberOfFrames = num_frames
133       animationScene.StartTime = 0
134       animationScene.EndTime = num_frames - 1
135       animationScene.PlayMode = 'Sequence'
136
137       # ============================================================
138       # SAVE FRAMES
139       # ============================================================
140       print(f"\nSaving {num_frames} frames to {OUTPUT_DIR}...")
141
142       for i in range(num_frames):
143           animationScene.TimeKeeper.Time = i
144           source.UpdatePipeline(i)
145           Render()
146
147           frame_file = os.path.join(OUTPUT_DIR, f"frame_{i+1:04d}.png")
148           SaveScreenshot(frame_file, renderView, ImageResolution=[IMAGE_WIDTH, IMAGE_HEIGHT])
149
150           if (i + 1) % 10 == 0 or (i + 1) == num_frames:
151               print(f"  Saved frame {i+1}/{num_frames}")
152
153       print(f"\nFrames saved to: {OUTPUT_DIR}")
154
155       # ============================================================
156       # CONVERT TO MP4
157       # ============================================================
158       print("\n" + "=" * 50)
159       print("Converting PNG sequence to MP4...")
160       print("=" * 50)
161
162       ffmpeg_cmd = None
163       ffmpeg_paths = ['ffmpeg', 'C:\\ffmpeg\\bin\\ffmpeg.exe', 'D:\\ffmpeg\\bin\\ffmpeg.exe']
164
165       for path in ffmpeg_paths:
166           try:
167               subprocess.run([path, '-version'], capture_output=True, check=True)
168               ffmpeg_cmd = path
169               break
170           except (subprocess.SubprocessError, FileNotFoundError):
171               continue
172
173       if ffmpeg_cmd:
174           input_pattern = os.path.join(OUTPUT_DIR, "frame_%04d.png").replace('\\', '/')
175           output_video = OUTPUT_VIDEO.replace('\\', '/')
176
177           ffmpeg_command = [
178               ffmpeg_cmd, '-framerate', str(FRAME_RATE),
179               '-i', input_pattern,
180               '-vf', 'pad=1920:1062:(ow-iw)/2:(oh-ih)/2',
181               '-c:v', 'libx264',
182               '-pix_fmt', 'yuv420p',
183               '-crf', '18',
184               '-y', output_video
185           ]
186
187           print(f"Running FFmpeg...")
188           try:
189               result = subprocess.run(ffmpeg_command, capture_output=True, text=True)
190               if result.returncode == 0 and os.path.exists(OUTPUT_VIDEO):
191                   size_mb = os.path.getsize(OUTPUT_VIDEO) / (1024 * 1024)
192                   print(f"\nSUCCESS! MP4 created: {OUTPUT_VIDEO}")
193                   print(f"File size: {size_mb:.2f} MB")
194               else:
195                   print(f"\nFFmpeg failed. Run this command manually:")
196                   print(f'ffmpeg -framerate {FRAME_RATE} -i "{OUTPUT_DIR}/frame_%04d.png" -vf "pad=1920:1062:(ow-iw)/2:(oh-ih)/2" -c:v libx264 -pix_fmt yuv420p -crf 18 -y {OUTPUT_VIDEO}')
197           except Exception as e:
198               print(f"\nError: {e}")
199               print(f'ffmpeg -framerate {FRAME_RATE} -i "{OUTPUT_DIR}/frame_%04d.png" -vf "pad=1920:1062:(ow-iw)/2:(oh-ih)/2" -c:v libx264 -pix_fmt yuv420p -crf 18 -y {OUTPUT_VIDEO}')
200       else:
201           print("\nFFmpeg not found. Run this command manually:")
202           print(f'ffmpeg -framerate {FRAME_RATE} -i "{OUTPUT_DIR}/frame_%04d.png" -vf "pad=1920:1062:(ow-iw)/2:(oh-ih)/2" -c:v libx264 -pix_fmt yuv420p -crf 18 -y {OUTPUT_VIDEO}')
203
204       print("\n" + "=" * 60)
205       print("PROCESS COMPLETE")
206       print("=" * 60)
207       print(f"Animation saved to: {OUTPUT_VIDEO}")
208       ;;;;
209       %slc_pvpyend;

NOTE: The infile 'c:\temp\py_pgmx.py' is:
      Filename='c:\temp\py_pgmx.py',
      Owner Name=SLC\suzie,
      File size (bytes)=17116,
      Create Time=13:21:25 Jan 12 2026,
      Last Accessed=16:01:22 May 24 2026,
      Last Modified=16:01:22 May 24 2026,
      Lrecl=32767, Recfm=V

NOTE: The file 'c:\temp\py_pgm.py' is:
      Filename='c:\temp\py_pgm.py',
      Owner Name=SLC\suzie,
      File size (bytes)=0,
      Create Time=16:38:15 May 12 2026,
      Last Accessed=16:01:22 May 24 2026,
      Last Modified=16:01:22 May 24 2026,
      Lrecl=32767, Recfm=V

#!/usr/bin/env python
"""
Convert VTKHDF to MP4 using GPS stress data (since element stress is zero).
"""

from paraview.simple import *
import os
import subprocess

# ============================================================
# CONFIGURATION
# ============================================================
VTKHDF_FILE = "D:/rad/Cell_Phone_Drop.vtkhdf"
OUTPUT_DIR = "D:/rad/frames"
OUTPUT_VIDEO = "D:/rad/animation.mp4"
FRAME_RATE = 30

IMAGE_WIDTH = 1920
IMAGE_HEIGHT = 1080

CAMERA_POSITION = [0, 0, 15]
CAMERA_FOCAL_POINT = [0, 0, 0]
CAMERA_VIEW_UP = [0, 1, 0]
USE_PARALLEL_PROJECTION = True
PARALLEL_SCALE = 5.0

# Use GPS point data since element stress is zero
COLOR_ARRAY = "GPS_SIGXX"  # Options: GPS_SIGXX, GPS_SIGYY, GPS_SIGZZ
COLOR_MAP = "Cool to Warm"

# ============================================================
# CREATE OUTPUT DIRECTORY
# ============================================================
os.makedirs(OUTPUT_DIR, exist_ok=True)

print("=" * 60)
print("VTKHDF to MP4 Converter (using GPS stress data)")
print("=" * 60)
print(f"Input file: {VTKHDF_FILE}")
print(f"Output video: {OUTPUT_VIDEO}")
print(f"Frame rate: {FRAME_RATE} fps")

# ============================================================
# LOAD THE VTKHDF FILE
# ============================================================
if not os.path.exists(VTKHDF_FILE):
    print(f"ERROR: File not found: {VTKHDF_FILE}")
    exit(1)

print("\nLoading VTKHDF file...")
source = OpenDataFile(VTKHDF_FILE)
source.UpdatePipeline()

timesteps = source.TimestepValues
num_frames = len(timesteps) if timesteps else 1
print(f"Found {num_frames} time steps")

# ============================================================
# DISPLAY AVAILABLE DATA ARRAYS
# ============================================================
print("\n--- Available Data Arrays ---")
print(f"Point Data: {list(source.PointData.keys())}")
print(f"Cell Data: {list(source.CellData.keys())}")

# ============================================================
# CREATE RENDER VIEW
# ============================================================
print("\nSetting up render view...")
renderView = CreateView('RenderView')
renderView.ViewSize = [IMAGE_WIDTH, IMAGE_HEIGHT]
AssignViewToLayout(renderView)

display = Show(source, renderView)
display.Representation = 'Surface'

# ============================================================
# APPLY COLORING USING GPS DATA
# ============================================================
print(f"\nApplying coloring using '{COLOR_ARRAY}'...")

if COLOR_ARRAY in source.PointData.keys():
    # Color by point data (GPS points)
    display.ColorArrayName = ['POINTS', COLOR_ARRAY]
    display.SetScalarBarVisibility(renderView, True)

    # Get the color transfer function
    lut = GetColorTransferFunction(COLOR_ARRAY)

    if COLOR_MAP == "Cool to Warm":
        lut.ColorSpace = 'Diverging'
    elif COLOR_MAP == "Jet":
        lut.ColorSpace = 'RGB'

    # Get the actual data range
    data_range = source.PointData.GetArray(COLOR_ARRAY).GetRange()
    print(f"  Data range: {data_range[0]:.6f} to {data_range[1]:.6f}")

    if data_range[1] > 0:
        lut.RescaleTransferFunction(data_range[0], data_range[1])
        print(f"  Color map '{COLOR_MAP}' applied")
    else:
        print("  WARNING: Data range is zero - no variation in data")
else:
    print(f"  ERROR: '{COLOR_ARRAY}' not found in Point Data")
    print("  Available Point Data arrays:", list(source.PointData.keys()))

display.Representation = 'Surface'
renderView.Background = [0.1, 0.2, 0.4]

# ============================================================
# SET UP CAMERA
# ============================================================
renderView.CameraPosition = CAMERA_POSITION
renderView.CameraFocalPoint = CAMERA_FOCAL_POINT
renderView.CameraViewUp = CAMERA_VIEW_UP

if USE_PARALLEL_PROJECTION:
    renderView.CameraParallelProjection = 1
    renderView.CameraParallelScale = PARALLEL_SCALE
else:
    renderView.CameraParallelProjection = 0

renderView.ResetCamera()
Render()

# ============================================================
# CONFIGURE ANIMATION
# ============================================================
animationScene = GetAnimationScene()
animationScene.NumberOfFrames = num_frames
animationScene.StartTime = 0
animationScene.EndTime = num_frames - 1
animationScene.PlayMode = 'Sequence'

# ============================================================
# SAVE FRAMES
# ============================================================
print(f"\nSaving {num_frames} frames to {OUTPUT_DIR}...")

for i in range(num_frames):
    animationScene.TimeKeeper.Time = i
    source.UpdatePipeline(i)
    Render()

    frame_file = os.path.join(OUTPUT_DIR, f"frame_{i+1:04d}.png")
    SaveScreenshot(frame_file, renderView, ImageResolution=[IMAGE_WIDTH, IMAGE_HEIGHT])

    if (i + 1) % 10 == 0 or (i + 1) == num_frames:
        print(f"  Saved frame {i+1}/{num_frames}")

print(f"\nFrames saved to: {OUTPUT_DIR}")

# ============================================================
# CONVERT TO MP4
# ============================================================
print("\n" + "=" * 50)
print("Converting PNG sequence to MP4...")
print("=" * 50)

ffmpeg_cmd = None
ffmpeg_paths = ['ffmpeg', 'C:\\ffmpeg\\bin\\ffmpeg.exe', 'D:\\ffmpeg\\bin\\ffmpeg.exe']

for path in ffmpeg_paths:
    try:
        subprocess.run([path, '-version'], capture_output=True, check=True)
        ffmpeg_cmd = path
        break
    except (subprocess.SubprocessError, FileNotFoundError):
        continue

if ffmpeg_cmd:
    input_pattern = os.path.join(OUTPUT_DIR, "frame_%04d.png").replace('\\', '/')
    output_video = OUTPUT_VIDEO.replace('\\', '/')

    ffmpeg_command = [
        ffmpeg_cmd, '-framerate', str(FRAME_RATE),
        '-i', input_pattern,
        '-vf', 'pad=1920:1062:(ow-iw)/2:(oh-ih)/2',
        '-c:v', 'libx264',
        '-pix_fmt', 'yuv420p',
        '-crf', '18',
        '-y', output_video
    ]

    print(f"Running FFmpeg...")
    try:
        result = subprocess.run(ffmpeg_command, capture_output=True, text=True)
        if result.returncode == 0 and os.path.exists(OUTPUT_VIDEO):
            size_mb = os.path.getsize(OUTPUT_VIDEO) / (1024 * 1024)
            print(f"\nSUCCESS! MP4 created: {OUTPUT_VIDEO}")
            print(f"File size: {size_mb:.2f} MB")
        else:
            print(f"\nFFmpeg failed. Run this command manually:")
            print(f'ffmpeg -framerate {FRAME_RATE} -i "{OUTPUT_DIR}/frame_%04d.png" -vf "pad=1920:1062:(ow-iw)/2:(oh-ih)/2" -c:v libx264 -pix_fmt yuv420p -crf 18 -y {OUTPUT_VIDEO}')
    except Exception as e:
        print(f"\nError: {e}")
        print(f'ffmpeg -framerate {FRAME_RATE} -i "{OUTPUT_DIR}/frame_%04d.png" -vf "pad=1920:1062:(ow-iw)/2:(oh-ih)/2" -c:v libx264 -pix_fmt yuv420p -crf 18 -y {OUTPUT_VIDEO}')
else:
    print("\nFFmpeg not found. Run this command manually:")
    print(f'ffmpeg -framerate {FRAME_RATE} -i "{OUTPUT_DIR}/frame_%04d.png" -vf "pad=1920:1062:(ow-iw)/2:(oh-ih)/2" -c:v libx264 -pix_fmt yuv420p -crf 18 -y {OUTPUT_VIDEO}')

print("\n" + "=" * 60)
print("PROCESS COMPLETE")
print("=" * 60)
print(f"Animation saved to: {OUTPUT_VIDEO}")
NOTE: 205 records were read from file 'c:\temp\py_pgmx.py'
      The minimum record length was 80
      The maximum record length was 181
NOTE: 205 records were written to file 'c:\temp\py_pgm.py'
      The minimum record length was 80
      The maximum record length was 181

2                                                                                                                         Altair SLC

NOTE: The data step took :
      real time : 0.000
      cpu time  : 0.000



NOTE: The infile rut is:
      Unnamed Pipe Access Device,
      Process=C:\Progra~1\ParaView-6.1.0-Windows-Python3.12-msvc2017-AMD64\bin\pvpython.exe c:/temp/py_pgm.py 2> c:/temp/py_pgm.log,
      Lrecl=32767, Recfm=V

============================================================
VTKHDF to MP4 Converter (using GPS stress data)
============================================================
Input file: D:/rad/Cell_Phone_Drop.vtkhdf
Output video: D:/rad/animation.mp4
Frame rate: 30 fps

Loading VTKHDF file...
Found 101 time steps

--- Available Data Arrays ---
Point Data: ['GPS_SIGXX', 'GPS_SIGXY', 'GPS_SIGXZ', 'GPS_SIGYY', 'GPS_SIGZY', 'GPS_SIGZZ', 'NODE_ID']
Cell Data: ['3DELEM_Stra_Intg_Point111__', '3DELEM_Stra_Intg_Point112__', '3DELEM_Stra_Intg_Point121__', '3DELEM_Stra_Intg_Point122__', '3DELEM_Stra_Intg_Point211__', '3DELEM_Stra_Intg_Point212__', '3DELEM_Stra_Intg_Point221__', '3DELEM_Stra_Intg_Point222
__', '3DELEM_Strs_Intg_Point111__', '3DELEM_Strs_Intg_Point112__', '3DELEM_Strs_Intg_Point121__', '3DELEM_Strs_Intg_Point122__', '3DELEM_Strs_Intg_Point211__', '3DELEM_Strs_Intg_Point212__', '3DELEM_Strs_Intg_Point221__', '3DELEM_Strs_Intg_Point222__', 'E
LEMENT_ID', 'EROSION_STATUS', 'PART_ID']

Setting up render view...

Applying coloring using 'GPS_SIGXX'...
  Data range: 0.000000 to 0.000000
  WARNING: Data range is zero - no variation in data

Saving 101 frames to D:/rad/frames...
  Saved frame 10/101
  Saved frame 20/101
  Saved frame 30/101
  Saved frame 40/101
  Saved frame 50/101
  Saved frame 60/101
  Saved frame 70/101
  Saved frame 80/101
  Saved frame 90/101
  Saved frame 100/101
  Saved frame 101/101

Frames saved to: D:/rad/frames

==================================================
Converting PNG sequence to MP4...
==================================================
Running FFmpeg...

SUCCESS! MP4 created: D:/rad/animation.mp4
File size: 0.21 MB

============================================================
PROCESS COMPLETE
============================================================
Animation saved to: D:/rad/animation.mp4
NOTE: 49 records were written to file PRINT

NOTE: 47 records were read from file rut
      The minimum record length was 0
      The maximum record length was 550
NOTE: The data step took :
      real time : 1:25.607
      cpu time  : 0:00.000



NOTE: The infile 'c:\temp\py_pgm.log' is:
      Filename='c:\temp\py_pgm.log',
      Owner Name=SLC\suzie,
      File size (bytes)=114,
      Create Time=11:45:37 May 12 2026,
      Last Accessed=16:01:32 May 24 2026,
      Last Modified=16:01:32 May 24 2026,
      Lrecl=32767, Recfm=V

(   9.449s) [paraview        ]vtkSMColorMapEditorHelp:3204  WARN| Failed to determine the LookupTable being used.
NOTE: 1 record was read from file 'c:\temp\py_pgm.log'
      The minimum record length was 113
      The maximum record length was 113
NOTE: The data step took :
      real time : 0.000
      cpu time  : 0.000


ERROR: Error printed on page 1

NOTE: Submitted statements took :
      real time : 1:25.954
      cpu time  : 0:00.093
/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
