using BepInEx;
using HarmonyLib;
using KSP.UI.Binding;
using SpaceWarp;
using SpaceWarp.API.Assets;
using SpaceWarp.API.Mods;
using SpaceWarp.API.Game;
using SpaceWarp.API.Game.Extensions;
using SpaceWarp.API.UI;
using SpaceWarp.API.UI.Appbar;
using UnityEngine;

namespace SpaceWarpMod;

[BepInPlugin(MyPluginInfo.PLUGIN_GUID, MyPluginInfo.PLUGIN_NAME, MyPluginInfo.PLUGIN_VERSION)]
[BepInDependency(SpaceWarpPlugin.ModGuid, SpaceWarpPlugin.ModVer)]
public class SpaceWarpModPlugin : BaseSpaceWarpPlugin
{
    // These are useful in case some other mod wants to add a dependency to this one
    public const string ModGuid = MyPluginInfo.PLUGIN_GUID;
    public const string ModName = MyPluginInfo.PLUGIN_NAME;
    public const string ModVer = MyPluginInfo.PLUGIN_VERSION;
    
    private bool _isWindowOpen;
    private Rect _windowRect;

    private const string ToolbarFlightButtonID = "BTN-SpaceWarpModFlight";
    private const string ToolbarOABButtonID = "BTN-SpaceWarpModOAB";

    public static SpaceWarpModPlugin Instance { get; set; }

    /// <summary>
    /// Runs when the mod is first initialized.
    /// </summary>
    public override void OnInitialized()
    {
        base.OnInitialized();

        Instance = this;

        // Register Flight AppBar button
        Appbar.RegisterAppButton(
            "swinfo_name",
            ToolbarFlightButtonID,
            AssetManager.GetAsset<Texture2D>($"{SpaceWarpMetadata.ModID}/images/icon.png"),
            isOpen =>
            {
                _isWindowOpen = isOpen;
                GameObject.Find(ToolbarFlightButtonID)?.GetComponent<UIValue_WriteBool_Toggle>()?.SetValue(isOpen);
            }
        );

        // Register OAB AppBar Button
        Appbar.RegisterOABAppButton(
            "swinfo_name",
            ToolbarOABButtonID,
            AssetManager.GetAsset<Texture2D>($"{SpaceWarpMetadata.ModID}/images/icon.png"),
            isOpen =>
            {
                _isWindowOpen = isOpen;
                GameObject.Find(ToolbarOABButtonID)?.GetComponent<UIValue_WriteBool_Toggle>()?.SetValue(isOpen);
            }
        );

        // Register all Harmony patches in the project
        Harmony.CreateAndPatchAll(typeof(SpaceWarpModPlugin).Assembly);

        // Try to get the currently active vessel, set its throttle to 100% and toggle on the landing gear
        try
        {
            var currentVessel = Vehicle.ActiveVesselVehicle;
            if (currentVessel != null)
            {
                currentVessel.SetMainThrottle(1.0f);
                currentVessel.SetGearState(true);
            }
        }
        catch (Exception e) {}
        
        // Fetch a configuration value or create a default one if it does not exist
        var defaultValue = "my_value";
        var configValue = Config.Bind<string>("Settings section", "Option 1", defaultValue, "Option description");
        
        // Log the config value into <KSP2 Root>/BepInEx/LogOutput.log
        Logger.LogInfo($"Option 1: {configValue.Value}");
    }

    /// <summary>
    /// Draws a simple UI window when <code>this._isWindowOpen</code> is set to <code>true</code>.
    /// </summary>
    private void OnGUI()
    {
        // Set the UI
        GUI.skin = Skins.ConsoleSkin;

        if (_isWindowOpen)
        {
            _windowRect = GUILayout.Window(
                GUIUtility.GetControlID(FocusType.Passive),
                _windowRect,
                FillWindow,
                "swinfo_name",
                GUILayout.Height(350),
                GUILayout.Width(350)
            );
        }
    }

    /// <summary>
    /// Defines the content of the UI window drawn in the <code>OnGui</code> method.
    /// </summary>
    /// <param name="windowID"></param>
    private static void FillWindow(int windowID)
    {
        GUILayout.Label("swinfo_name - swinfo_description");
        GUI.DragWindow(new Rect(0, 0, 10000, 500));
    }
}
