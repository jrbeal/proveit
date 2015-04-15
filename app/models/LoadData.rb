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
u2 = User.create(:user_name => "jsbeal", :first_name => "Justin", :last_name => "Beal")
u2.rating = rand * 100
u2.save!
u3 = User.create(:user_name => "agbeal", :first_name => "Glee", :last_name => "Beal")
u3.rating = rand * 100
u3.save!
u4 = User.create(:user_name => "mebeal", :first_name => "Merry", :last_name => "Beal")
u4.rating = rand * 100
u4.save!

t1 = Topic.create(:private => FALSE, :lone_wolf => FALSE)
p1 = Post.create(:parent_id => nil, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p1.points = rand * 1000
p1.views = rand * 1000
p1.save!
t1.root_id = p1
t1.save!
p2 = Post.create(:parent_id => p1.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p2.points = rand * 1000
p2.views = rand * 1000
p2.save!
p3 = Post.create(:parent_id => p1.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p3.points = rand * 1000
p3.views = rand * 1000
p3.save!
p4 = Post.create(:parent_id => p2.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p4.points = rand * 1000
p4.views = rand * 1000
p4.save!
p5 = Post.create(:parent_id => p2.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p5.points = rand * 1000
p5.views = rand * 1000
p5.save!
p6 = Post.create(:parent_id => p3.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p6.points = rand * 1000
p6.views = rand * 1000
p6.save!
p7 = Post.create(:parent_id => p3.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p7.points = rand * 1000
p7.views = rand * 1000
p7.save!
p8 = Post.create(:parent_id => p4.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p8.points = rand * 1000
p8.views = rand * 1000
p8.save!
p9 = Post.create(:parent_id => p4.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p9.points = rand * 1000
p9.views = rand * 1000
p9.save!
p10 = Post.create(:parent_id => p4.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p10.points = rand * 1000
p10.views = rand * 1000
p10.save!
p11 = Post.create(:parent_id => p6.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p11.points = rand * 1000
p11.views = rand * 1000
p11.save!
p12 = Post.create(:parent_id => p7.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p12.points = rand * 1000
p12.views = rand * 1000
p12.save!
p13 = Post.create(:parent_id => p7.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p13.points = rand * 1000
p13.views = rand * 1000
p13.save!
p14 = Post.create(:parent_id => p7.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p14.points = rand * 1000
p14.views = rand * 1000
p14.save!
p15 = Post.create(:parent_id => p8.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p15.points = rand * 1000
p15.views = rand * 1000
p15.save!
p16 = Post.create(:parent_id => p10.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p16.points = rand * 1000
p16.views = rand * 1000
p16.save!
p17 = Post.create(:parent_id => p10.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p17.points = rand * 1000
p17.views = rand * 1000
p17.save!
p18 = Post.create(:parent_id => p11.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p18.points = rand * 1000
p18.views = rand * 1000
p18.save!
p19 = Post.create(:parent_id => p11.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p19.points = rand * 1000
p19.views = rand * 1000
p19.save!
p20 = Post.create(:parent_id => p11.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p20.points = rand * 1000
p20.views = rand * 1000
p20.save!
p21 = Post.create(:parent_id => p11.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p21.points = rand * 1000
p21.views = rand * 1000
p21.save!
p22 = Post.create(:parent_id => p14.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p22.points = rand * 1000
p22.views = rand * 1000
p22.save!
p23 = Post.create(:parent_id => p14.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p23.points = rand * 1000
p23.views = rand * 1000
p23.save!
p24 = Post.create(:parent_id => p16.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p24.points = rand * 1000
p24.views = rand * 1000
p24.save!
p25 = Post.create(:parent_id => p19.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p25.points = rand * 1000
p25.views = rand * 1000
p25.save!
p26 = Post.create(:parent_id => p22.id, :topic_id => t1.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p26.points = rand * 1000
p26.views = rand * 1000
p26.save!
c1 = Post.create(:parent_id => p6.id, :topic_id => t1.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c1.points = rand * 1000
c1.views = rand * 1000
c1.save!
c2 = Post.create(:parent_id => p15.id, :topic_id => t1.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c2.points = rand * 1000
c2.views = rand * 1000
c2.save!
c3 = Post.create(:parent_id => c2.id, :topic_id => t1.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c3.points = rand * 1000
c3.views = rand * 1000
c3.save!
c4 = Post.create(:parent_id => c2.id, :topic_id => t1.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c4.points = rand * 1000
c4.views = rand * 1000
c4.save!
c5 = Post.create(:parent_id => c3.id, :topic_id => t1.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c5.points = rand * 1000
c5.views = rand * 1000
c5.save!
c6 = Post.create(:parent_id => p1.id, :topic_id => t1.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c6.points = rand * 1000
c6.views = rand * 1000
c6.save!

t2 = Topic.create(:private => TRUE, :public_viewing => TRUE, :public_comments => TRUE)
i1 = Post.create(:parent_id => nil, :topic_id => t2.id, :kind => "initiator", :message => "Initiator i#{Constants::ictr}", :user_id => u1.id)
i1.points = rand * 1000
i1.views = rand * 1000
i1.save!
t2.root_id = i1
t2.save!
p27 = Post.create(:parent_id => i1.id, :topic_id => t2.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p27.points = rand * 1000
p27.views = rand * 1000
p27.save!
c7 = Post.create(:parent_id => i1.id, :topic_id => t2.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c7.points = rand * 1000
c7.views = rand * 1000
c7.save!
p28 = Post.create(:parent_id => p27.id, :topic_id => t2.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p28.points = rand * 1000
p28.views = rand * 1000
p28.save!
p29 = Post.create(:parent_id => p27.id, :topic_id => t2.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p29.points = rand * 1000
p29.views = rand * 1000
p29.save!
c8 = Post.create(:parent_id => p27.id, :topic_id => t2.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c8.points = rand * 1000
c8.views = rand * 1000
c8.save!

t3 = Topic.create(:private => FALSE, :lone_wolf => FALSE)
c9 = Post.create(:parent_id => nil, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c9.points = rand * 1000
c9.views = rand * 1000
c9.save!
t3.root_id = c9
t3.save!
c10 = Post.create(:parent_id => c9.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c10.points = rand * 1000
c10.views = rand * 1000
c10.save!
c11 = Post.create(:parent_id => c9.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c11.points = rand * 1000
c11.views = rand * 1000
c11.save!
c12 = Post.create(:parent_id => c9.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c12.points = rand * 1000
c12.views = rand * 1000
c12.save!
c13 = Post.create(:parent_id => c11.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c13.points = rand * 1000
c13.views = rand * 1000
c13.save!
c14 = Post.create(:parent_id => c11.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c14.points = rand * 1000
c14.views = rand * 1000
c14.save!
c15 = Post.create(:parent_id => c11.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c15.points = rand * 1000
c15.views = rand * 1000
c15.save!
c16 = Post.create(:parent_id => c14.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c16.points = rand * 1000
c16.views = rand * 1000
c16.save!
c17 = Post.create(:parent_id => c14.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c17.points = rand * 1000
c17.views = rand * 1000
c17.save!
c18 = Post.create(:parent_id => c14.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c18.points = rand * 1000
c18.views = rand * 1000
c18.save!
