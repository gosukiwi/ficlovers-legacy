class ForumFacade
  attr_reader :current_forum, :page, :per_page
  def initialize(forum: NullForum.new, page: 1, per_page: 25)
    @current_forum = forum
    @page          = page
    @per_page      = per_page
  end

  def forums
    Forum.all
  end

  def current_forum_posts
    current_forum.posts.sorted.paginate(page: page, per_page: per_page)
  end


  def latest_posts
    Post.latest.paginate(page: page, per_page: per_page)
  end
end
