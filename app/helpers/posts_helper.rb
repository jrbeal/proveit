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
        "Replies (#{post.children_comments} / #{post.offspring_comments}), "
      when Post::INITIATOR
        "Opinions (#{post.children_opinions} / #{post.offspring_opinions}), &nbsp Comments (#{post.children_comments} / #{post.offspring_comments}), ".html_safe
      when Post::OPINION
        "Objections (#{post.children_opinions} / #{post.offspring_opinions}), &nbsp Comments (#{post.children_comments} / #{post.offspring_comments}), ".html_safe
    end
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
        #{radio_button_tag('kidtype', 'initiator', true)}
        #{label_tag('kidtype', 'Opinions')}
        #{radio_button_tag('kidtype', 'comment')}
        #{label_tag('kidtype', 'Comments')}
        ")
      when Post::OPINION
        raw ("
				#{radio_button_tag 'kidtype', 'opinion', true}
        #{label_tag 'kidtype', 'Objections'}
        #{radio_button_tag 'kidtype', 'comment'}
        #{label_tag 'kidtype', 'Comments'}
        ")
    end
  end
end
