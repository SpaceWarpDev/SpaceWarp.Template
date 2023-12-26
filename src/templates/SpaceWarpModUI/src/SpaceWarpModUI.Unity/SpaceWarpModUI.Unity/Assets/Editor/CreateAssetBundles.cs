using UnityEditor;
using System.IO;

namespace SpaceWarpModUI.Unity.Editor
{
    /// <summary>
    /// This script adds a menu item to the Unity Editor under "Assets" called "Build AssetBundles" that will
    /// build all asset bundles in the project and copy them to the "plugin_template/assets/bundles" directory.
    /// </summary>
    public static class CreateAssetBundles
    {
        private const string AssetBundleDirectory = "Assets/AssetBundles";
        // Relative path from the Unity project directory to the target directory
        private const string TargetDirectory = "../../../plugin_template/assets/bundles";

        [MenuItem("Assets/Build AssetBundles")]
        private static void BuildAllAssetBundles()
        {
            // Ensure the AssetBundle directory exists
            if (!Directory.Exists(AssetBundleDirectory))
            {
                Directory.CreateDirectory(AssetBundleDirectory);
            }

            // Build the asset bundles
            BuildPipeline.BuildAssetBundles(
                AssetBundleDirectory,
                BuildAssetBundleOptions.None,
                BuildTarget.StandaloneWindows
            );

            // Delete existing bundles in the target directory
            if (Directory.Exists(TargetDirectory))
            {
                var files = Directory.GetFiles(TargetDirectory, "*.bundle");
                foreach (var file in files)
                {
                    File.Delete(file);
                }
            }
            else
            {
                Directory.CreateDirectory(TargetDirectory);
            }

            // Copy the newly built bundles to the target directory
            var newBundles = Directory.GetFiles(AssetBundleDirectory, "*.bundle");
            foreach (var bundle in newBundles)
            {
                var destFile = Path.Combine(TargetDirectory, Path.GetFileName(bundle));
                File.Copy(bundle, destFile, overwrite: true);
            }
        }
    }
}