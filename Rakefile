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
