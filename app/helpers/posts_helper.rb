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
        "Opinions (#{post.children_opinions} / #{post.offspring_opinions}), Comments (#{post.children_comments} / #{post.offspring_comments}), "
      when Post::OPINION
        "Objections (#{post.children_opinions} / #{post.offspring_opinions}), Comments (#{post.children_comments} / #{post.offspring_comments}), "
    end
  end

  def level(post)
    case post.kind
      when Post::OPINION
        "Level = #{post.level},"
    end
  end

end
