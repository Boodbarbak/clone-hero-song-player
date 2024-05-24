# Clone Hero Song Player Script

## Overview

This script allows you to play songs from a Clone Hero game songs folder. The folder structure can include multiple levels of subfolders, and each song folder is identified by the presence of a `song.ini` file. The script mixes and plays all `.ogg` files (excluding `preview.ogg` and `crowd.ogg`) found in each song folder using `ffmpeg` and `ffplay`.

## Features

- Plays all `.ogg` files in a song folder simultaneously, excluding `preview.ogg` and `crowd.ogg`.
- Shuffles and plays songs in random order each time the script is run.
- Saves the playback state, allowing resumption from the last played song.
- Displays the path of the currently playing song folder in the `ffplay` window title.

## Prerequisites

- [ffmpeg](https://ffmpeg.org/download.html)
- [ffplay](https://ffmpeg.org/ffplay.html)
- Windows operating system with Command Prompt.

## Installation

1. Download and install `ffmpeg` and `ffplay` if not already installed.
2. Clone this repository to your local machine.
3. Ensure the script file `play.bat` is in the root directory of your Clone Hero songs (or in a song pack directory if you wish to play a song pack instead of all your library).

## Usage

1. Open Command Prompt.
2. Navigate to the directory containing the `clone_hero_player.bat` script.
3. Run the script by typing:
   ```batch
   play.bat
   ```
The script will create a bunch of files:

- song_dirs.txt
- song_dirs_shuffled.txt
- last_played_index.txt

First execution of the script will 

1. Search for all song sub-directories and write them in `song_dirs.txt`
2. Shuffle them in `song_dirs_shuffled.txt`

These steps may take a while depending on how many songs there are in your library / song pack.

## License

This project is licensed under the Creative Commons Zero v1.0 Universal license. For more information, please see the [LICENSE](LICENSE) file.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue to discuss any changes or improvements.

## Acknowledgments

- Thanks to the creators of Clone Hero for providing an amazing platform for playing custom songs.
- Thanks to the `ffmpeg` and `ffplay` developers for their powerful multimedia processing tools.

---

Feel free to reach out if you have any questions or need further assistance. Enjoy playing your Clone Hero songs!
