# SpaceWarp Template for .NET

This project serves as a SpaceWarp mod project template for the .NET CLI and Visual Studio.

## Requirements

- **.NET SDK** - .NET 7+ is required for all the features of the templates to be supported

### Optional

- **Visual Studio 2022** - Visual Studio 2022 is the required version if you want to use the template with VS
- **JetBrains Rider** - The template can also be used with JetBrains Rider (tested with version 2023.3)
- **Unity 2022.3.5f1** - Needed to build projects based on the **General mod project with UI** template

## Installation

For .NET 7+ SDK, you can use the commands as they are written below.

You can see the SDK version currently in use and all SDK versions
installed by running `dotnet --info`.

### A. create-project.bat script

The easiest way to install the template is to use the **create-project.bat** script. You can download the latest version
from **[GitHub releases](https://github.com/SpaceWarpDev/SpaceWarp.Template/releases)**.

When you run the script, it will check whether the template is installed and if not, it will install it for you.
Similarly, it will also check for template updates and offer to install the update if a new version is available.

### B. NuGet.org

1. Run the following command in `cmd` or `powershell` to install all templates:
    ```console
    dotnet new install SpaceWarp.Template
    ```
   To install a specific version, you can add the version specifier to the command:
    ```console
    dotnet new install SpaceWarp.Template::<version>
    ```

### C. Manual

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

If you are using the `create-project.bat` script, it will automatically check for updates and offer to install them
when a new version is available. _This feature is available since version 1.8.0.1 of the script._

To update the template to the latest version manually, run the following command:

```console
dotnet new install SpaceWarp.Template
```

## Available templates

The template contains various different types of projects:

### General mod project

This template creates a general mod project for SpaceWarp. It contains some example code (such as creating a window
using
the IMGUI library, registering app bar buttons and setting up BepInEx configuration) to get you started.

This is the recommended template for beginners who want to get familiar with KSP 2 modding.

**The template is available under the name `spacewarpmod`**.

### General mod project with UI

This template creates a general mod project for SpaceWarp. It contains some example code (such as creating a window
using the [UITK for KSP2](https://github.com/UitkForKsp2/UitkForKsp2) library, registering app bar buttons and setting
up BepInEx configuration) to get you started.

It also includes a Unity project set up with everything needed to create UIs in the UI Toolkit Builder.

This is the recommended template for beginners who want to get familiar with KSP 2 modding.

**The template is available under the name `spacewarpmod-ui`**.

### Empty mod project

This template creates an empty mod project for SpaceWarp. It contains no example code and is meant to be used by more
experienced modders who want to start from scratch.

This is the recommended template for more experienced modders who want to create a project which does not contain any
unnecessary example code.

**The template is available under the name `spacewarpmod-empty`**.

### Library mod project

This template creates a library mod project for SpaceWarp. It is pre-configured to automatically generate a NuGet
package for your mod, which can be used by other mods. It contains an additional module project and a preload
patcher project, with all the necessary setup.

This is the recommended template for modders who want to create a library mod which can be used by other mods.

**The template is available under the name `spacewarpmod-library`**.

## Creating a project

There are multiple options how to generate a project using this template:

### A. Project generator (strongly recommended)

1. Download the latest version of **create-project.bat** from
   **[GitHub releases](https://github.com/SpaceWarpDev/SpaceWarp.Template/releases)**
2. Place the file in the folder in which you want your project folders to be created
3. Run the file and follow the instructions

### B. Visual Studio 2022

1. Open Visual Studio
2. Click on **Create a new project**
3. Search for "SpaceWarp" in the search bar at the top, then select one of the available project types and click
   **Next**  
   ![Step 3](https://i.imgur.com/8lsJOpN.png)
4. Fill out your project name and click **Next**  
   ![Step 4](https://i.imgur.com/itHtr8H.png)
5. Fill out the fields on the following page. You can find more information about the parameters by hovering
   over the corresponding "i" icons, or in the **[Project parameters](#project-parameters)** section.<br>
   **Make sure that "Place solution and project in the same directory" is checked.**
   ![Step 5](https://i.imgur.com/g5mkGSp.png)
6. Open the project directory, go to the `scripts` folder and run `setup.bat`. This will guide you through the process
   of finishing the project setup.
7. Rebuild the solution for all references to be resolved  
   ![Step 8](https://i.imgur.com/MeBZBbD.png)

### C. Manually with .NET CLI

1. Open `cmd` or `powershell` in the folder where you want your project created
2. Replace the information in the following command with your own and run it:
   ```console
   dotnet new <project-type> -n MyAwesomeModName -A "munix" -M "My Awesome Mod Name" -D "This is the description of my awesome mod." -S "https://github.com/munix/MyAwesomeModName" -V "1.0.0" -C "https://raw.githubusercontent.com/munix/MyAwesomeModName/main/plugin_template/swinfo.json"
   ```
   Typing `dotnet new <project-type> --help` will show you the possible parameters. You can find more information
   about all project parameters in the **[Project parameters](#project-parameters)** section.

   Replace `<project-type>` with one of the project types listed in the **[Template types](#template-types)**
   section.
3. Open the project directory, go to the `scripts` folder and run `setup.bat`. This will guide you through the process
   of finishing the project setup.

## Building a project

Four build configurations are defined: **Debug**, **Release**, **Deploy** and **DeployAndRun**.
Building any of them will create a folder with the name of the configuration in the project root. This will create
the complete folder structure for you, i.e. `BepInEx/plugins/YourMod/...`, and all the folders and files necessary
to distribute your mod (such as `LICENSE`, `assets/`, `swinfo.json`...) will be built and copied here.

When building any other target than Release, the file `YourMod.pdb` is also copied next to `YourMod.dll`,
so that you can easily start debugging your mod. To quickly get started with breakpoint debugging your KSP 2 mods, see
**[Debugging and profiling KSP plugins](https://gist.github.com/gotmachine/d973adcb9ae413386291170fa346d043) by
[Gotmachine](https://github.com/gotmachine)**.

In the **Deploy** and **DeployAndRun** configurations, your mod is built as if using the **Debug** configuration,
and then it gets automatically deployed into your game folder specified either in the `KSP2DIR` environment variable
or in your .csproj file's `<KSP2DIR>` property.

If you are using the **DeployAndRun** configuration, the game will be started automatically after the deployment.

For Windows users, batch scripts are included in the `scripts` folder to provide an easy way to build the project
by simply double-clicking one of the configurations: `build-release.bat`, `build-debug.bat`, `build-deploy.bat` and
`build-run.bat`. Otherwise you can use your IDE or the .NET CLI to build the project.

### Building the UI project

The **General mod project with UI** template includes a Unity project, which you can find in
`YourMod/src/YourMod.Unity/YourMod.Unity`.

To build the asset bundle needed to display the UI, open the project with Unity, make any desired changes to the UI
in the `Assets/UI` folder, and then go to the top menu and click on `Assets->Build AssetBundles`. This will build
all asset bundles into the `Assets/AssetBundles` folder, and should automatically copy all bundles to the folder
`YourMod/plugin_template/assets/bundles`. Now the C# project can be built as explained above.

**Note:** You will need to repeat this process everytime you make changes to the UI files in Unity.

### Adding a new project to the solution

When you add a new project to the solution, make sure to reference it from the main plugin project so that it gets
included into the build.

### GitHub Actions

The template includes GitHub Actions workflow files. They are located in the `.github/workflows` folder, and include
the following:

- **verify.yml** - Checks whether your swinfo.json file is valid and whether the `version_check` property
  leads to a valid online swinfo.json file.

  This workflow is triggered on every push to the **main** branch.
- **build.yml** - Builds your mod and uploads artifacts with the results. This includes the built mod zip file,
  and the built NuGet package if you are using the **Library mod project** template.

  This workflow is triggered on every push to the **every** branch.
- **release.yml** - Builds your mod in the Release configuration and uploads the resulting zip file to the release
  that triggered the workflow. That means that you only need to create an "empty" release on GitHub, and the workflow 
  will automatically build your mod and upload the zip as part of the release.

  This workflow is triggered whenever you create and publish a **new release**.

#### SpaceDock integration

Included in the **release.yml** workflow is also a step which automatically uploads the new version of your mod to **SpaceDock**, but 
it requires some additional setup:
1. You mod needs to already have at least one release on SpaceDock.
2. Open the `release.yml` file and uncomment the `Add Mask` and `Update mod on SpaceDock` steps.
3. At the top of the `release.yml` file, update the `SPACEDOCK_MOD_ID` variable to the ID of your mod on SpaceDock.
   You can find it in the URL of your mod, for example, if your mod's URL is `https://spacedock.info/mod/1234/MyMod`,
   then the ID is `1234`.
4. Go to your repository on GitHub, open the **Settings** tab, and under **Security**, open **Secrets and variables**
   -> **Actions**. There, create two new repository secrets with the following names and values:
   - `SPACEDOCK_USER` - your SpaceDock username
   - `SPACEDOCK_PASSWORD` - your SpaceDock password
   
   This step is necessary so that your SpaceDock credentials can be used to upload the mod without being publicly
   visible in your repository.

If you do not want to use any of these workflows, you can simply delete the corresponding files.

### swinfo.json

The properties in your .csproj file are automatically read from the `swinfo.json` file in your project's
`plugin_info` folder. This file is used by SpaceWarp mod to display information about your mod and check for updates
of your mod.

**This also applies to version information - you only need to update the version number of your mod in the `swinfo.json`
file, and it will be automatically parsed from there for all uses.**

Here is a list of properties in the `swinfo.json` file and their corresponding .csproj properties:

| swinfo.json property | .csproj property  |
|----------------------|-------------------|
| mod_id               | `<ModId>`         |
| author               | `<Authors>`       |
| name                 | `<Product>`       |
| description          | `<Description>`   |
| source               | `<RepositoryUrl>` |
| version              | `<Version>`       |
| version_check        | None              |
| ksp2_version.min     | None              |
| ksp2_version.max     | None              |

## Project parameters

When creating your project in either the console or Visual Studio, you are provided a number of parameters.
They apply to all project types and you can find an overview of all of them and their meanings here:

| Parameter     | Console argument | Short argument | Description                                                                                                                                                                     | Default value              |
|---------------|------------------|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------|
| Project name  | --name           | -n             | The name of your project in PascalCase                                                                                                                                          | `<current directory name>` |
| ModName       | --ModName        | -M             | The name of your mod                                                                                                                                                            | `""` _(empty)_             |
| Author        | --Author         | -A             | The name(s) of the mod's author(s)                                                                                                                                              | `""` _(empty)_             |
| Description   | --Description    | -D             | A short description of your mod                                                                                                                                                 | `""` _(empty)_             |
| Source        | --Source         | -S             | The repository or download location of the mod's source code<br>(for example: https://github.com/author/mod)                                                                    | `""` _(empty)_             |
| Version       | --Version        | -V             | The mod's initial version                                                                                                                                                       | `1.0.0`                    |
| Check Version | --CheckVersion   | -C             | URL to the raw swinfo.json file in your main branch to check for updates<br>(for example: https://raw.githubusercontent.com/YourUsername/YourRepo/main/plugin_info/swinfo.json) | `""` _(empty)_             |
| License URL*  | --LicenseUrl     | -L             | URL to the license file of your mod<br>(for example: https://raw.githubusercontent.com/YourUsername/YourRepo/main/LICENSE)                                                      | `""` _(empty)_             |

&ast;The **License URL** parameter only applies to the **spacewarpmod-library** project type.

None of the parameters other than **Project name** are required. If you don't provide any, the template will generate a
project with the listed default values and you'll be able to fill them in later in your .csproj file.