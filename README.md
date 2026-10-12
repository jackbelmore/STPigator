# STPigator

A keyboard-driven file finder for Windows that searches a local library of product
datasheets (PDF) and CAD files (STP/ZIP) as you type, and attaches the selected file to
an Outlook email with one key press.

It was built for an engineering support team that answers many customer requests for
the same documents each day. It replaced searching through a virtual desktop's file
browser, which took around 20 seconds per query, with near-instant results.

The code was written by AI coding tools (Claude Code and Gemini Code Assist) under my
direction: I set the requirements, reviewed the plans and tested it in daily use.

## Features

- **Live search** of the whole library as you type, with `?` and `*` wildcards
- **Three modes**, switched with `Ctrl+T`: datasheets (PDF), CAD files (STP/ZIP), and the 20 most recently used files
- **One-key Outlook attach**: adds the file to the email currently open, or creates a new email if none is open
- **Automatic subject line**: the article number and type key are read from the filename and used as the email subject
- **Highlighting** of article numbers (green) and type keys (yellow) in the results
- **Safe delete**: files are moved to the Recycle Bin, not deleted permanently

## Design constraints

The tool had to run on locked-down company machines without IT involvement:

- Uses only PowerShell and components built into Windows; nothing to install
- Needs no administrator rights
- Searches only its own `Data` folder
- Runs PowerShell with an execution-policy bypass for its own process only; it does not change system or user policy

## Requirements

- Windows 10 or 11 with Windows PowerShell 5.1
- Microsoft Outlook (desktop) for the attach feature; without it, files open in their default application

## Setup

1. Download or clone this repository.
2. Create the data folders and add your files:

   ```text
   STPigator/
   ├── Data/
   │   ├── PDFs/            datasheets (.pdf)
   │   └── STP_and_ZIPs/    CAD files and archives (.stp, .zip)
   ├── Scripts/
   │   ├── navigator.ps1
   │   └── New-OutlookEmail.ps1
   └── STPigator.bat
   ```

3. Double-click `STPigator.bat`.

The `Data` folder and the recent-files history are listed in `.gitignore` and are never committed.

## Keyboard shortcuts

| Key | Action |
|---|---|
| Type | Filter results |
| `Backspace` | Delete the last search character |
| `Up` / `Down` | Move through results |
| `Page Up` / `Page Down` | Move one page |
| `Ctrl+U` / `Ctrl+D` | Move half a page |
| `Enter` | Attach the selected file to Outlook |
| `Ctrl+1` to `Ctrl+0` | Attach visible result 1 to 10 |
| `Ctrl+O` | Open the selected file |
| `Ctrl+T` | Switch mode: PDFs, STP/ZIPs, Recent |
| `Delete` | Move the selected file to the Recycle Bin |
| `Esc` or `Ctrl+Q` | Quit |

## Filename recognition

Article numbers are six digits, optionally followed by a suffix:

| Pattern | Example |
|---|---|
| Base number | `123456` |
| Letter suffix | `123456E` |
| Dot, dash or underscore suffix | `123456.A01`, `123456-A01`, `123456_H01` |

Type keys are two capital letters followed by two or three digits and further characters,
for example `AB12C-3DE.F4.GH`.

## Troubleshooting

| Problem | Fix |
|---|---|
| No files found | Check the files are in `Data/PDFs` or `Data/STP_and_ZIPs` and have a `.pdf`, `.stp` or `.zip` extension |
| File opens instead of attaching | Outlook is not running or not installed; start Outlook and try again |
| Script blocked by policy | Launch through `STPigator.bat`, not by running `navigator.ps1` directly |

## Project structure

| File | Purpose |
|---|---|
| `STPigator.bat` | Launcher |
| `Scripts/navigator.ps1` | Search interface, highlighting, history and key handling |
| `Scripts/New-OutlookEmail.ps1` | Attaches a file to the open Outlook email or creates a new one |
| `CLAUDE.md` | Notes for the AI coding agent used to build the project |
