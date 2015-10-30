class ForumFacade
  attr_reader :current, :page, :per_page
  def initialize(forum: NullForum.new, page: 1, per_page: 25)
    @current  = forum
    @page     = page
    @per_page = per_page
  end

  delegate :name, to: :current

  def forums
    Forum.all
  end

  def posts
    current.posts.sorted.paginate(page: page, per_page: per_page)
  end


  def latest_posts
    Post.latest.paginate(page: page, per_page: per_page)
  end
end
