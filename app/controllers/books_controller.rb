class BooksController < ApplicationController
  def index
    @user = current_user
    @book = Book.new
    @books = Book.page(params[:page]).reverse_order
  end

  def show
    @user = current_user
    @book = Book.find(params[:id])
    @new_book = Book.new
    @books = [@book]
  end

  def new
    @book = Book.new
  end

  def create
    @user = current_user

    params_hash = params.permit!.to_hash
    book_hash = params_hash["book"].symbolize_keys
    book_hash["user_id"] = @user.id
    @book = Book.new(book_hash)
    if @book.valid? && @book.save
      redirect_to book_path(@book.id), notice: 'You have created book successfully.'
    else
      flash.now[:alert] = 'You have created book error'
      #render 'users/show'
      @books = Book.page(params[:page]).reverse_order
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])

    if @book.user.id != current_user.id
      @user = current_user
      @books = Book.page(params[:page]).reverse_order
      redirect_to books_path, notice: 'You cant edit other users book'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: 'You have updated book successfully.'
    else
      render :edit, alert: 'You have updated book error.'
    end
  end

  def destroy
    @book = Book.find(params[:id])

    if @book.destroy
      redirect_to @book, notice: 'You have deleted book successfully.'
    else
      render :edit, alert: 'You have deleted book error.'
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :profile_image, :id).merge(user_id: current_user.id)
  end

end
