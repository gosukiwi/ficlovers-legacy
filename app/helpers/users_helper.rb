module UsersHelper
  def gravatar_for(user, options = {})
    options = { html: true, class: 'gravatar', size: 80, default: :retro, rating: :g }.merge(options)
    email = user.email
    hash = Digest::MD5.hexdigest(email)
    protocol = request.ssl? ? 'https' : 'http'
    url = "#{protocol}://www.gravatar.com/avatar/#{hash}?s=#{options[:size]}&d=#{options[:default]}&r=#{options[:rating]}"
    if options[:html]
      "<img src=\"#{url}\" alt=\"#{user.name}\" class=\"#{options[:class]}\" />"
    else
      url
    end
  end
end
