# Setup
1. Download & Install [Windows terminal](https://github.com/microsoft/terminal/releases). Use the .msixbundle
2. Install wsl2 with Ubuntu 22.04: `wsl --install -d Ubuntu-22.04`
3. Create an username and password
4. Enter `wsl2: wsl -d Ubuntu-22.04`
5. Navigate to the directory where you extracted the zip. Windows filesystem is mounted on /mnt/c/
6. Run: `./install.sh` (You are prompted for your password 2 times during installation)
7. logout sign-in again
8. Set default profile in Windows terminal. Go to: `settings -> Startup -> Default profile`
9. Install color scheme (https://github.com/Richienb/windows-terminal-snazzy). Open Windows terminal settings.json: `Arrow button -> settings -> gear icon bottom left`. Paste [snazzy-scheme.json](terminal/snazzy-scheme.json) from in the schemes object.
10. Set color scheme & font. Go to: `Select profile -> appearance -> Set color scheme to Snazzy -> Set font face to Cascadia Mono -> Set font size to 10`
11. Select profile -> adanced -> Bell notification style -> turn everything off
12. Set keybindings. Open Windows terminal settings.json: `Arrow button -> settings -> gear icon bottom left`. Overwrite the 'actions' object with the 'actions' object from [keybindings.json](terminal/keybindings.json).
13. Set background image.
