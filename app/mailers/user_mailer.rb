class UserMailer < ApplicationMailer
  def review_email(bar)
    @creator = bar.user
    @bar = bar
    @url = "http://localhost:3000/bars/#{@bar.id}"
    mail(to: @creator.email, subject: 'New Review!')
  end
end
