class Category < ActiveRecord::Base
	has_one :topic
end
