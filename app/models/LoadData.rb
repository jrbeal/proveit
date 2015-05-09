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

u1 = User.create(:user_name => "jrbeal", :first_name => "Jeff", :last_name => "Beal", :email => "jrbeal@cox.net", :verbosity => 3)
u1.rating = rand * 100
u1.save!
u2 = User.create(:user_name => "jsbeal", :first_name => "Justin", :last_name => "Beal", :email => "Justin@gmail.com", :verbosity => 3)
u2.rating = rand * 100
u2.save!
u3 = User.create(:user_name => "agbeal", :first_name => "Glee", :last_name => "Beal", :email => "Glee@gmail.com", :verbosity => 3)
u3.rating = rand * 100
u3.save!
u4 = User.create(:user_name => "mebeal", :first_name => "Merry", :last_name => "Beal", :email => "Merry@gmail.com", :verbosity => 3)
u4.rating = rand * 100
u4.save!
u5 = User.create(:user_name => "trbeal", :first_name => "Thomas", :last_name => "Beal", :email => "Thomas@gmail.com", :verbosity => 3)
u5.rating = rand * 100
u5.save!
u6 = User.create(:user_name => "dmbeal", :first_name => "Diane", :last_name => "Beal", :email => "Diane@gmail.com", :verbosity => 3)
u6.rating = rand * 100
u6.save!
u7 = User.create(:user_name => "jabeal", :first_name => "Jenni", :last_name => "Beal", :email => "Jenni@gmail.com", :verbosity => 3)
u7.rating = rand * 100
u7.save!
u8 = User.create(:user_name => "jeremy", :first_name => "Jeremy", :last_name => "Beal", :email => "Jeremy@gmail.com", :verbosity => 3)
u8.rating = rand * 100
u8.save!

t1 = Topic.create(:private => FALSE, :lone_wolf => FALSE)
p1 = Post.create(:parent_id => nil, :topic_id => t1.id, :kind => "opinion", :message => "No major wage gap exists between equally qualified men and women working similar jobs.", :support => "Last week, the American Association of University Women (AAUW) released a study on the gender pay gap, the claim that women are paid less than equally-qualified men. The AAUW study limited itself to new college graduates, hoping to show that a pay gap exists even before women marry and bear children, which most academic studies find to be the main drivers of gender pay differences. The AAUW study generated the headline result – the only one that really matters – that new female college grads are paid only 82 cents for each dollar of male earnings. To its credit, AAUW went further by factoring in male/female differences in college major, hours worked, etc. Having done that, the pay gap shrinks to less than 7 percent. This indicates that, at most, discrimination lowers female wages by 7 percent. But in preparing for an NPR program discussing the study, I ran some quick numbers using data from the Census Bureau’s American Community Survey. I limited myself to full-year private sector workers with a bachelors degree who were ages 21 to 26 in 2009-2010. Within this group I controlled for age, race, Hispanic and immigrant status, detailed geographic location, weekly work hours, college major and occupation. Controlling for college major accounts for the fact that men tend to choose majors that lead to higher earnings later in life. Controlling for occupation captures “compensating wage differentials” for positive or negative aspects of the job. For instance, dangerous or unpleasant jobs may pay more, while jobs offering flexible hours or more generous benefits might pay less. Including all these controls, the gender pay gap for young college grads drops to around 1 percent. Even then, do my results mean that discrimination reduces pay by 1 percent? Hardly. It’s well known that women negotiate over pay less aggressively than men. Better negotiating tactics could easily generate a 1 percent pay difference. More broadly, the 1 percent figure denotes the unexplained pay difference – simply because the data we have can’t explain it doesn’t mean the difference is due to discrimination. Better data might explain even more of the difference. Moreover, even if discrimination exists – and it surely does, even if its overall effects aren’t huge – the cure of greater government control over the labor market might be worse than the disease. The real failure here isn’t with analysts, who long have shown common perceptions of the gender pay gap to be vastly exaggerated. This study from the Federal Reserve Bank of St. Louis summarizes why the pay gap may be smaller than we think. The fault lies mainly with the press, who irresponsibly assert massive gender pay discrimination that doesn’t truly exist.", :user_id => u1.id)
p1.save!
t1.root_id = p1
t1.save!
p2 = Post.create(:parent_id => p1.id, :topic_id => t1.id, :kind => "opinion", :message => "Your conclusion is based on cherry-picked data therefore incorrect. I suggest you start over and reword your opinion :).", :support => "Women are almost half of the workforce. They are the equal, if not main, breadwinner in four out of ten families. They receive more college and graduate degrees than men. Yet, on average, women continue to earn considerably less than men. In 2013, female full-time workers made only 78 cents for every dollar earned by men, a gender wage gap of 22 percent. Women, on average, earn less than men in virtually every single occupation for which there is sufficient earnings data for both men and women to calculate an earnings ratio. IWPR tracks the gender wage gap over time in a series of fact sheets updated twice per year. According to our research, if change continues at the same slow pace as it has done for the past fifty years, it will take 44 years—or until 2058—for women to finally reach pay parity. IWPR’s annual fact sheet on the gender wage gap by occupation shows that women earn less than men in almost any occupation. IWPR’s Status of Women in the States project tracks the gender wage gap across states. IWPR’s report on sex and race discrimination in the workplace shows that outright discrimination in pay, hiring, or promotions continues to be a significant feature of working life.", :user_id => u2.id)
p2.save!
p3 = Post.create(:parent_id => p1.id, :topic_id => t1.id, :kind => "opinion", :message => "Nice try, however, there is plenty of evidence (see links) to show otherwise. Which researcher is lying?", :support => "A study commissioned by the United States Department of Labor, concluded that 'There are observable differences in the attributes of men and women that account for most of the wage gap. Statistical analysis that includes those variables has produced results that collectively account for between 65.1 and 76.4 percent of a raw gender wage gap of 20.4 percent, and thereby leave an adjusted gender wage gap that is between 4.8 and 7.1 percent.' The study also concluded that while in principle more of the wage gap could be explained by differences between the groups, the data that would be needed to account for additional factors were not available.", :user_id => u8.id)
p3.save!
p4 = Post.create(:parent_id => p2.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u3.id)
p4.save!
p5 = Post.create(:parent_id => p2.id, :topic_id => t1.id, :kind => "opinion", :message => "Objection p#{Constants::pctr}", :user_id => u6.id)
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
i1 = Post.create(:parent_id => nil, :topic_id => t2.id, :kind => "initiator", :message => "Should it be legal for parents to withhold medical treatment for their children for religious reasons?", :support => "Issues surrounding parental denial of medical care for children in need has unexpectedly emerged as one of the most contentious issues in health law policy this year. Parents have cited religious reasons or personal preferences for alternative medical therapy as justification to refuse such treatment. Although the ability of a parent to consent to potentially life-saving medical therapy for a child is an established canon of family law, the outer boundaries of a parent’s right to refuse life-saving medical treatment for a child are ill-defined. The limits of parents’ refusal to allow life-saving medical care is currently being tested in two cases – one in Wisconsin and the other in Minnesota. Although the two cases differ significantly in the circumstances, venue, and medical outcomes, both cases raise the issue of when and how the state may intervene to save the life of a child over the express religious or medical beliefs, and conduct, of one or both parents.", :user_id => u1.id)
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
c9 = Post.create(:parent_id => nil, :topic_id => t3.id, :kind => "comment", :message => "Is there a point at which our national debt becomes unsustainable?", :support => "With an estimated national debt that will approach $20 trillion in just a couple of years, some $200 trillion in unfunded liabilities over the next twenty five years, scores of millions of Americans dependent on overburdened government safety nets to survive, and a rapidly shrinking domestic economy, the key question becomes,what is America’s economic breaking point?", :user_id => u1.id)
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

t4 = Topic.create(:private => FALSE, :lone_wolf => FALSE)
p30 = Post.create(:parent_id => nil, :topic_id => t4.id, :kind => "opinion", :message => "Nuclear power plants are dangerous and should be phased out.", :support => "Three primary reasons: 1) The potential for accidents stemming from human error, oversight, or malevolence, which could cause widespread and long lasting harm 2) The potential for accidents stemming from natural disasters, which could cause widespread and long lasting harm 3) Our inability to predict/control for future social, economic, and political instability, which could create conditions in which nuclear facilities are neglected or poorly regulated, thereby creating conditions that could lead to an increased likelihood of numbers 1 & 2", :user_id => u1.id)
p30.save!
t4.root_id = p30
t4.save!
