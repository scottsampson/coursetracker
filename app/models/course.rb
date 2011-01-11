class Course < ActiveRecord::Base
  belongs_to :target
  belongs_to :level
  has_and_belongs_to_many :users
  has_many :prerequisites
  has_many :exercises, :through => :prerequisites
  default_scope order('level_id, order_num')  
end
