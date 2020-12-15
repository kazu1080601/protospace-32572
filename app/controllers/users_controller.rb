class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    prototypes = Prototype.all
    @prototypes = prototypes.select do |x|
      x.user_id == @user.id
    end
  end

end
