module StaticPagesHelper
  def formatted_title(title = "")
    title_body = "Pinterest Clone"
    if !title.empty?
      "#{title} | #{title_body}"
    else
      title_body
    end
  end
end
