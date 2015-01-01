# Create a post for a story
class CreateStoryPost
  attr_reader :story
  def initialize(story)
    @story = story
  end

  def create
    return unless story.post.nil?
    set_post build_post
    story.save
  end

protected

  def story_title
    story.title
  end

  def build_post
    forum = Forum.find_or_create_by(name: 'Fic Discussion')
    message = "Discuss \"#{story_title}\" below. Please be respectful and remember to provide constructive feedback."
    Post.create({ title: story_title, content: message, user: story.user, forum: forum })
  end

  def set_post(post)
    story.post = post
    story.user.watch post
  end
end
