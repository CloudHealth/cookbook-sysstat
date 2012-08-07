maintainer       "John Dewey"
maintainer_email "john@dewey.ws"
license          "Apache 2.0"
description      "Installs/Configures sysstat"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "1.0.0"

recipe           "sysstat", "Installs/Configures sysstat"

%w{ ubuntu }.each do |os|
  supports os
end
