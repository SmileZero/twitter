class StatusesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    @maxpage = current_user.feed.count
    sub = @maxpage - params[:maxpage].to_i
    @feed_items = current_user.feed.offset(params[:begin].to_i+sub).limit(6)
    @maxpage = current_user.feed.count
    @status = Status.new
    respond_to do |format|
      format.js
      format.json { render json: @feed_items }
    end
  end

  def create
  	@status = current_user.statuses.build(status_params)
    if @status.save
      flash[:success] = "Status created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.page(params[:page]).per(10)
      render 'static_pages/home'
    end
  end

  def destroy
    @status.destroy
    redirect_to root_url
  end

private

  def status_params
	 params.require(:status).permit(:content,:in_reply_to, :image)
  end
  def correct_user
    @status = current_user.statuses.find_by(id: params[:id])
    redirect_to root_url if @status.nil?
  end
end
