#!/usr/bin/ruby

require 'open3'

# usage :: string
def usage
  <<~HELP
    usage: easymount (help|mount|unmount)

    easymount presents a convenient interface to `udisksctl`'s `mount`
    and `unmount` commands. It's intended to be used with `dmenu` and
    `notify-send`, so those programs are also required.
  HELP
end

# init :: [string] -> void
def init(args)
  if (args.length != 1)
    puts usage
    return
  end

  command = args[0].downcase
  if (command == "mount")
    prompt_with_and_then("Mount", :list_mountable, :mount_command)
  elsif (command == "unmount")
    prompt_with_and_then("Unmount", :list_mounted, :unmount_command)
  else
    puts usage
  end
end

# prompt_with_and_then :: (string, symbol, symbol) -> void
def prompt_with_and_then(prompt, items, action)
  choice = `echo "#{self.send(items)}" | theme-dmenu -p "#{prompt}"`
  if (choice.length > 0)
    out, err, code = Open3.capture3(self.send(action, "#{mountable_path}/#{choice}"))
    if (err.length > 0)
      `notify-send -u critical Easymount "#{err}"`
    else
      `notify-send Easymount "#{out}"`
    end
  end
end

# mounted_path :: string
def mounted_path
  "/media/#{ENV['USERNAME']}"
end

# list_mounted :: string
def list_mounted
  `ls #{mounted_path}`
end

# mounted_path :: string
def mountable_path
  "/dev/disk/by-label"
end

# list_mountable :: string
def list_mountable
  (`ls #{mountable_path}`.split("\n") - list_mounted.split("\n")).join("\n")
end

# mount_command :: string -> string
def mount_command(path)
  "udisksctl mount --block-device #{path}"
end

# unmount_command :: string -> string
def unmount_command(path)
  "udisksctl unmount --block-device #{path}"
end

init(ARGV)
