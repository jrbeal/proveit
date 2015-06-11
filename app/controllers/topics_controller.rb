class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create

		post_params = {
			:message => params[:message],
			:support => params[:support],
			:kind => params[:type],
			:url => params[:url],
		}

		topic_params = {
			:private => (params[:format] == "private"),
			:lone_wolf => (params[:lone_wolf] == "lone_wolf"),
			:use_teams => (params[:use_teams] == "use_teams"),
			:public_viewing => (params[:publicviewing] == "publicviewing"),
			:public_comments => (params[:publiccomments] == "publiccomments"),
		}


		@post = Post.new(post_params)
    @topic = Topic.new(topic_params)

		@post.topic = @topic
		@post.parent = nil
		@post.prover = current_prover
		@topic.root_id = @post

		if @topic.private?
			case params[:type]
			when Post::OPINION
				if @topic.use_teams?
					team1_type = Team::AGREE
					team2_type = Team::DISAGREE
				else
					team1_type = Team::PARTICIPANT
				end
			when Post::INITIATOR
				if @topic.use_teams?
					team1_type = Team::TEAM1
					team2_type = Team::TEAM2
				else
					team1_type = Team::PARTICIPANT
				end
			when Post::COMMENT
				team1_type = Team::PARTICIPANT
			else
				puts "Invalid team type"
			end

			params[:team1].split.each do |id|
				@team_member = Team.new(:prover => Prover.find(id), :topic => @topic, :team_type => team1_type)
				@team_member.save!
			end

			if @topic.use_teams?
				params[:team2].split.each do |id|
					@team_member = Team.new(:prover => Prover.find(id), :topic => @topic, :team_type => team2_type)
					@team_member.save!
				end
			end
		end

		@topic.save!
		@post.save!

		redirect_to root_path
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
#      params.require(:topic).permit(:topic_id, :private, :lone_wolf, :teams, :public_viewing, :public_comments, :post_id)
    end
end
