#!/usr/bin/env ruby

require 'xcodeproj'
# require 'pry-byebug'
# binding.pry

root_path = Dir.pwd
source_root = "#{Dir.pwd}/HeaderPractice/placeholders"
project_path = "#{Dir.pwd}/HeaderPractice.xcodeproj"
project = Xcodeproj::Project.open(project_path)
target = project.targets.find { |target| target.name == 'HeaderPractice' }
group = project.main_group.find_subpath(File.join('HeaderPractice', 'placeholders'), true)


raise "Invalid target!" if target.nil?
raise "Invalid group!" if group.nil?

all_files = Dir.glob("#{source_root}/*.{h,m}").map { |file| 
    file.sub("#{source_root}", "")
}

header_files = all_files.select { |file| File.extname(file) == ".h" }
source_files = all_files.select { |file| File.extname(file) == ".m" }


if group.files.length() > 0
    puts "Removing #{group.files.length()} file(s) from project, this may take a few minutes, suggest reverting the changes locally via git and try again."

    # Remove all the existing headers from 'Headers' phase.
    header_files.each { |path|
        fileref = project.reference_for_path("#{source_root}#{path}")
        target.headers_build_phase.remove_file_reference(fileref) if not fileref.nil?
    }

    # Remove all the existing source files from 'Compile Source' phase.
    source_files.each { |path|
        fileref = project.reference_for_path("#{source_root}#{path}")
        target.source_build_phase.remove_file_reference(fileref) if not fileref.nil?
    }

    # Remove all the files under the group from project.
    group.files.each { |file|
        file.remove_from_project
    }

    project.save
end

# Add the header references to 'Headers' phase manually again.
header_files.each { |path|
    file = group.new_file("#{source_root}#{path}")
    target.add_file_references([file])
}

# Add the source file references to 'Compile Source' phase manually again.
source_files.each { |path|
    file = group.new_file("#{source_root}#{path}")
    target.add_file_references([file])
}

project.save

puts "Added #{header_files.length()} header file(s) and #{source_files.length()} source file(s) to project."
