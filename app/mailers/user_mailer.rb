class UserMailer < ApplicationMailer
  def review_email(bar)
    @creator = bar.user
    @bar = bar
    @url = "boston-bar-review.herokuapp.com/bars/#{@bar.id}"
    mail(to: @creator.email, subject: 'New Review!')
  end
end
