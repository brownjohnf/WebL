module ErrorMessagesHelper
  # Render error messages for the given objects. The :message and :header_message options are allowed.
  def error_messages_for(*objects)
    options = objects.extract_options!
    options[:header_message] ||= I18n.t(:"activerecord.errors.header", :default => "Invalid Fields")
    options[:message] ||= I18n.t(:"activerecord.errors.message", :default => "Correct the following errors and try again.")
    messages = objects.compact.map { |o| o.errors.full_messages }.flatten
    unless messages.empty?
      content_tag(:div, :class => "alert-message block-message error append-bottom") do
        list_items = messages.map { |msg| content_tag(:li, msg) }
        #content_tag(:h2, options[:header_message]) +
				content_tag(:a, "x", :href => '#', :class => :close) + 
				content_tag(:p, content_tag(:strong, options[:message])) + 
				content_tag(:ul, list_items.join.html_safe)
      end
    end
  end

  module FormBuilderAdditions
    def error_messages(options = {})
      @template.error_messages_for(@object, options)
    end
  end
end

ActionView::Helpers::FormBuilder.send(:include, ErrorMessagesHelper::FormBuilderAdditions)

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if instance.error_message.kind_of?(Array)
    %(<div class="error">#{html_tag}<span class="help-inline">&nbsp;
      #{instance.error_message.join(', ')}</span></div>).html_safe
  else
    %(<div class="error">#{html_tag}<span class="help-inline">&nbsp;
      #{instance.error_message}</span></div>).html_safe
  end
end