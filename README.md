# SpaceWarp Template for .NET

This project serves as a SpaceWarp mod project template for the .NET CLI and Visual Studio.

## Requirements

- **.NET SDK** - .NET 6+ is required for all the features of the templates to be supported

### Optional

- **Visual Studio 2022** - Visual Studio 2022 is the required version if you want to use the template with it
- **JetBrains Rider** - The template can also be used with JetBrains Rider (tested with version 2023.1.1)

## Installation

For .NET 7 SDK, you can use the commands as they are written below. **For .NET 6 SDK and older,
you need to replace `install` with `--install`.**

You can see the SDK version currently in use and all SDK versions
installed by running `dotnet --info`.

### A. NuGet.org

1. Run the following command in `cmd` or `powershell` to install all templates:
    ```console
    dotnet new install SpaceWarp.Template
    ```
   To install a specific version, you can add the version specifier to the command:
    ```console
    dotnet new install SpaceWarp.Template::<version>
    ```

### B. Manual

1. Download the .nupkg file from **[GitHub releases](https://github.com/jan-bures/SpaceWarp.Template/releases)**
2. Run the following command in `cmd` or `powershell` in the directory with the downloaded file after
   replacing `<version>`
   with the version number you downloaded:
    ```console
    dotnet new install SpaceWarp.Template.<version>.nupkg
    ```

### Versioning

The template versions follow this convention: `x.y.z.version`, where `x.y.z` is the corresponding SpaceWarp version
and `version` is the template version for that specific SpaceWarp release. For example, `0.4.0.1` is the first version
of the template which supports SpaceWarp 0.4.0.

## Updating

To update the template in .NET 7 SDK, run the following command:

```console
dotnet new update
```

When using .NET 6 SDK or earlier, use the following command instead:

```console
dotnet new --update-apply
```

## Template types

The template contains three different types of projects:

### General mod project

This template creates a general mod project for SpaceWarp. It contains some example code such as creating a window,
registering app bar buttons and binding to configuration values to get you started.

The template is available under the name `spacewarpmod`.

### Empty mod project

This template creates an empty mod project for SpaceWarp. It contains no example code and is meant to be used by more
experienced modders who want to start from scratch.

The template is available under the name `spacewarpmod-empty`.

### Library mod project

This template creates a library mod project for SpaceWarp. It is pre-configured to automatically generate a NuGet
package for your mod, which can be used by other mods.

The template is available under the name `spacewarpmod-library`.

## Creating a project

There are two options how to generate a project using this template:

### A. Command line

1. Open `cmd` or `powershell` in the folder where you want your project created
2. Replace the information in the following command with your own and run it:
   ```console
   dotnet new <project-type> -n MyAwesomeModName -A "munix" -M "My Awesome Mod Name" -D "This is the description of my awesome mod." -S "https://github.com/munix/MyAwesomeModName" -V "1.0.0" -C "https://github.com/munix/MyAwesomeModName"
   ```
   Typing `dotnet new <project-type> --help` will show you the possible parameters. You can find more information
   about all project parameters in the **[Project parameters](#project-parameters)** section.

   Replace `<project-type>` with one of the three project types listed in the **[Template types](#template-types)**
   section.

3. Copy the file `<KSP2 Root>/KSP2_x64_Data/Managed/Assembly-CSharp.dll` into the `<project root>/external_dlls/`
   folder.

### B. Visual Studio 2022

1. Open Visual Studio
2. Click on **Create a new project**
3. Search for "SpaceWarp" in the search bar at the top, then select one of the available project types and click
   **Next**  
   ![Step 3](https://i.imgur.com/8lsJOpN.png)
4. Fill out your project name and click **Next**  
   ![Step 4](https://i.imgur.com/itHtr8H.png)
5. Fill out the fields on the following page. You can find more information about the parameters by hovering
   over the corresponding "i" icons, or in the **[Project parameters](#project-parameters)** section.  
   ![Step 5](https://i.imgur.com/g5mkGSp.png)
6. Click on **Create** and your project will be made.
7. Copy the file `<KSP2 Root>/KSP2_x64_Data/Managed/Assembly-CSharp.dll` into the `<solution_root>/external_dlls/`
   folder.
8. Rebuild the solution once for all references to be resolved  
   ![Step 8](https://i.imgur.com/MeBZBbD.png)

## Building a project

It is necessary to always have the `<KSP2 Root>/KSP2_x64_Data/Managed/Assembly-CSharp.dll` file copied into the
`<solution_root>/external_dlls/` folder before you can build your project.

Four build configurations are defined: **Debug**, **Release**, **Deploy** and **DeployAndRun**.
Building any of them will create a folder with the name of the configuration in the project root. This will create
the complete folder structure for you, i.e. `BepInEx/plugins/your_mod/...`, and all the folders and files necessary
to distribute your mod (such as `LICENSE`, `assets/`, `swinfo.json`...) will be built and copied here.

When building any other target than Release, the file `your_mod.pdb` is also copied next to `your_mod.dll`,
so that you can easily start debugging your mod. To quickly get started with breakpoint debugging your KSP 2 mods, see
**[this document](https://gist.github.com/gotmachine/d973adcb9ae413386291170fa346d043)**.

In the **Deploy** and **DeployAndRun** configurations, your mod is built as if using the **Debug** configuration,
and then it gets automatically deployed into your game folder specified either in the `KSP2DIR` environment variable
or in your .csproj file's `<KSP2DIR>` property.

If you are using the **DeployAndRun** configuration, the game will be started automatically after the deployment.

For Windows users, batch scripts are included in the `scripts` folder to provide an easy way to build the project
by simply double-clicking one of the configurations: `build-release.bat`, `build-debug.bat`, `build-deploy.bat` and
`build-run.bat`. Otherwise you can use your IDE or the .NET CLI to build the project.

## Project parameters

When creating your project in either the console or Visual Studio, you are provided a number of parameters.
They apply to all project types and you can find an overview of all of them and their meanings here:

| Parameter     | Console argument | Short argument | Description                                                                                                                                                                            | Default value              |
|---------------|------------------|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------|
| Project name  | --name           | -n             | The name of your project in PascalCase                                                                                                                                                 | `<current directory name>` |
| ModName       | --ModName        | -M             | The name of your mod                                                                                                                                                                   | `""` _(empty)_             |
| Author        | --Author         | -A             | The name(s) of the mod's author(s)                                                                                                                                                     | `""` _(empty)_             |
| Description   | --Description    | -D             | A short description of your mod                                                                                                                                                        | `""` _(empty)_             |
| Source        | --Source         | -S             | The repository or download location of the mod's source code<br>(for example: https://github.com/author/mod)                                                                           | `""` _(empty)_             |
| Version       | --Version        | -V             | The mod's initial version                                                                                                                                                              | `1.0.0`                    |
| Check Version | --CheckVersion   | -C             | URL to the raw .csproj file in your main branch to check for updates<br>(for example: https://raw.githubusercontent.com/YourUsername/YourRepo/main/src/YourProject/YourProject.csproj) | `""` _(empty)_             |

None of the parameters are required. If you don't provide any, the template will generate a project with the listed
default values and you'll be able to fill them in later in your .csproj file.
