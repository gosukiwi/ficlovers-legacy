module UsersHelper
  def gravatar_for(user, options = {})
    options  = default_options.merge(options)
    hash     = Digest::MD5.hexdigest(user.email)
    protocol = request.ssl? ? 'https' : 'http'
    url      = "#{protocol}://www.gravatar.com/avatar/#{hash}?s=#{options[:size]}&d=#{options[:default]}&r=#{options[:rating]}"

    if options[:html]
      "<img src=\"#{url}\" alt=\"#{user.name}\" class=\"#{options[:class]}\" />"
    else
      url
    end
  end

  private

  def default_options
    { 
      html:    true,
      class:   'gravatar',
      size:    80,
      default: :retro,
      rating:  :g 
    }
  end
end
