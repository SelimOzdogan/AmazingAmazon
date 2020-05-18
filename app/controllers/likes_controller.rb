class LikesController < ApplicationController
  def create
    review = Review.find params[:review_id]
    like = Like.new user: current_user, review: review
    if review.user == current_user 
        redirect_to review.product, alert: "can't like review"
    elsif like.save 
        redirect_to review.product, notice: "Liked"
    else 
        redirect_to review.product, alert: "Not Liked"
    end
  end

  def destroy
    like = Like.find params[:id]
    if can? :destroy, like 
        like.destroy 
        redirect_to like.review.product, notice: 'Like removed'
    else 
        redirect_to like.review.product, alert: "can't delete like"
    end  
  end
end
