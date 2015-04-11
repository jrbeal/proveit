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
end

Topic.delete_all
User.delete_all
Post.delete_all

u1 = User.create(:user_name => "jrbeal", :first_name => "Jeff", :last_name => "Beal")
u2 = User.create(:user_name => "jsbeal", :first_name => "Justin", :last_name => "Beal")
u3 = User.create(:user_name => "agbeal", :first_name => "Glee", :last_name => "Beal")
u4 = User.create(:user_name => "mebeal", :first_name => "Merry", :last_name => "Beal")
t1 = Topic.create(:private => FALSE, :lone_wolf => FALSE)
p1 = Post.create(:parent_id => nil, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
t1.root_id = p1
t1.save!
p2 = Post.create(:parent_id => p1.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p3 = Post.create(:parent_id => p1.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p4 = Post.create(:parent_id => p2.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p5 = Post.create(:parent_id => p2.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p6 = Post.create(:parent_id => p3.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p7 = Post.create(:parent_id => p3.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p8 = Post.create(:parent_id => p4.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p9 = Post.create(:parent_id => p4.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p10 = Post.create(:parent_id => p4.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p11 = Post.create(:parent_id => p6.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p12 = Post.create(:parent_id => p7.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p13 = Post.create(:parent_id => p7.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p14 = Post.create(:parent_id => p7.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p15 = Post.create(:parent_id => p8.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p16 = Post.create(:parent_id => p10.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p17 = Post.create(:parent_id => p10.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p18 = Post.create(:parent_id => p11.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p19 = Post.create(:parent_id => p11.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p20 = Post.create(:parent_id => p11.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p21 = Post.create(:parent_id => p11.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p22 = Post.create(:parent_id => p14.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p23 = Post.create(:parent_id => p14.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p24 = Post.create(:parent_id => p16.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p25 = Post.create(:parent_id => p19.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p26 = Post.create(:parent_id => p22.id, :topic_id => t1.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
c1 = Post.create(:parent_id => p6.id, :topic_id => t1.id, :kind => "comment", :message => "#{Constants::cctr}", :user_id => u1.id)
c2 = Post.create(:parent_id => p15.id, :topic_id => t1.id, :kind => "comment", :message => "#{Constants::cctr}", :user_id => u1.id)
c3 = Post.create(:parent_id => c2.id, :topic_id => t1.id, :kind => "comment", :message => "#{Constants::cctr}", :user_id => u1.id)
c4 = Post.create(:parent_id => c2.id, :topic_id => t1.id, :kind => "comment", :message => "#{Constants::cctr}", :user_id => u1.id)
c5 = Post.create(:parent_id => c3.id, :topic_id => t1.id, :kind => "comment", :message => "#{Constants::cctr}", :user_id => u1.id)
c6 = Post.create(:parent_id => p1.id, :topic_id => t1.id, :kind => "comment", :message => "#{Constants::cctr}", :user_id => u1.id)

t2 = Topic.create(:private => TRUE, :public_viewing => TRUE, :public_comments => TRUE)
i1 = Post.create(:parent_id => nil, :topic_id => t2.id, :kind => "initiator", :message => "#{Constants::ictr}", :user_id => u1.id)
t2.root_id = i1
t2.save!
p27 = Post.create(:parent_id => i1.id, :topic_id => t2.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
c7 = Post.create(:parent_id => i1.id, :topic_id => t2.id, :kind => "comment", :message => "#{Constants::cctr}", :user_id => u1.id)
p28 = Post.create(:parent_id => p27.id, :topic_id => t2.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
p29 = Post.create(:parent_id => p27.id, :topic_id => t2.id, :kind => "opinion", :message => "#{Constants::pctr}", :user_id => u1.id)
c8 = Post.create(:parent_id => p27.id, :topic_id => t2.id, :kind => "comment", :message => "#{Constants::cctr}", :user_id => u1.id)
