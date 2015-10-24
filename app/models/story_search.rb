class StorySearch
  # Searches a story which includse all of the given tags. If category is
  # specified, it will only return stories in that given category.
  #
  # `tags` is a string of comma separated tags
  # `category` is optional and it's the id of the category to filter by, user 0
  # or nil to ignore category
  def self.search(tags:, language: :english, category: 0, order: 'popular')
    return Story.none if tags.nil?

    query = Story
      .joins('JOIN `taxonomies` ON `taxonomies`.`story_id` = `stories`.id')
      .joins('JOIN `tags` ON `taxonomies`.tag_id = `tags`.id AND `tags`.status = "active"')

    query = query.where(category_id: category) unless category.to_i == 0
    query = query.where(language: language)

    query = case order 
    when 'favs'
      query
        .select('`stories`.*, count(`favs`.id) as favs_count')
        .joins('LEFT JOIN `favs` ON `favs`.story_id = `stories`.id')
        .order('favs_count DESC, stories.views DESC')
    when 'popular'
      query.popular
    else
      query.fresh
    end

    having = parse_tags(tags)

    return query
      .group('stories.id')
      .having(having[:stmt], *having[:args])
      .includes([:category, :tags])
  end

  protected

    # returns a list of items such as: [['tag name', 'context'], ...]
    def self.split_tags(tags)
      tags.split(',').map do |tag|
        matches = tag.match(/^(.+?)(?:\((.+?)\))?$/).to_a
        next if matches[1].nil?
        [matches[1].strip!, matches[2]]
      end
    end

    # given a string of comma-separated tags, parse them into HAVING statements
    # joined by AND's, return an array with all the prepared statement's
    # parameters returns something which looks like
    # { stmt: 'COUNT(?) > 0 AND COUNT(?) > 0 ...', args: [arg1, arg2, ...] }
    def self.parse_tags(tags) 
      clauses = []
      args = []
      split_tags(tags).each do |tag|
        clauses << "SUM(`tags`.name = ?) > 0"
        args << tag[0]
      end

      return { stmt: clauses.join(' AND '), args: args }
    end
end
