module Constants
  @@pctr = 1

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
u5 = User.create(:user_name => "trbeal", :first_name => "Thomas", :last_name => "Beal")
u5.rating = rand * 100
u5.save!
u6 = User.create(:user_name => "dmbeal", :first_name => "Diane", :last_name => "Beal")
u6.rating = rand * 100
u6.save!
u7 = User.create(:user_name => "jabeal", :first_name => "Jenni", :last_name => "Beal")
u7.rating = rand * 100
u7.save!

t1 = Topic.create(:private => FALSE, :lone_wolf => FALSE)
p1 = Post.create(:parent_id => nil, :topic_id => t1.id, :kind => "opinion", :message => "No major wage gap exists between equally qualified men and women working similar jobs.", :user_id => u1.id)
p1.save!
t1.root_id = p1
t1.save!
p2 = Post.create(:parent_id => p1.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p2.save!
p3 = Post.create(:parent_id => p1.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p3.save!
p4 = Post.create(:parent_id => p2.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p4.save!
p5 = Post.create(:parent_id => p2.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p5.save!
p6 = Post.create(:parent_id => p3.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p6.save!
p7 = Post.create(:parent_id => p3.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p7.save!
p8 = Post.create(:parent_id => p4.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p8.save!
p9 = Post.create(:parent_id => p4.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p9.save!
p10 = Post.create(:parent_id => p4.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p10.save!
p11 = Post.create(:parent_id => p6.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p11.save!
p12 = Post.create(:parent_id => p7.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p12.save!
p13 = Post.create(:parent_id => p7.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p13.save!
p14 = Post.create(:parent_id => p7.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p14.save!
p15 = Post.create(:parent_id => p8.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p15.save!
p16 = Post.create(:parent_id => p10.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p16.save!
p17 = Post.create(:parent_id => p10.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p17.save!
p18 = Post.create(:parent_id => p11.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p18.save!
p19 = Post.create(:parent_id => p11.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p19.save!
p20 = Post.create(:parent_id => p11.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p20.save!
p21 = Post.create(:parent_id => p11.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p21.save!
p22 = Post.create(:parent_id => p14.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p22.save!
p23 = Post.create(:parent_id => p14.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p23.save!
p24 = Post.create(:parent_id => p16.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p24.save!
p25 = Post.create(:parent_id => p19.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p25.save!
p26 = Post.create(:parent_id => p22.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p26.save!
c1 = Post.create(:parent_id => p6.id, :topic_id => t1.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c1.save!
c2 = Post.create(:parent_id => p15.id, :topic_id => t1.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c2.save!
c3 = Post.create(:parent_id => c2.id, :topic_id => t1.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c3.save!
c4 = Post.create(:parent_id => c2.id, :topic_id => t1.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c4.save!
c5 = Post.create(:parent_id => c3.id, :topic_id => t1.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c5.save!
c6 = Post.create(:parent_id => p1.id, :topic_id => t1.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c6.save!

t2 = Topic.create(:private => TRUE, :public_viewing => TRUE, :public_comments => TRUE)
i1 = Post.create(:parent_id => nil, :topic_id => t2.id, :kind => "initiator", :message => "Should it be legal for parents to withhold medical treatment for their children for religious reasons?", :user_id => u1.id)
i1.save!
t2.root_id = i1
t2.save!
p27 = Post.create(:parent_id => i1.id, :topic_id => t2.id, :kind => "opinion", :message => "Opinion p#{Constants::pctr}", :user_id => u1.id)
p27.save!
c7 = Post.create(:parent_id => i1.id, :topic_id => t2.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c7.save!
p28 = Post.create(:parent_id => p27.id, :topic_id => t2.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p28.save!
p29 = Post.create(:parent_id => p27.id, :topic_id => t2.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u1.id)
p29.save!
c8 = Post.create(:parent_id => p27.id, :topic_id => t2.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c8.save!

t3 = Topic.create(:private => FALSE, :lone_wolf => FALSE)
c9 = Post.create(:parent_id => nil, :topic_id => t3.id, :kind => "comment", :message => "Is there a breaking point for USA debt?", :user_id => u1.id)
c9.save!
t3.root_id = c9
t3.save!
c10 = Post.create(:parent_id => c9.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c10.save!
c11 = Post.create(:parent_id => c9.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c11.save!
c12 = Post.create(:parent_id => c9.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c12.save!
c13 = Post.create(:parent_id => c11.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c13.save!
c14 = Post.create(:parent_id => c11.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c14.save!
c15 = Post.create(:parent_id => c11.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c15.save!
c16 = Post.create(:parent_id => c14.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c16.save!
c17 = Post.create(:parent_id => c14.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c17.save!
c18 = Post.create(:parent_id => c14.id, :topic_id => t3.id, :kind => "comment", :message => "Comment c#{Constants::cctr}", :user_id => u1.id)
c18.save!
