class PostFacade
  attr_reader :current, :page, :per_page
  def initialize(post: nil, page: 1, per_page: 10)
    @current = post
  end

  delegate :forum  , to: :current
  delegate :title  , to: :current
  delegate :content, to: :current
  delegate :user   , to: :current
  delegate :pinned?, to: :current

  def replies
    current.replies.sorted.paginate(page: page, per_page: per_page)
  end

  def forums
    Forum.all
  end

  def new_reply
    @new_reply ||= Reply.new
  end
end
