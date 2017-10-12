class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def new
    @profile = Profile.new
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to profile_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @profile.update_attributes(profile_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def destroy
    @profile.destroy
    redirect_to profile_path
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :gender, :birth_date, :street, :city, :country, :avatar)
  end
end
