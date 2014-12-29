# Create a post for a story
class CreateStoryPost
  def initialize(story)
    @story = story
  end

  def create
    return unless @story.post.nil?

    link = view_context.link_to @story.title, @story
    post = Post.create({
      title: @story.title,
      content: "Discuss \"#{link}\" below. Please be respectful and remember to provide constructive feedback.",
      user: @story.user,
      forum: Forum.find_or_create_by(name: 'Fic Discussion')
    })
    @story.post = post
    @story.user.watch post
    @story.save
  end
end
