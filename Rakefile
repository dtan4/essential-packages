SYMLINKS_EXCLUDE = %w{. .. .git .gitmodules .gitignore Rakefile README.md}
LINUX_ONLY = %w{}
MAC_ONLY = %w{Brewfile Brewfile.cask Brewfile.cask.once}

task default: "update"

desc "Install"
task :install => [
  :create_symlinks
] do
end

desc "Create symlinks"
task :create_symlinks do
  Dir.glob("*", File::FNM_DOTMATCH) do |file|
    uname = `uname`.strip

    next if SYMLINKS_EXCLUDE.include?(file)
    next if (uname != "Darwin") && MAC_ONLY.include?(file)
    next if (uname != "Linux") && LINUX_ONLY.include?(file)

    source = File.join(Dir.pwd, file)
    destination = File.join(ENV["HOME"], file)

    if File.exists?(destination) || Dir.exists?(destination)
      $stderr.puts "[WARN] File/Dir already exists: #{destination}"
      next
    end

    ln_s(source, destination)
  end
end

desc "Update packages"
task :update do
  uname = `uname`.strip

  case uname
  when "Darwin"
    Rake::Task["update_osx"].invoke
  else
  end
end

desc "Update packages in OS X"
task :update_osx do
  %w(Brewfile Brewfile.cask).each do |brewfile|
    sh "brew update"
    sh "brew upgrade"
    sh "brew bundle #{brewfile}"
  end
end
