class ListsController < ApplicationController
  before_action :set_list, only: [:show]
  # before_action :set_movies, only: [:show]

  def index
    @lists = List.all
  end

  def show
  end

  # def set_movies
  #   @movies = Movie.find(params[:id])
  # end

  def new
    @list = List.new
    # @bookmark = Bookmark.find(params[:bookmark_id])
  end

  def create
    @list = List.new(list_params)
    # @list.bookmark = @bookmark

    if @list.save
      # redirect_to bookmark_path(@bookmark)
      redirect_to new_list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
