class CreateAchievement
  attr_reader :achievement

  def initialize(params, user)
    @achievement = Achievement.new(achievement_params)
    @achievement.user = user
  end

  def create
    @achievement.save
  end

  def created?
  end

  def achievement_params
    params.require(:achievement).permit(:title, :description, :privacy, :featured, :cover_image)
  end
end