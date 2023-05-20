using BepInEx;
using SpaceWarp;
using SpaceWarp.API.Mods;

namespace SpaceWarpModLibrary;

[BepInPlugin(MyPluginInfo.PLUGIN_GUID, MyPluginInfo.PLUGIN_NAME, MyPluginInfo.PLUGIN_VERSION)]
[BepInDependency(SpaceWarpPlugin.ModGuid, SpaceWarpPlugin.ModVer)]
public class SpaceWarpModLibraryPlugin : BaseSpaceWarpPlugin
{
    // These are useful in case some other mod wants to add a dependency to this one
    // ReSharper disable UnusedMember.Global
    public const string ModGuid = MyPluginInfo.PLUGIN_GUID;
    public const string ModName = MyPluginInfo.PLUGIN_NAME;
    public const string ModVer = MyPluginInfo.PLUGIN_VERSION;
    // ReSharper restore UnusedMember.Global

    // Singleton instance of the plugin class
    // ReSharper disable once UnusedAutoPropertyAccessor.Global
    public static SpaceWarpModLibraryPlugin Instance { get; set; }

    /// <summary>
    /// Runs when the mod is first initialized.
    /// </summary>
    public override void OnInitialized()
    {
        base.OnInitialized();

        Instance = this;
    }
}
