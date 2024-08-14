# frozen_string_literal: true

module ArticlesHelper
  def render_cover_image(article)
    if article.cover_image.attached?
      image_tag(article.cover_image.variant(:thumb), class: "item-image", alt: "post 1")
    else
      image_tag("posts/post1.jpg", class: "item-image", alt: "post 1")
    end
  end

  def cover_image_fallback(article)
    article.cover_image.attached? ? article.cover_image : "posts/post1.jpg"
  end

  def markdown(md)
    Markdown.new(md).to_html.html_safe
  end
end
