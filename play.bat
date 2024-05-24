@echo off
setlocal enabledelayedexpansion

REM Set the base directory to the Clone Hero songs directory
set "BASE_DIR=."


REM Main script execution

REM Collect all song directories if song_dirs.txt does not exist
if not exist song_dirs.txt (
    call :collect_song_dirs "%BASE_DIR%"
)

REM Check if there is a saved state
if exist song_dirs_shuffled.txt (
    echo Resuming from saved state...
    for /F "tokens=1* delims=" %%a in (last_played_index.txt) do set "last_index=%%a"
    set "resume=true"
) else (
    REM Shuffle the list of song directories
    del song_dirs_shuffled.txt 2> NUL
    call :shuffle_song_dirs
    set "last_index=0"
    set "resume=false"
)

REM Play songs in shuffled order starting from the last played index
set "current_index=0"
for /F "tokens=1,2* delims=§" %%a in (song_dirs_shuffled.txt) do (
    set /a current_index+=1
    if !current_index! GEQ !last_index! (
        pushd "%%b"
        echo Playing %%b
        call :play_ogg_files "%%b"
        popd
        REM Save the current index to file
        echo !current_index! > last_played_index.txt
    )
)

REM Clean up
REM del song_dirs_shuffled.txt
REM del last_played_index.txt

endlocal
pause
goto :eof

REM Function to play .ogg files using ffplay
:play_ogg_files
set "song_dir=%~1"
set "play_command=ffmpeg -loglevel error"
set "file_count=0"
for %%f in (*.ogg) do (
    if /I "%%f" neq "preview.ogg" if /I "%%f" neq "crowd.ogg" (
        set "play_command=!play_command! -i %%f"
        set /a file_count+=1
    )
)
set "play_command=!play_command! -filter_complex amix=inputs=!file_count!:dropout_transition=0:normalize=0 -f ogg - | ffplay -autoexit -hide_banner -window_title "!song_dir!" -i -"
REM echo !play_command!
%play_command%
goto :eof

REM Recursive function to collect song directories
:collect_song_dirs
echo Building song list...
for /r "%1" %%d in (.) do (
    if exist "%%d\song.ini" (
        echo %%d >> song_dirs.txt
    )
)
goto :eof

REM Function to shuffle the list of song directories
:shuffle_song_dirs
echo Shuffling songs...
set "shuffled_file=song_dirs_shuffled.txt"

copy NUL "%shuffled_file%" > NUL
for /F "delims=" %%i in (song_dirs.txt) do (
    set /a rand=!random!
    echo !rand!§%%i >> shuffle_temp.txt
)
sort shuffle_temp.txt /R > "%shuffled_file%"
del shuffle_temp.txt
goto :eof
