namespace SpaceWarpModUI.Unity.Runtime
{
    /// <summary>
    /// This is an example Unity script that will also be compiled with your plugin. You can add scripts like
    /// this for example to create custom controls that you will then be able to use in both the editor and
    /// in the game.
    /// </summary>
    public class ExampleScript
    {
        /// <summary>
        /// Returns a greeting for the player based on the current time of day.
        /// </summary>
        /// <param name="playerName">The name of the player.</param>
        /// <param name="isAfternoon">Whether it is currently afternoon.</param>
        /// <returns></returns>
        public static string GetGreeting(string playerName, bool isAfternoon)
        {
            return $"Good {(isAfternoon ? "afternoon" : "morning")}, {playerName}!";
        }
    }
}