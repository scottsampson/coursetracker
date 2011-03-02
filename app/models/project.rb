class Project < ActiveRecord::Base
  has_many :techs, :dependent => :destroy
  has_many :courses, :through => :techs
end
