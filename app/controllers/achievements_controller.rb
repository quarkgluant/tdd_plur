class AchievementsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :owners_only, only: [ :edit, :update, :destroy ]

  def index
    @achievements = Achievement.public_access
  end

  def new
    @achievement = Achievement.new
  end

  def create
    @achievement = Achievement.new(achievement_params)
    @achievement.user = current_user
    if @achievement.save
      redirect_to achievement_url(@achievement), notice: 'Achievement has been created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @achievement.update_attributes(achievement_params)
      redirect_to achievement_path(@achievement)
    else
      render :edit
    end
    # render nothing: true
  end

  def destroy
    @achievement.destroy
    # @achievement.delete
    redirect_to achievements_path
  end

  def show
    @achievement = Achievement.find(params[:id])
  end

  private

  def achievement_params
    params.require(:achievement).permit(:title, :description, :privacy, :featured, :cover_image)
  end

  def owners_only
    @achievement = Achievement.find(params[:id])
    if current_user != @achievement.user
      redirect_to achievements_path
    end
  end
end