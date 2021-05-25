class UsersController < ApplicationController
  before_action :forbid_login_user, {only: [:top]}

  def index

    @book = Book.new
    @users = User.all
    @user = current_user
  end
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
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
  def create
    @user = User.new(name: params[:name])
    @user.save
    redirect_to("books/index")
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
  def correct_user
    @user = User.find(params[:id])
    if current_user != @user
       redirect_to user_path(current_user.id)
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end