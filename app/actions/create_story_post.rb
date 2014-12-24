# Create a post for a story
class CreateStoryPost
  def initialize(story)
    @story = story
  end

  def run
    return unless @story.post.nil?

    post = Post.create({
      title: @story.title,
      content: "Discuss \"#{@story.title}\" below. Please be respectful and remember to provide constructive feedback.",
      user: @story.user,
      forum: Forum.find_or_create_by(name: 'Fic Discussion')
    })
    @story.post = post
    @story.save
  end
end
