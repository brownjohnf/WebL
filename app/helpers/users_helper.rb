module UsersHelper

	def gravatar_for(user, options = { :size => 50, :default => 'mm' })     
    if user.gravatar_token
      return gravatar_token_tag(user.gravatar_token, 
                  :size => options[:size], 
                  :title => user.name,
                  :class => 'gravatar',
                  :alt => user.name)
    else
      return gravatar_image_tag(user.email.downcase, 
                  :alt => user.name,
                  :title => user.name,
                  :class => 'gravatar',
                  :gravatar => options)
    end
  end
  
  def gravatar_token_tag(token, options)
	  size = options.delete :size || 50
	  image_tag "http://www.gravatar.com/avatar/#{token}.png?s=#{size}", :title => options[:title], :class => :gravatar
	end
end
