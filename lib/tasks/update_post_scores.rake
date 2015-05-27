desc "Update post scores"
task :update_scores => :environment do

	Post::update_post_scores
	Prover::update_prover_ratings
	Prover::update_prover_rankings

end