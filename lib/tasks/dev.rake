# frozen_string_literal: true

namespace :dev do
  desc "Reset the database"
  task reset: :environment do
    show_spinner("Resetting database...") do
      system("rails db:drop")
      system("rails db:create")
      system("rails db:migrate")
      system("rails db:seed")
      system("rails dev:clear_storage_folder")
      system("rails dev:add_categories")
      system("rails dev:add_authors")
      system("rails dev:add_articles")
      system("rails dev:add_users")
      system("rails dev:add_comments")
    end
  end

  def show_spinner(msg_start, msg_end = "Done!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end

  desc "Add categories to the database"
  task add_categories: :environment do
    show_spinner("Adding categories to the database") { add_categories }
  end

  desc "Add authors to the database"
  task add_authors: :environment do
    show_spinner("Adding authors to the database") { add_authors }
  end

  desc "Add articles to the database"
  task add_articles: :environment do
    show_spinner("Adding articles to the database") { add_articles }
  end

  desc "Clear storage"
  task clear_storage_folder: :environment do
    show_spinner("Cleaning up storage folder") { clear_storage }
  end

  desc "Add users to the database"
  task add_users: :environment do
    show_spinner("Adding users to the database") { add_users }
  end

  desc "Add comments to the database"
  task add_comments: :environment do
    show_spinner("Adding comments to the database") { add_comments }
  end

  def add_categories
    ["Ruby", "Rails", "WSL", "Linux", "DevOps", "Cloud", "Marketing", "Backend"].each do |name|
      category = Category.create!(
        name: name,
        description: Faker::Lorem.paragraph(sentence_count: rand(2..5)),
      )

      image_id = rand(1..8)

      category.cover_image.attach(
        io: File.open(Rails.root.join("lib/tasks/images/categories/category#{image_id}.jpg")),
        filename: "category_#{image_id}.jpg",
      )
    end
  end

  def add_authors
    5.times do
      author = Author.create!(
        name: Faker::Name.name,
        description: Faker::Lorem.paragraph(sentence_count: rand(15..30)),
        facebook_profile_url: Faker::Internet.url(host: "facebook.com"),
        instagram_profile_url: Faker::Internet.url(host: "instagram.com"),
        twitter_profile_url: Faker::Internet.url(host: "twitter.com"),
        linkedin_profile_url: Faker::Internet.url(host: "linkedin.com"),
        youtube_profile_url: Faker::Internet.url(host: "youtube.com"),
      )

      image_id = rand(1..3)

      author.avatar_image.attach(
        io: File.open(Rails.root.join("lib/tasks/images/avatar-#{image_id}.png")),
        filename: "avatar_#{image_id}.png",
      )
    end
  end

  def add_articles
    50.times do
      article = Article.create(
        title: Faker::Lorem.sentence.delete("."),
        body: Faker::Lorem.paragraph(sentence_count: rand(100..200)),
        category: Category.all.sample,
        author: Author.all.sample,
        created_at: Faker::Date.between(from: 1.year.ago, to: Date.current),
      )

      image_id = rand(1..5)

      # article.cover_image.attach(
      #   io: File.open(Rails.root.join("lib/tasks/images/article_#{image_id}.jpg")),
      #   filename: "article_#{image_id}.jpg",
      # )

      article.cover_image.attach(
        io: File.open(Rails.root.join("lib/tasks/images/full-hd/0#{image_id}.jpg")),
        filename: "article_0#{image_id}.jpg",
      )
    end
  end

  def clear_storage
    storage_directory = Rails.root.join("storage")

    if Dir.exist?(storage_directory)
      Dir.foreach(storage_directory) do |item|
        next if item == "." || item == ".." || item == ".keep"

        file_path = File.join(storage_directory, item)
        if File.file?(file_path)
          File.delete(file_path)
        elsif File.directory?(file_path)
          FileUtils.rm_rf(file_path)
        end
      end
    end
  end

  def add_users
    30.times do
      User.create(
        email: Faker::Internet.email,
        password: ENV["DEFAULT_PASSWORD"],
        password_confirmation: ENV["DEFAULT_PASSWORD"],
      )
    end
  end

  def add_comments
    100.times do
      Comment.create(
        user: User.all.sample,
        article: Article.all.sample,
        body: Faker::Lorem.paragraph(sentence_count: rand(3..10)),
        created_at: Faker::Date.between(from: 1.year.ago, to: Date.current),
      )
    end
  end
end
