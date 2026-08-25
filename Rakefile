# Why do Python developers prefer dark mode?
# Because light attracts bugs.

require 'rake'

# From https://github.com/noahfrederick/dots/blob/master/Rakefile

task :default => [:install]

desc "Install dotfiles by creating symlinks"
task :install => [:link, :ghostty, :claude]

desc "Force install dotfiles, replacing all existing links"
task :force => [:ghostty] do
  link_dotfiles(force: true)
end

desc "Link dotfiles into user's home directory"
task :link do
  link_dotfiles
end

# Top-level entries that must be linked CHILD BY CHILD rather than as a whole
# directory.
#
# ~/.config is the case that forced this, and the reasoning is Linux-specific
# but applies everywhere. On Linux nearly every application keeps state there —
# Plasma's panel layout and global settings, GTK, dconf, Baloo — so linking the
# whole directory into this repo means three bad things:
#
#   1. Application runtime state lands inside a git repo and shows up as
#      untracked noise (Trolltech.conf, baloofilerc, dconf/ all appeared).
#   2. `rake install` can DELETE a live desktop's settings, because
#      replace_file is `rm -rf dest` — and doing that to a running session
#      loses everything the session writes at logout. Observed on 2026-08-25:
#      one `rake install` took out the desktop background, taskbar pins and
#      every other Plasma preference on that machine.
#   3. Ordinary git operations become destructive. `git clean -fdx` in this
#      repo would wipe the desktop's configuration, with no warning that it
#      could.
#
# Linking the children instead means ~/.config stays a real directory owned by
# the machine, and only the entries this repo actually tracks are symlinks.
LINK_CHILDREN = %w[config].freeze

def link_children(file, dest)
  FileUtils.mkdir_p(dest)

  Dir[File.join(file, '*')].each do |child|
    child_dest = File.join(dest, File.basename(child))
    child_source = File.expand_path(child)

    if File.symlink?(child_dest) && File.identical?(child_source, child_dest)
      puts "Already linked #{child_dest}"
    elsif File.exist?(child_dest) || File.symlink?(child_dest)
      # Never rm -rf here: on Linux these siblings are live application state.
      puts "Skipping #{child_dest} (exists and is not our link — remove it by hand if you want it linked)"
    else
      system %Q{ln -s "#{child_source}" "#{child_dest}"}
      puts "Linked #{child_dest}"
    end
  end
end

def link_dotfiles(force: false)
  replace_all = force

  Dir['*'].each do |file|
    next if %w[Rakefile README.md Brewfile CLAUDE.md claude].include? file

    dest = File.join(ENV['HOME'], ".#{file}")

    if LINK_CHILDREN.include?(file)
      # If a previous run replaced ~/.config with a symlink to this repo, undo
      # that first — removing the SYMLINK, never its target.
      File.delete(dest) if File.symlink?(dest)
      link_children(file, dest)
      next
    end

    if dest.nil?
      puts "Not linking #{file}"
    elsif File.exist?(dest) || File.symlink?(dest)
      if !replace_all && File.identical?(file, dest)
        puts "Already linked #{dest}"
      elsif replace_all
        replace_file file, dest
      else
        print "Overwrite #{dest} [ynaq]? "
        case $stdin.gets.chomp
        when 'y'
          replace_file file, dest
        when 'a'
          replace_all = true
          replace_file file, dest
        when 'q'
          exit
        else
          puts "Skipping #{dest}"
        end
      end
    else
      link_file file, dest
    end
  end
end

def replace_file file, dest
  system %Q{rm -rf "#{dest}"}
  link_file file, dest
end

def link_file file, dest
  puts "Linking #{dest}"
  system %Q{ln -s "$PWD/#{file}" "#{dest}"}
end

desc "Link Claude Code settings into ~/.claude"
task :claude do
  claude_dir = File.join(ENV['HOME'], ".claude")
  claude_settings = File.join(claude_dir, "settings.json")
  source = File.expand_path("claude/settings.json")

  FileUtils.mkdir_p(claude_dir)

  if File.exist?(claude_settings)
    if File.identical?(source, claude_settings)
      puts "Already linked #{claude_settings}"
    else
      print "Overwrite #{claude_settings} [yn]? "
      if $stdin.gets.chomp == 'y'
        system %Q{rm "#{claude_settings}"}
        system %Q{ln -s "#{source}" "#{claude_settings}"}
        puts "Linked #{claude_settings}"
      else
        puts "Skipping #{claude_settings}"
      end
    end
  else
    system %Q{ln -s "#{source}" "#{claude_settings}"}
    puts "Linked #{claude_settings}"
  end
end

desc "Link Ghostty config to macOS Application Support directory"
task :ghostty do
  # macOS ONLY, and the guard is load-bearing rather than tidy.
  #
  # On Linux this task must do nothing: `link_dotfiles` already symlinks this
  # repo's config/ directory to ~/.config, so ~/.config/ghostty IS
  # config/ghostty and Ghostty reads the tracked file directly. Linking
  # config/ghostty/config into ~/.config/ghostty/config there means linking a
  # file onto itself — which replaces the tracked file with a self-referential
  # symlink and leaves Ghostty with no readable config at all. (Observed doing
  # exactly that on 2026-08-25 before the guard existed.)
  #
  # macOS needs the link because Ghostty reads from ~/Library/Application
  # Support/com.mitchellh.ghostty/ instead, which no XDG symlink covers.
  next unless RbConfig::CONFIG['host_os'] =~ /darwin/

  ghostty_dir = File.join(ENV['HOME'], "Library", "Application Support", "com.mitchellh.ghostty")
  ghostty_config = File.join(ghostty_dir, "config")
  source = File.expand_path("config/ghostty/config")

  FileUtils.mkdir_p(ghostty_dir)

  if File.exist?(ghostty_config)
    if File.identical?(source, ghostty_config)
      puts "Already linked #{ghostty_config}"
    else
      print "Overwrite #{ghostty_config} [yn]? "
      if $stdin.gets.chomp == 'y'
        system %Q{rm "#{ghostty_config}"}
        system %Q{ln -s "#{source}" "#{ghostty_config}"}
        puts "Linked #{ghostty_config}"
      else
        puts "Skipping #{ghostty_config}"
      end
    end
  else
    system %Q{ln -s "#{source}" "#{ghostty_config}"}
    puts "Linked #{ghostty_config}"
  end
end
