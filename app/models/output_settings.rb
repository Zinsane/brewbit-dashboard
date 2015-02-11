# Attributes:
# * device_session_id [integer] - - Which device session it belongs to
# * function [integer] - - Function of the output [ HEATING, COOLING, MANUAL ]
# * cycle_delay [integer] - - How much to wait between power cycles of an output in minutes
#
# * id [integer, primary, not null] - primary key
# * created_at [datetime, not null] - creation time
# * updated_at [datetime, not null] - last update time
class OutputSettings < ActiveRecord::Base
  belongs_to :device_session

  FUNCTIONS = { heating: 0, cooling: 1, manual: 2 }
  FUNCTION_NAME = [ 'heating', 'cooling', 'manual' ]
  INDEX_NAME = [ 'left', 'right' ]

  MAX_CYCLE_DELAY = 30
  
  validates :output_index, presence: true
  validates :function, presence: true, inclusion: { in: FUNCTIONS.values }
  validates :cycle_delay, allow_blank: true,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: MAX_CYCLE_DELAY }

  def function_name
    FUNCTION_NAME[self.function].capitalize
  end

  def index_name
    INDEX_NAME[self.output_index].capitalize
  end
end

