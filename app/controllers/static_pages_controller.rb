class StaticPagesController < ApplicationController
  def home
  	if signed_in?
      @status = current_user.statuses.build
      @feed_items = current_user.feed.limit(6)
      @maxpage = current_user.feed.count
    end
  end

  def help
  end

  def about
  end
end
