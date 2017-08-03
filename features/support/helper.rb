require_relative 'helpers/email_helper'
require_relative 'helpers/tempmail_helper'
require_relative 'helpers/automation_helper'

module Helper
  include EmailHelper
  include TempmailHelper
  include AutomationHelper
end

World(Helper)
