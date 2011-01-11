class Exercise < ActiveRecord::Base
  has_many :prerequisites
  has_many :courses, :through => :prerequisites
  default_scope order('order_num')
  accepts_nested_attributes_for :prerequisites, :allow_destroy => true
end
