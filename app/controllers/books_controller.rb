class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end
  def new
  end
  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       redirect_to book_path(@book.id), notice: 'You have created book successfully.'
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end
  def edit
    @book = Book.find(params[:id])
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "You have deleted book successfully."
  end

  private

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    if current_user != @user
      redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
