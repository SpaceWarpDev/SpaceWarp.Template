using UnityEditor;
using System.IO;

namespace SpaceWarpModUI.Unity.Editor
{
    /// <summary>
    /// This script adds a menu item to the Unity Editor under "Assets" called "Build AssetBundles" that will
    /// build all asset bundles in the project.
    /// </summary>
    public static class CreateAssetBundles
    {
        private const string AssetBundleDirectory = "Assets/AssetBundles";

        [MenuItem("Assets/Build AssetBundles")]
        private static void BuildAllAssetBundles()
        {
            if (!Directory.Exists(AssetBundleDirectory))
            {
                Directory.CreateDirectory(AssetBundleDirectory);
            }

            BuildPipeline.BuildAssetBundles(
                AssetBundleDirectory,
                BuildAssetBundleOptions.None,
                BuildTarget.StandaloneWindows
            );
        }
    }
}