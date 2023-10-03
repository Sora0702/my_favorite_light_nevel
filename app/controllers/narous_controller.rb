class NarousController < ApplicationController
  require 'httpclient'
  require 'uri'

  def search
    @params = URI.encode_www_form_component(params[:keyword])
    if params[:keyword].present?
      client    = HTTPClient.new
      url       = "https://api.syosetu.com/novelapi/api/?out=json&word=#{@params}"
      response  = client.get(url)
      @narous = JSON.parse(response.body)
      @narou = Narou.new
    else
      flash.now[:alert] = "小説のタイトルを入力してください。"
      render :search
    end
  end

  def create
    narou_ncode = narou_params[:ncode]
    @narous = Narou.all
    @narou = Narou.new(narou_params)
    if @narou.save
      flash[:notice] = "web小説を登録しました。"
      redirect_to @narou
    else
      @narou = Narou.find_by(ncode: narou_ncode)
      redirect_to @narou
    end
  end

  def index
    if params[:keyword]
      @narous = Narou.narou_search(params[:keyword])
    else
      @narous = Narou.all
    end
  end

  def show
    @narou = Narou.find(params[:id])
    @narou_review = @narou.narou_reviews.new
    @narou_reviews = @narou.narou_reviews.order(created_at: :desc)
  end

  private

  def narou_params
    params.require(:narou).permit(:title, :writer, :ncode, :story, :biggenre)
  end
end
