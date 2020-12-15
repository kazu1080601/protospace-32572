class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @prototypes = Prototype.all
  end
  
  def new
    @prototype = Prototype.new
  end

  def create
    prototype = Prototype.new(prototype_params)
    if user_signed_in? && prototype.save
      redirect_to root_path
    else
      @prototype = prototype
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    comments = Comment.all
    @comments = comments.select do |x|
      x.prototype_id == @prototype.id
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless (user_signed_in? && current_user.id) == @prototype.user_id
      redirect_to action: :index
    end
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    if (current_user.id == prototype.user.id) && prototype.update(prototype_params)
      redirect_to root_path
    else
      @prototype = prototype
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    if (current_user.id == prototype.user.id) && prototype.destroy
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end
