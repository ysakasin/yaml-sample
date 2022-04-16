require "yaml"

puts "target: #{__FILE__}"

path = File.join(__dir__, "i18n.yaml")
1.times do |i|
  print path
  YAML.load_file(path)
  puts " [ok]"
end