module ApplicationHelper

	def markdown(text)  
		options = { :hard_wrap => true, 
		            :filter_html => true,  
		      		  :gh_blockcode => true,
		      		  :no_intraemphasis => true
		      		  }
		extensions = {:fenced_code_blocks => true,
		      		    :strikethrough => true}
		md = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(options),extensions)
		syntax_highlighter(md.render(text)).html_safe
  end

	def syntax_highlighter(html)  
    doc = Nokogiri::HTML(html)  
    doc.search("//pre/code[@class]").each do |code|  
			code.parent.replace CodeRay.scan(code.text.rstrip, code[:class]).div(:css => :class)
    end  
    doc.inner_html.to_s  
  end

	def flash_div(name, msg)
		content_tag :div, link_to("x", "#", :class => :close) + msg, :class => "alert-message #{name}"
	end

	def menu_item(name, link)
		if current_page? link
			content_tag(:li, link_to(name,link), :class => :active)
		else
			content_tag(:li, link_to(name,link))
		end
	end
end