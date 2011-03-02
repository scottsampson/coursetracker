class Tech < ActiveRecord::Base
  belongs_to :course
  belongs_to :project
end
