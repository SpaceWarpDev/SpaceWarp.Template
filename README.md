﻿# SpaceWarp Template for .NET
This project serves as a SpaceWarp 0.4+ mod project template for the .NET CLI and Visual Studio.

## Requirements
- **.NET SDK** - the overview of compatible .NET and .NET Framework versions can be found
**[in this document](https://learn.microsoft.com/en-us/dotnet/standard/net-standard?tabs=net-standard-2-0#tabpanel_1_net-standard-2-0)**
- **.NET CLI** - included with .NET SDK installation

## Installation
1. Download the .nupkg file from **[GitHub releases](https://github.com/jan-bures/SpaceWarp.Template/releases)**
2. Run the following command in cmd or PowerShell in the directory with the downloaded file after replacing `<version>`
with the version number you downloaded:
    ```console
    dotnet new install SpaceWarp.Template.<version>.nupkg
    ```  
## Creating a project
There are two options how to generate a project using this template:

### A) Command line
1. Open `cmd` or `powershell` in the folder where you want your project created
2. Replace the information in the following command with your own and run it:  
    ```console
    dotnet new spacewarpmod -n MyAwesomeModName -G my_awesome_mod_name -A "munix" -B "com.github.munix.my_awesome_mod_name" -M "My Awesome Mod Name" -D "This is the description of my awesome mod." -S "https://github.com/munix/MyAwesomeModName" -V "1.0.0"
    ```
    Typing `dotnet new spacewarpmod --help` will show you the possible parameters. You can find more information 
    about all project parameters in the **[Project parameters](#project-parameters)** section.  

3. Copy the file `<KSP2 Root>/KSP2_x64_Data/Managed/Assembly-CSharp.dll` into the `<project root>/external_dlls/` folder.

### B) Visual Studio 2022
1. Open Visual Studio
2. Click on **Create a new project**
3. Search for "SpaceWarp" in the search bar at the top, then select it and click **Next**
![Step 3](https://i.imgur.com/8lsJOpN.png)
4. Fill out your project name and click **Next**
![Step 4](https://i.imgur.com/itHtr8H.png)
5. Fill out the fields on the following page according to the following template.
You can find more information about the parameters by hovering over the corresponding "i" icons, or in the **[Project parameters](#project-parameters)** section.  
![Step 5](https://i.imgur.com/g5mkGSp.png)  
6. Click on **Create** and your project will be made.
7. Copy the file `<KSP2 Root>/KSP2_x64_Data/Managed/Assembly-CSharp.dll` into the `<project root>/external_dlls/` folder.
8. Rebuild the solution once for all references to be resolved  
![Step 8](https://i.imgur.com/MeBZBbD.png)

## Building a project
It is necessary to always have the `<KSP2 Root>/KSP2_x64_Data/Managed/Assembly-CSharp.dll` file copied into the
`<project root>/external_dlls/` folder before you can build your project.

Two build configurations are defined: **Debug** and **Release**. Building either of them will create a folder
with the name of the configuration in the project root. This will create the complete folder structure needed
to package your mods and upload them, i.e. `BepInEx/plugins/your_mod/...`, and all the folders and files necessary
to distribute your mod (such as `LICENSE`, `assets/`, `swinfo.json`...), will be copied here, making it very convenient
to just zip the whole folder and upload it.

When building the **Debug** target, the file `your_mod.pdb` is also copied next to `your_mod.dll`, so that you can
easily copy the whole contents of the `Debug` folder into your KSP 2 root and start debugging your mod.
To easily get started with breakpoint debugging your KSP 2 mods, see **[this document](https://gist.github.com/gotmachine/d973adcb9ae413386291170fa346d043)**.

For Windows users, two batch scripts are included in the project root folder to provide an easy way to build the project
by simply double-clicking one of the configurations: `build-debug.bat` and `build-release.bat`. Otherwise you can use
your IDE or the .NET CLI to build the project.

## Project parameters
When creating your project in either the console or Visual Studio, you are provided a number of parameters.
Here you can find an overview of all the parameters and their meaning:

| Parameter                 | Console argument  | Short argument | Description                                                                                                  | Default value              |
|---------------------------|-------------------|----------------|--------------------------------------------------------------------------------------------------------------|----------------------------|
| Project name              | --name            | -n             | The name of your project in PascalCase                                                                       | `<current directory name>` |
| TargetFramework           | --TargetFramework | -T             | .NET version to target, default value is set for KSP 2                                                       | `.netstandard2.0`          |
| UnityVersion              | --UnityVersion    | -U             | Unity version to target, default value is set for KSP 2                                                      | `2020.3.33`                |
| **GUID**<sup>*</sup>      | --GUID            | -G             | Your mod's ID which serves as the folder and .dll name of your built mod, used by SpaceWarp                  | -                          |
| **Author**<sup>*</sup>    | --Author          | -A             | The name(s) of the mod's author(s)                                                                           | -                          |
| **BepinexName**<sup>*</sup> | --BepinexName     | -B             | Your mod's ID in domain syntax, for example: com.github.author.modname, used by BepInEx                      | -                          |
| **ModName**<sup>*</sup>   | --ModName         | -M             | The name of your mod                                                                                         | -                          |
| Description               | --Description     | -D             | A short description of your mod                                                                              | `""` _(empty)_             |
| Source                    | --Source          | -S             | The repository or download location of the mod's source code, for example: https://github.com/author/ModName | `""` _(empty)_             |
| Version                   | --Version         | -V             | The mod's initial version                                                                                    | `1.0.0`                    |

Parameters marked with an asterisk (*) and in bold text are required and do not have default values.
