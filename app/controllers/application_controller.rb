class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	def homepage
		@topics = Topic.all
		@posts = []
		@topics.each do |topic|
      @posts.push topic.root_id
		end
	end
end