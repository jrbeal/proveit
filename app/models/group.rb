class Group < ActiveRecord::Base
  belongs_to :topic
  has_many :users, :class_name=>"Account"
end
