class UsersController < ApplicationController
  before_action :forbid_login_user, {only: [:top]}

  def index
    @users = User.all
    @book_new = Book.new
    @user = current_user
  end
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book_new = Book.new
  end
  def edit
    @user = User.find(params[:id])
    if @user == current_user
    else
      redirect_to user_path(current_user.id)
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end
  private

  def autheniticate_user
    if @current_user.nil?
      redirect_to books_path
    end
  end

  def forbid_login_user
    if @current_user
      redirect_to edit_user_path(@user)
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end