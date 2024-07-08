# frozen_string_literal: true

namespace :dev do
  def show_spinner(msg_start, msg_end = "Done!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end

  desc "Reset the database"
  task reset: :environment do
    show_spinner("Resetting database...") do
      system("rails db:drop")
      system("rails db:create")
      system("rails db:migrate")
      system("rails db:seed")
      system("rails dev:add_categories")
      system("rails dev:add_articles")
    end
  end

  desc "Add categories to the database"
  task add_categories: :environment do
    show_spinner("Adding categories to the database") { add_categories }
  end

  desc "Add articles to the database"
  task add_articles: :environment do
    show_spinner("Adding articles to the database") { add_articles }
  end

  def add_categories
    ["Ruby", "Rails", "WSL", "Linux", "DevOps", "Cloud", "Marketing", "Backend"].each do |name|
      Category.create!(name: name)
      # category = Category.create!(
      #   name: name,
      #   description: Faker::Lorem.paragraph(sentence_count: rand(2..5)),
      # )

      # image_id = rand(1..8)

      # category.cover_image.attach(
      #   io: File.open(Rails.root.join("lib/tasks/images/category#{image_id}.jpg")),
      #   filename: "category_#{image_id}.jpg",
      # )
    end
  end

  def add_articles
    50.times do
      article = Article.create(
        title: Faker::Lorem.sentence.delete("."),
        body: Faker::Lorem.paragraph(sentence_count: rand(100..200)),
        category: Category.all.sample,
        created_at: Faker::Date.between(from: 1.year.ago, to: Date.current),
      )

      image_id = rand(1..3)

      article.cover_image.attach(
        io: File.open(Rails.root.join("lib/tasks/images/article_#{image_id}.jpg")),
        filename: "article_#{image_id}.jpg",
      )
    end
  end
end
