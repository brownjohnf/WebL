module ApplicationHelper

	def markdown(text)  
		options = [:hard_wrap, :filter_html, :autolink, 
		      		 :no_intraemphasis, :fenced_code, :gh_blockcode]
		syntax_highlighter(Redcarpet.new(text, *options).to_html).html_safe
  end

	def syntax_highlighter(html)  
    doc = Nokogiri::HTML(html)  
    doc.search("//pre[@lang]").each do |pre|  
			pre.replace CodeRay.scan(pre.text.rstrip, pre[:lang]).div(:css => :class)
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