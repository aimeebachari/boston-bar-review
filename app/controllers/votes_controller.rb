class VotesController < ApplicationController

  before_action :load_review_and_vote
  def up_vote
    update_vote!(1)
    redirect_to bar_path(params[:bar_id])

  end

  def down_vote
    update_vote!(-1)
    redirect_to bar_path(params[:bar_id])
  end

  private

  def load_review_and_vote
    @review = Review.find(params[:review_id])
    @user = current_user
    @vote = @review.votes.where(user: @user).first
  end

  def update_vote!(new_value)
    if @vote
      if @vote.value == new_value
        @vote.update(value: 0)
      else
        @vote.update(value: new_value)
      end
    else
      @vote = @user.votes.create(value: new_value, review: @review)
      @vote.save
    end
    @review.update_score!
    binding.pry
  end

end
