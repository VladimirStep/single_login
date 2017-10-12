class WebsitesController < ApplicationController
  before_action :set_website, only: [:show, :edit, :update, :destroy]

  def index
    @websites = current_user.websites
  end

  def new
    @website = Website.new
  end

  def create
    @website = current_user.websites.build(website_params)
    if @website.save
      redirect_to websites_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_website
    @website = current_user.websites.find(params[:id])
  end

  def website_params
    params.require(:website).permit(:name, :domain_name)
  end
end
