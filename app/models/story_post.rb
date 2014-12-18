class StoryPost
  def initialize(story)
    @story = story
  end

  def create
    Post.create({
      title: @story.title,
      content: "Please discuss \"#{@story.title}\" below. Please be respectful and remember to provide constructive feedback.",
      user: @story.user,
      forum: Forum.find_or_create_by(name: 'Fic Discussion')
    })
  end
end
