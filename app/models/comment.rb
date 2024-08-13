# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :article

  # Sempre inclui user e article nas consultas
  default_scope { includes(:user, :article) }
end
