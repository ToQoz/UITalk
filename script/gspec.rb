#!/usr/bin/env ruby

rails_root = File.expand_path(File.dirname(__FILE__)).sub(/\/script$/, '')
Dir.glob("#{rails_root}/app/**/**/*.rb") { |f|
  spec_file = f.sub(/#{rails_root}\/app\//, "#{rails_root}/spec/").sub(/\.rb$/, '_spec.rb')
  if !File.exist?(spec_file)
    print("touch #{spec_file}. OK? >")
    responce = $stdin.gets.sub(/\n/, '')
    if (responce == "y" || responce == "yes")
      if system("touch #{spec_file}")
        puts 'succeed'
      else
        puts 'faild'
      end
    end
  end
}
