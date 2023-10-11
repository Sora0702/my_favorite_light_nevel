class NarouLikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @narou = Narou.find(params[:narou_id])
    current_user.narou_like(@narou)
  end

  def destroy
    @narou = current_user.narou_like_narous.find(params[:id])
    current_user.narou_unlike(@narou)
  end
end
