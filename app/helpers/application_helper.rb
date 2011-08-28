module ApplicationHelper

	def markdown(text)  
		options = [:hard_wrap, :filter_html, :autolink, 
		      		 :no_intraemphasis, :fenced_code, :gh_blockcode]
		Redcarpet.new(text, *options).to_html.html_safe  
  end

	def flash_div(name, msg)
		content_tag :div, link_to("x", "#", :class => :close) + msg, :class => "alert-message #{name}"
	end

end
