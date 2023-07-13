class NovelsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  def index
    @novels = Novel.all
  end

  def show
    @novel = Novel.find(params[:id])
  end

  def new
    @novel = Novel.new
  end

  def create
    @novel = current_user.novels.new(novel_params)

    if @novel.save
      flash[:notice] = "小説の共有が完了しました！"
      redirect_to novels_path
    else
      flash.now[:alert] = "小説の共有に失敗しました。再度入力をお願いします。"
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    if task.update(task_params)
      flash[:notice] = "小説の情報を更新しました！"
      redirect_to root
    else
      flash[:alert] = "小説情報の更新ができませんでした。再度入力をお願いします。"
      render :edit
    end
  end

  private

  def novel_params
    params.require(:novel).permit(:novel_name, :category, :impression, :author)
  end
end
