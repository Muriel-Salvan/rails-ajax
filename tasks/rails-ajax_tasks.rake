#--
# Copyright (c) 2012 Muriel Salvan (Muriel@X-Aeon.com)
# Licensed under the terms specified in LICENSE file. No warranty is provided.
#++

namespace :'rails-ajax' do

  # Copy a file if it does not exist from RailsAjax root path /gen to Rails root path
  #
  # Parameters::
  # * *iFileName* (_String_): The file name
  def copy_file_unless_exists(iFileName)
    lDstFileName = File.join(Rails.root, iFileName)
    if (File.exist?(lDstFileName))
      puts "File #{lDstFileName} already exists. Will not overwrite."
    else
      puts "Creating file #{lDstFileName}."
      FileUtils.mkdir_p(File.dirname(lDstFileName))
      FileUtils.cp(File.join("#{RailsAjax.root}/gen", iFileName), lDstFileName)
    end
  end

  desc "Install required Rails Ajax files. Existing files will not be overwritten."
  task :install do
    copy_file_unless_exists('app/assets/javascripts/RailsAjax-Config.js.erb')
    copy_file_unless_exists('config/initializers/rails-ajax-config.rb')
  end

end
