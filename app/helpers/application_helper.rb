module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = 'Emily\'s Edibles'
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def bootstrap_meta_tags
    [
        tag('meta', :name => 'viewport', :content => 'width=device-width, initial-scale=1.0')
    ].join("\n").html_safe
  end
end
