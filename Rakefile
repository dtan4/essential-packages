SYMLINKS_EXCLUDE = %w{. .. .git .gitmodules Rakefile README.md}
LINUX_ONLY = %w{}
MAC_ONLY = %w{Brewfile}

task default: "setup:setup"

namespace :setup do
  desc "Set up this computer to use the dotfiles"
  task :setup do
    Rake::Task["setup:symlink_dotfiles"].invoke
  end

  desc "Make symlinks from home directory to the dotfiles"
  task :symlink_dotfiles do
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
end
