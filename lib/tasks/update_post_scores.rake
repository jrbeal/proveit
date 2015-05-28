desc "Update post scores"
task :update_scores => :environment do

	Post::update_post_scores
	Prover::update_ratings
	Prover::update_rankings

end