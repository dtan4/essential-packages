#!/usr/bin/env ruby

def execute_brew_command(line)
  `brew #{line}`
end

def install_from_brewfile(brewfile)
  IO.foreach(brewfile) do |line|
    next if line.strip == ""

    execute_brew_command(line)
  end
end

def execute(argv)
  argv.each { |brewfile| install_from_brewfile(brewfile) }
end

if ARGV.length < 1
  execute(["Brewfile"])
else
  execute(ARGV)
end 

