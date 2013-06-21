require 'sinatra'

def getmem
  output = `free -m`
  output = output.gsub(/\s+/m, ' ').strip.split(' ')
  results = {total: output[7], used: output[8], free: output[9], swaptotal: output[18], swapused: output[19], swapfree: output[20]}
end

#requires sysstat
def getcpu
  output = `mpstat`
  output = output.split("\n").last.gsub(/\s+/m, ' ').strip.split(' ').last
  results = {used: '%.2f' % (100 - output.to_f), free: output}
end

def getdrives
  # ouput = `df -h`
  output = `df -h`.split("\n")[1].gsub(/\s+/m, ' ').strip.split(' ')
  results = {name: output[0], total: output[1], used: output[2], free: output[3], percent: output[4]}
end


get '/' do
  cpu = getcpu
  mem = getmem
  hd = getdrives
  @output = []
  @output << "<b>CPU</b><br>Used: #{cpu[:used]}<br>Free: #{cpu[:free]}"
  @output << "<b>RAM</b><br>Used: #{mem[:used]}mb<br>Free:  #{mem[:free]}mb<br>Total: #{mem[:total]}mb"
  @output << "<b>SWAP</b><br>Used: #{mem[:swapused]}mb<br> Free: #{mem[:swapfree]}mb<br> Total: #{mem[:swaptotal]}mb"
  @output << "<b>DRIVES</b><br>Name: #{hd[:name]}<br>Free: #{hd[:free]}<br>Used: #{hd[:used]} (#{hd[:percent]})<br>Total: #{hd[:total]}"
  @output.join("<br>")
  erb :index
end