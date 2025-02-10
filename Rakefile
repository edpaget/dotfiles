require 'rake'

# From https://github.com/noahfrederick/dots/blob/master/Rakefile

task :default => [:install]

desc "Install dotfiles by creating symlinks"
task :install => [:link]

desc "Link dotfiles into user's home directory"
task :link do
  replace_all = false

  Dir['*'].each do |file|
    next if %w[Rakefile README.md Brewfile].include? file

    dest = File.join(ENV['HOME'], ".#{file}")

    if dest.nil?
      puts "Not linking #{file}"
    elsif File.exist?(dest)
      if File.identical? file, dest
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


