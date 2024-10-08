# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable

  has_many :comments, dependent: :destroy

  after_create :send_welcome_email

  private

  def send_welcome_email
    # self = proprio objeto usuario
    UserMailer.with(user: self).welcome_email.deliver_now
  end
end
