# frozen_string_literal: true

namespace :dev do
  def show_spinner(msg_start, msg_end = "Done!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end

  desc "Reset the database"
  task reset_database: :environment do
    show_spinner("Resetting database...") do
      system("rails db:drop")
      system("rails db:create")
      system("rails db:migrate")
      system("rails db:seed")
      system("rails dev:add_categories")
      system("rails dev:add_articles")
    end
  end

  desc "Reset articles database"
  task reset_articles: :environment do
    show_spinner("Resetting articles to the database...") do
      Article.destroy_all
    end
  end

  desc "Add categories to the database"
  task add_categories: :environment do
    show_spinner("Adding categories to the database...") do
      ["Ruby", "Ruby on Rails", "PHP", "Java", "Linux"].each do |name|
        Category.create(name: name)
      end
    end
  end

  desc "Add articles to the database"
  task add_articles: :environment do
    show_spinner("Adding articles to the database...") do
      50.times do
        article = Article.create(
          title: Faker::Lorem.sentence.delete("."),
          body: Faker::Lorem.paragraph(sentence_count: rand(100..200)),
          category: Category.all.sample
        )

        image_id = rand(1..3)
        article.cover_image.attach(
          io: File.open(Rails.root.join("lib/tasks/images/article_#{image_id}.jpg").to_s),
          filename: "article_#{image_id}.jpg",
        )
      end
    end
  end
end
