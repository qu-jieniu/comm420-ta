#  Install RIT on macOS

## All steps below will use Mac's  `Terminal.app`

## Install `Wine`

- Step 1: Go to the terminal and install `wine` and `winetricks`:
```sh
brew install --cask --no-quarantine gcenx/wine/wine-crossover
```
```sh
brew install winetricks
```

- *If you have an Intel Mac, You may skip this step and go to Step 3.*  

    Step 2: (Only if you have a M1 Mac,) Install Rosetta 2 using Terminal:
```sh
softwareupdate --install-rosetta
```

- Step 3: Initialize wine 
```sh 
wine winecfg
```
A window will pop up. You may consider mapping *Drives* or editing *Desktop Integreations*, but it's not necessary for the use of RIT.

## Install .NET Framework

- Step 4: Install .NET 4.0 using `winetricks`:
```sh
winetricks dotnet40
```
Follow the screen prompts (regular Windows installation process).

## Install RIT

- Step 5: Download RIT to wine's C:\ Drive
```sh
curl 'https://rit.306w.ca/client/Client.application' -o ~/.wine/drive_c/Client.application
```

- Step 6: Open Windows File Explore and go to the C Drive:
```sh
wine start "C:\Client.application"
```

- Step 7: Follow the installation prompt. When RIT login window appears, it has been successfully installed.

## Run RIT with a single command

- Step 8: Make an alias to the command above:
```sh
echo "alias RIT='wine start C:Client.application; exit 0'"
```

- Step 9: Quit  `Terminal.app` by using <kbd>&#8984;</kbd>+<kbd>Q</kbd>.

- Step 10: Reopen `Terminal.app` and you can now run the program by only entering `RIT`.
