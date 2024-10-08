# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create default admin users
# %w(admin@admin.com test@test.com) = ["admin@admin.com", "test@test.com"]
admins = {
  "admin@admin.com" => "Administrador",
  "test@test.com" => "Teste",
}

admins.each do |email, name|
  next if Admin.find_by(email: email)

  Admin.create!(
    # name: name == name:
    name:,
    email: email,
    password: ENV["DEFAULT_PASSWORD"],
    password_confirmation: ENV["DEFAULT_PASSWORD"],
  )
end

User.find_or_create_by(email: "user@user.com") do |user|
  user.email = "user@user.com"
  user.password = ENV["DEFAULT_PASSWORD"]
  user.password_confirmation = ENV["DEFAULT_PASSWORD"]
end
