class StaticPagesController < ApplicationController
  def help
		@user = User.where(:email => "#{current_prover.email}").first
	end

  def about
		@user = User.where(:email => "#{current_prover.email}").first
  end

	def contact
		@user = User.where(:email => "#{current_prover.email}").first
	end
end
