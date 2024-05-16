# frozen_string_literal: true

module WelcomeHelper
  def cover_image_fallback(article)
    article.cover_image.attached? ? article.cover_image.variant(:thumb) : "posts/post1.jpg"
    # if article.cover_image.attached?
    #   image_tag(article.cover_image.variant(:thumb), class: "item-image", alt: "post 1")
    # else
    #   image_tag("posts/post1.jpg", class: "item-image", alt: "post 1")
    # end
  end
end
