#server.rb
# Simple System Info for Raspberry Pi

# Written by Alex Standke <xanderstrike@gmail.com>
#   https://github.com/XanderStrike/pi-status

# License: MIT

require 'sinatra'

def getgen
  output = `uptime`.gsub(/\s+/m, ' ').split("up ").last.split(", ")
  results = {uptime: output[0], since: output[1], users: output[2].to_i}
end

def getmem
  output = `free -m`.gsub(/\s+/m, ' ').strip.split(' ')
  results = {total: output[7], used: output[8], free: output[9], swaptotal: output[18], swapused: output[19], swapfree: output[20]}
end

def getcpu
  mpstat = `mpstat`.split("\n").last.gsub(/\s+/m, ' ').strip.split(' ').last
  temp = `/opt/vc/bin/vcgencmd measure_temp`.split("=").last.chomp
  results = {used: '%.2f' % (100 - mpstat.to_f), free: mpstat, temp: temp}
end

def getdrives
  output = `df -h`.split("\n")[1].gsub(/\s+/m, ' ').strip.split(' ')
  results = {name: output[0], total: output[1], used: output[2], free: output[3], percent: output[4]}
end

def getip
  results = `curl -s http://checkip.dyndns.org | sed 's/[a-zA-Z/<> :]//g'`
end

set :port, 80
set :bind, '0.0.0.0'

get '/' do
  gen = getgen
  cpu = getcpu
  mem = getmem
  hd = getdrives
  @output = []
  @output << "<b>GENERAL</b><br>Uptime: #{gen[:uptime]}<br>Users: #{gen[:users]}<br>IP: #{getip}"
  @output << "<b>CPU</b><br>Used: #{cpu[:used]}%<br>Temp: #{cpu[:temp]}"
  @output << "<b>RAM</b><br>Used: #{mem[:used]}mb<br>Free:  #{mem[:free]}mb<br>Total: #{mem[:total]}mb"
  @output << "<b>SWAP</b><br>Used: #{mem[:swapused]}mb<br> Free: #{mem[:swapfree]}mb<br> Total: #{mem[:swaptotal]}mb"
  @output << "<b>DRIVES</b><br>Name: #{hd[:name]}<br>Free: #{hd[:free].downcase}b<br>Used: #{hd[:used].downcase}b (#{hd[:percent]})<br>Total: #{hd[:total].downcase}b"
  @output.join("<br>")
  erb :index
end
