class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]

  def index
    keywords = params[:search]
    keywords ||= ""
    #keywords = CGI::unescape(Base64.urlsafe_decode64(keywords))
    @kw_ret = keywords
    keywords = keywords.gsub(/(n['’]t\b)|\p{Punct}/, ' ').gsub(/\s/, "%")
    @users = User.where("name LIKE ?","%#{keywords}%").where("id != #{current_user.id}").page(params[:page]).per(10)
  end

  def show
  	@user = User.find(params[:id])
    @statuses = @user.statuses.page(params[:page]).per(10)
  end

  def new
  	@user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Twitter!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to edit_user_path @user
    else
      render 'edit'
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.page(params[:page]).per(10)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(10)
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :avatar)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
