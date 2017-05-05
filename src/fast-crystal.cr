require "./fast-crystal/*"
require "file_utils"

BIN_PATH = "bin"
SOURCE_PATH = File.expand_path("code")
CRYSTAL_VERSION = `crystal -v`

if Dir.exists?(BIN_PATH)
  FileUtils.rm_rf(BIN_PATH)
end

Dir.glob("code/**/*.cr").each do |file|
  test_file = File.basename(file)
  test_section = file.sub(test_file, "").sub("code/", "")

  bin_section = File.join(BIN_PATH, test_section)
  bin_file = File.join(bin_section, File.basename(test_file, File.extname(test_file)) + "_test")

  FileUtils.mkdir_p(bin_section)

  complie_command = [
    "crystal",
    "build",
    "--release",
    file,
    "-o",
    bin_file
  ]
  puts "RUN " + complie_command.join(" ")
  complie_output = `#{complie_command.join(" ")}`
  puts complie_output unless complie_output.empty?

  puts "RUN ./#{bin_file} with #{CRYSTAL_VERSION}"
  puts
  puts `./#{bin_file}`
end