class StaticPagesController < ApplicationController
  def home
  	if signed_in?
      @status = current_user.statuses.build
      @feed_items = current_user.feed.page(params[:page]).per(10)
    end
  end

  def help
  end

  def about
  end
end
