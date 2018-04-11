require "file_utils"

BIN_PATH        = "bin"
SOURCE_PATH     = File.expand_path("code")
CRYSTAL_VERSION = `crystal -v`

if Dir.exists?(BIN_PATH)
  FileUtils.rm_rf(BIN_PATH)
end

puts
puts "> Test in #{CRYSTAL_VERSION}"
puts

section = ""
Dir.glob("code/**/*.cr").each do |file|
  test_file = File.basename(file)
  test_section = file.sub(test_file, "").sub("code/", "")[0..-2]

  bin_section = File.join(BIN_PATH, test_section)
  bin_file = File.join(bin_section, File.basename(test_file, File.extname(test_file)))

  FileUtils.mkdir_p(bin_section)

  if section.empty? || section != test_section
    section = test_section
    puts "### " + (section == "proc-and-block" ? "Proc & Block" : section.capitalize)
    puts
  end

  compile_command = ["crystal", "build", "--release", "--no-debug", "-o", bin_file, file]
  print_title(file)
  puts
  puts "```"
  puts "$ " + compile_command.join(" ")
  `#{compile_command.join(" ")}`

  puts "$ ./" + bin_file
  puts
  puts `./#{bin_file}`
  puts "```"
  puts
end

def print_title(file)
  filename = File.basename(file)
  file_path = file.sub(SOURCE_PATH, "")

  title = filename.sub(File.extname(filename), "")
  title = if title.includes?("-vs-")
            title_sections = [] of String
            title.split("-vs-").each do |str|
              title_sections << "`" + (str.includes?("[-1]") ? str : str.sub("-", " ")) + "`"
            end

            title_sections.join(" vs ")
          else
            title.capitalize
          end

  puts "#### " + title + " [code](" + file_path + ")"
end
