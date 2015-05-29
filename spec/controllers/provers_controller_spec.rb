require 'rails_helper'

describe ProversController do

	before :each do
		user = Prover.create :email => "a@b.c", :password => "password"
		sign_in user
	end

	after :each do
		Prover.delete_all
	end

	describe '#top' do
		it 'should assign @top_provers' do
			get :scoreboard
			expect(assigns(:top_provers)).to be_present
		end

		it 'should find the top 10 provers by rating if no limit is specified' do
			10.times do |i|
				Prover.create :email => "a#{i}@b.c", :password => "password", :rating => 90.0
			end

			p = Prover.create :email => "low@score.com", :password => "password", :rating => 0.0

			get :scoreboard
			expect(assigns["top_provers"]).to_not include(p)
			expect(assigns["top_provers"].size).to eq(10)
		end

		it 'should find the top provers by rating using the limit param' do
			limit = Random::rand(5)
			limit.times do |i|
				Prover.create :email => "a#{i}@b.c", :password => "password", :rating => 90.0
			end

			get :scoreboard, :limit => limit
			expect(assigns["top_provers"].size).to eq(limit)
		end

		it 'should render its view without a layout' do
			get 'scoreboard'
			expect(response).to_not render_template('layouts/application')
			expect(response).to render_template :scoreboard
		end
	end
end