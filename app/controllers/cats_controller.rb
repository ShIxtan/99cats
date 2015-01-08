class CatsController < ApplicationController
  before_action :check_ownership, only: [:edit, :update]
  before_action :logged_in

  def index
    @cats = Cat.all

    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    @requests = @cat.cat_rental_requests
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id

    if @cat.save
      flash[:notice] = "Cat successfully created"
      redirect_to cat_url(@cat)
    else
      flash[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.update(params[:id], cat_params)

    if @cat.save
      flash[:notice] = "Cat successfully edited"
      redirect_to cat_url(@cat)
    else
      flash[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :birth_date, :sex, :color, :description)
  end

  def check_ownership
    if current_user.id != Cat.find(params[:id]).user_id
      redirect_to cats_url
    end
  end
end
