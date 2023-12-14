using System.Reflection;
using BepInEx;
using JetBrains.Annotations;
using SpaceWarp;
using SpaceWarp.API.Mods;

namespace SpaceWarpModLibrary;

/// <summary>
/// Main plugin class for the mod.
/// </summary>
[BepInPlugin(MyPluginInfo.PLUGIN_GUID, MyPluginInfo.PLUGIN_NAME, MyPluginInfo.PLUGIN_VERSION)]
[BepInDependency(SpaceWarpPlugin.ModGuid, SpaceWarpPlugin.ModVer)]
public class SpaceWarpModLibraryPlugin : BaseSpaceWarpPlugin
{
    /// <summary>
    /// The GUID of the mod.
    /// </summary>
    [PublicAPI] public const string ModGuid = MyPluginInfo.PLUGIN_GUID;
    /// <summary>
    /// The name of the mod.
    /// </summary>
    [PublicAPI] public const string ModName = MyPluginInfo.PLUGIN_NAME;
    /// <summary>
    /// The version of the mod.
    /// </summary>
    [PublicAPI] public const string ModVer = MyPluginInfo.PLUGIN_VERSION;

    /// <summary>
    /// Singleton instance of the mod.
    /// </summary>
    [PublicAPI] public static SpaceWarpModLibraryPlugin Instance { get; set; }

    /// <summary>
    /// Runs when the mod is first initialized.
    /// </summary>
    public override void OnInitialized()
    {
        base.OnInitialized();

        Instance = this;

        // Load the SpaceWarpModLibrary.AnotherModule project assembly
        var currentFolder = new FileInfo(Assembly.GetExecutingAssembly().Location).Directory!.FullName;
        Assembly.LoadFrom(Path.Combine(currentFolder, "SpaceWarpModLibrary.AnotherModule.dll"));

        // Load any 3rd party assemblies from the "lib" folder
        var libFolder = Path.Combine(currentFolder, "lib");
        foreach (var file in Directory.GetFiles(libFolder, "*.dll"))
        {
            Assembly.LoadFrom(file);
        }
    }
}
