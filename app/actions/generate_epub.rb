class GenerateEpub
  attr_reader :story, :url
  def initialize(story:, url:)
    @story = story
    @url   = url
  end

  def generate
    return file_path if already_generated
    generator = Epubber::Generator.new(book: book, working_dir: work_dir, filename: filename)
    generator.generate
  end

private

  def already_generated
    return false unless File.file?(file_path)
    return File.new(file_path).mtime > story.updated_at
  end

  def book
    book = Epubber::Models::Book.new
    book.title story.title
    book.author story.user.name
    book.description story.summary
    book.url url

    # Set introduction
    book.introduction do |i|
      i.content story.summary
    end

    # Set chapters
    story.chapters.each_with_index do |c, idx|
      book.chapters << build_chapter(chapter: c, index: idx)
    end

    book
  end

  def build_chapter(chapter:, index:)
    epub_chapter = Epubber::Models::Chapter.new
    epub_chapter.id index
    epub_chapter.title chapter.title
    epub_chapter.content chapter.content

    epub_chapter
  end

  def file_path
    "#{work_dir}/#{filename}".freeze
  end

  def work_dir
    "#{Rails.public_path}/epubs"
  end

  def filename
    "#{story.title}_#{story.id}.epub"
  end
end
