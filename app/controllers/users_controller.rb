class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @user = current_user
    @users = User.page(params[:page]).reverse_order
    @book = Book.new
  end

  def show
    #@user = current_user
    @user = User.find(params[:id])
    #@post_images = @user.post_images.page(params[:page]).reverse_order
    @book = Book.new
    #binding.pry
  end

  def edit
    #@user = current_user
    if params[:id].to_i == current_user.id
      @user = User.find(params[:id])
    else
      @user = current_user
      @book = Book.new
      redirect_to user_path(current_user.id), notice: 'You cant edit other user'
    end
  end

  def update
    #@user = current_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'You have updated user successfully.'
    else
      render :edit, alert: 'You have updated user error.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
