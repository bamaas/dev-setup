# Setup
1. Download & Install [Windows terminal](https://github.com/microsoft/terminal/releases). Use the .msixbundle
2. Install wsl2 with Ubuntu 22.04: `wsl --install -d Ubuntu-22.04`
3. Create an username and password
4. Enter `wsl2: wsl -d Ubuntu-22.04`
5. Navigate to the directory where you extracted the zip. Windows filesystem is mounted on /mnt/c/
6. Run: `./install.sh` (You are prompted for your password 2 times during installation)
7. logout sign-in again
8. Set default profile in Windows terminal. Go to: `settings -> Startup -> Default profile`
9. Install color scheme. Open Windows terminal settings.json: `Arrow button -> settings -> gear icon bottom left`. Paste the below code block as part of the array `schemes`:
```
// Source: https://github.com/Richienb/windows-terminal-snazzy
{
	"name": "Snazzy",
	"foreground": "#eff0eb",
	"background": "#282a36",
	"selectionBackground": "#3e404a",
	"cursorColor": "#97979b",
	"black": "#282a36",
	"red": "#ff5c57",
	"green": "#5af78e",
	"yellow": "#f3f99d",
	"blue": "#57c7ff",
	"purple": "#ff6ac1",
	"cyan": "#9aedfe",
	"white": "#f1f1f0",
	"brightBlack": "#686868",
	"brightRed": "#ff5c57",
	"brightGreen": "#5af78e",
	"brightYellow": "#f3f99d",
	"brightBlue": "#57c7ff",
	"brightPurple": "#ff6ac1",
	"brightCyan": "#9aedfe",
	"brightWhite": "#eff0eb"
}
```
10. Set color scheme & font. Go to: `Select profile -> appearance -> Set color scheme to Snazzy -> Set font face to Cascadia Mono -> Set font size to 10`
11. Select profile -> adanced -> Bell notification style -> turn everything off
