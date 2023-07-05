# 🔒 Anti-Cheat | Stay vigilant and keep the gameplay fair

This is a comprehensive anti-cheat system designed to detect and prevent various cheats in a game environment. The anti-cheat includes several active functions that work together to maintain the integrity of the gameplay

# 🔧 Configuration

The configuration options can be found in the "--config" section of the code. Here are the current settings:

- notifytext: The format of the notification message sent to admins when a cheat is detected.
- admins: A table of admin user groups who will receive cheat detection notifications.
- notifydelay: The delay between cheat detection notifications

# 🛠️ Active Functions

The following cheat detection functions are currently active:

- Bunny Hop Checker: Detects players using bunny hopping techniques excessively.
- Aim Checker: Checks for silent aim cheats by comparing client and server angles.
- Anti-Screengrab Checker: Detects anti-screengrab protection used by cheaters.
- ESP Breaker: Detects cheats that provide unfair advantages through wall hacks.
- NoSpread Breaker: Prevents cheats that manipulate weapon spread, specifically for m9k/hl2/tfa weapons.

# 📡 Server-side Functionality

The server-side code handles cheat detection and reporting. When a cheat is detected, it sends a report to all admins specified in the configuration. The specific cheat and the player responsible are mentioned in the report

# 🔫 Aim Checker

The aim checker function detects silent aim cheats. When a player kills an entity, the code compares the attacker's view angles with the server's view angles. If significant differences are detected, it sends a report

# 🏃 Bunny Hop Checker

The bunny hop checker function detects players using bunny hopping techniques excessively. It counts the number of consecutive jumps while holding the spacebar. If the number exceeds a certain threshold, it sends a report

# 🔒 Anti-Screengrab Checker

The anti-screengrab checker function detects cheats that attempt to bypass screen capture mechanisms. It uses rendering techniques to verify the integrity of the rendered image. If any manipulation is detected, it sends a report

# 🌌 ESP Breaker

The ESP breaker function targets cheats that provide wall hacks or ESP (Extra Sensory Perception). It adjusts the collision bounds of nearby players, making them unable to gain an advantage through walls.

# 🎯 NoSpread Breaker

The NoSpread breaker function prevents cheats that manipulate weapon spread. It modifies the spread of bullets fired, making them less predictable and countering cheats that rely on precise aiming.

# 📝 Reporting

Cheat detection reports are sent to admins through in-game notifications. The reports contain information about the detected cheat, including the player's name and SteamID.

# 🔧 Additional Customization

Feel free to customize and optimize the code further to suit your specific game environment and anti-cheat needs. Modify the functions, adjust the detection thresholds, or add new cheat detection methods as required

# 🚫 Disclaimer

**Please note that no anti-cheat system is foolproof, and determined cheaters may still find ways to bypass detection. Regular updates and ongoing monitoring are necessary to stay ahead of cheat developers.**
