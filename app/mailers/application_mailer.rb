# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@app.com"
  layout "mailer"
end
