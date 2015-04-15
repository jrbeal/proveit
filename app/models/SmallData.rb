module Constants
  @@pctr = 0

	def self::pctr
		@@pctr += 1
		@@pctr
	end

  @@cctr = 0

	def self::cctr
		@@cctr += 1
		@@cctr
	end

  @@ictr = 0

	def self::ictr
		@@ictr += 1
		@@ictr
	end

	@@num = 0
end

Topic.delete_all
User.delete_all
Post.delete_all

u1 = User.create(:user_name => "jrbeal", :first_name => "Jeff", :last_name => "Beal")
u1.rating = rand * 100
u1.save!

t1 = Topic.create(:private => FALSE, :lone_wolf => FALSE)
p1 = Post.create(:parent_id => nil, :topic_id => t1, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1)
p1.points = rand * 1000
p1.views = rand * 1000
p1.save!
t1.root_id = p1
t1.save!
p2 = Post.create(:parent_id => p1, :topic_id => t1, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1)
p2.points = rand * 1000
p2.views = rand * 1000
p2.save!
