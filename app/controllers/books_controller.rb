class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  def index
    @books = Book.all
    @book_new = Book.new
    @user = current_user
  end
  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end
  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      redirect_to book_path(@book_new.id), notice: 'You have created book successfully.'
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
      redirect_to book_path(book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end
  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to books_path, notice: "You have deleted book successfully."
    end
  end
  private

  def ensure_correct_user
    @book = Book.find(params[:id])
    if current_user.id != @book.user_id
      redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
