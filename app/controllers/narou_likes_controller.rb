class NarouLikesController < ApplicationController
  def create
    @narou = Narou.find(params[:narou_id])
    current_user.narou_like(@narou)
  end

  def destroy
    @narou = current_user.narou_like_narous.find(params[:id])
    current_user.narou_unlike(@narou)
    respond_to do |format|
      format.html { redirect_to profile_path }
      format.js { render 'narou_likes/destroy.js.erb' }
    end
  end
end
