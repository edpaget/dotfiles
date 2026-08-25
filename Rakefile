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

def link_dotfiles(force: false)
  replace_all = force

  Dir['*'].each do |file|
    next if %w[Rakefile README.md Brewfile CLAUDE.md claude].include? file

    dest = File.join(ENV['HOME'], ".#{file}")

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
  # Ghostty reads its config from a different place on each platform, and the
  # macOS path is not merely preferred there — on Linux it would create a bogus
  # ~/Library tree that Ghostty never looks at, so `rake install` would report
  # success and change nothing the terminal reads.
  ghostty_dir = if RbConfig::CONFIG['host_os'] =~ /darwin/
                  File.join(ENV['HOME'], "Library", "Application Support", "com.mitchellh.ghostty")
                else
                  File.join(ENV.fetch('XDG_CONFIG_HOME', File.join(ENV['HOME'], '.config')), "ghostty")
                end
  ghostty_config = File.join(ghostty_dir, "config")
  source = File.expand_path("config/ghostty/config")

  FileUtils.mkdir_p(ghostty_dir)

  # Linux gets an extra overlay linked in as `config.local`, which the shared
  # config includes optionally. Ghostty resolves that relative path next to the
  # DEPLOYED config, so linking it here is what activates it — and macOS, where
  # no such link is made, silently skips the include.
  #
  # It exists for font-size: the same panel is a 3008x1692 workspace on macOS
  # and 2560x1440 under Plasma at 200%, so a point is physically larger on
  # Linux and a size tuned on a Mac reads oversized.
  unless RbConfig::CONFIG['host_os'] =~ /darwin/
    overlay_source = File.expand_path("config/ghostty/config.linux")
    overlay_dest = File.join(ghostty_dir, "config.local")

    if File.symlink?(overlay_dest) || File.exist?(overlay_dest)
      puts "Already linked #{overlay_dest}" if File.identical?(overlay_source, overlay_dest)
    else
      system %Q{ln -s "#{overlay_source}" "#{overlay_dest}"}
      puts "Linked #{overlay_dest}"
    end
  end

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
