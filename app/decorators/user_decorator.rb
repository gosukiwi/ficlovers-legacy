class UserDecorator < Draper::Decorator
  delegate_all

  def gravatar(options = {})
    options = { html: true, class: 'gravatar', size: 80, default: :retro, rating: :g }.merge(options)
    email = object.email
    hash = Digest::MD5.hexdigest(email)
    url = "//www.gravatar.com/avatar/#{hash}?s=#{options[:size]}&d=#{options[:default]}&r=#{options[:rating]}"
    if options[:html]
      "<img src=\"#{url}\" alt=\"#{object.name}\" class=\"#{options[:class]}\" />"
    else
      url
    end
  end
end
