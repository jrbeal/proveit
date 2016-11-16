module PostsHelper

	def status_color(post)
    case post.kind
      when Post::COMMENT
        "lightblue"
      when Post::INITIATOR
        "lightyellow"
      when Post::OPINION
        case post.status
          when Post::TRUE
            "lightgreen"
          when Post::FALSE
            "lightred"
        end
    end
  end

  def offspring(post)
    case post.kind
      when Post::COMMENT
        "Replies (#{post.children_comments}/#{post.offspring_comments}), "
      when Post::INITIATOR
        "Opinions (#{post.children_opinions}/#{post.offspring_opinions}), &nbsp Comments (#{post.children_comments}/#{post.offspring_comments}), ".html_safe
      when Post::OPINION
        "Objections (#{post.children_opinions}/#{post.offspring_opinions}), &nbsp Comments (#{post.children_comments}/#{post.offspring_comments}), ".html_safe
    end
  end

	def top(post)
		until post.parent == nil
			post = post.parent
		end
		return post
	end

  def level(post)
    case post.kind
      when Post::OPINION
				"Level = #{post.level},"
			when Post::COMMENT
				"Level = #{post.level},"
		end
  end

  def genpostbuttons(post)
    case post.kind
      when Post::INITIATOR
        raw ("
        #{radio_button_tag('kidtype', 'opinion', true, :data => {:commentrepliable => post.comment_repliable, :opinionrepliable => post.opinion_repliable})}
        #{label_tag('kidtype', 'Opinions')}
     		(#{post.children_opinions}/#{post.offspring_opinions})
 			  #{radio_button_tag('kidtype', 'comment', false, :data => {:commentrepliable => post.comment_repliable, :opinionrepliable => post.opinion_repliable})}
        #{label_tag('kidtype', 'Comments')}
        (#{post.children_comments}/#{post.offspring_comments})
 			  ")
      when Post::OPINION
        raw ("
				#{radio_button_tag('kidtype', 'opinion', true, :data => {:commentrepliable => post.comment_repliable, :opinionrepliable => post.opinion_repliable})}
        #{label_tag 'kidtype', 'Objections'}
				(#{post.children_opinions}/#{post.offspring_opinions})
        #{radio_button_tag('kidtype', 'comment', false, :data => {:commentrepliable => post.comment_repliable, :opinionrepliable => post.opinion_repliable})}
        #{label_tag 'kidtype', 'Comments'}
       	(#{post.children_comments}/#{post.offspring_comments})
				")
			when Post::COMMENT
				raw ("
				#{radio_button_tag('kidtype', 'comment', true, :data => {:commentrepliable => post.comment_repliable, :opinionrepliable => post.opinion_repliable})}
				#{label_tag 'kidtype', 'Comments'}
				(#{post.children_opinions}/#{post.offspring_opinions})
				")
		end
  end
end
