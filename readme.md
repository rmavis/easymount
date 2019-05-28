# Easymount

Graphical file managers (like Nautilus) provide a convenient method for mounting and unmounting USB drives. When the drive is inserted, the drive's name appears somewhere (like the sidebar) and clicking it will mount the drive's filesystem (in a mnemonic location, like `/media/USERNAME/DRIVENAME`). Subsequently, an eject button will appear beside the drive's name, and clicking it will unmount the drive.

Easymount is a script intended to replicate this convenience outside of desktop environments, like with tiling window managers.

It lists mountable/mounted drives with `dmenu`, mounts/unmounts them with `udisksctl`, and sends a success/error message with `notify-send`. Thus, easymount requires those programs. But of course you're free to tailor to taste.


## Usage

Review mountable drives (via `dmenu`) and mount one, if you so choose:

    easymount mount

Review mounted drives (via `dmenu`) and unmount one, if you so choose:

    easymount unmount

Remind yourself how the script works:

    easymount help

I've found it useful to map the mount and unmount commands to mnemonic keyboard shortcuts. For i3, this looks like:

    bindsym $mod+m exec ~/bin/easymount mount
    bindsym $mod+Shift+m exec ~/bin/easymount unmount


## Installation

0. Download the script, put it somewhere useful, and make it executable.
1. Review the script and, if needed, edit to ensure the paths are accurate and that the commands it calls will work. In particular, the `dmenu` command likely won't work for you (unless you've also wrapped it in a script called `theme-dmenu`).
2. Maybe add a nice symlink somewhere, like `ln -s path/to/easymount.rb ~/bin/easymount`.
3. There is no step 3.
