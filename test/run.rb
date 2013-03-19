#--
# Copyright (c) 2012 Muriel Salvan (Muriel@X-Aeon.com)
# Licensed under the terms specified in LICENSE file. No warranty is provided.
#++

Dir.chdir("#{File.dirname(__FILE__)}/dummy")
system('cucumber')
exit_status = $?.exitstatus
raise "cucumber failed with exit status #{exit_status}" unless (exit_status == 0)
