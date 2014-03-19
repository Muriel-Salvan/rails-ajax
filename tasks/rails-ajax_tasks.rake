namespace :'rails-ajax' do

  # Copy a file if it does not exist from RailsAjax root path /gen to Rails root path
  #
  # Parameters::
  # * *file_name* (_String_): The file name
  def copy_file_unless_exists(file_name)
    dest_file_name = File.join(Rails.root, file_name)
    if (File.exist?(dest_file_name))
      puts "File #{dest_file_name} already exists. Will not overwrite."
    else
      puts "Creating file #{dest_file_name}."
      FileUtils.mkdir_p(File.dirname(dest_file_name))
      FileUtils.cp("#{RailsAjax.root}/gen/#{file_name}", dest_file_name)
    end
  end

  desc "Install required Rails Ajax files. Existing files will not be overwritten."
  task :install do
    copy_file_unless_exists('app/assets/javascripts/RailsAjax-Config.js.erb')
    copy_file_unless_exists('config/initializers/rails-ajax-config.rb')
  end

end
