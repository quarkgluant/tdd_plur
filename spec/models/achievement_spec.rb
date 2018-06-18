require 'rails_helper'

RSpec.describe Achievement, type: :model do
  describe 'validations' do
    it 'requires title' do
      achievement = Achievement.new(title: '')
      achievement.valid?
      expect(achievement.errors[:title]).to include("can't be blank")
      expect(achievement.errors[:title]).not_to be_empty
      expect(achievement.valid?).to be_falsy
    end

    it { should validate_presence_of(:title) } # identique au bloc ci-dessus

    it 'requires title to be unique for one user' do
      user = FactoryBot.create(:user)
      first_achievement = FactoryBot.create(:public_achievement, title: 'First Achievement', user: user)
      new_achievement = Achievement.new(title: 'First Achievement', user: user)
      expect(new_achievement.valid?).to be_falsy
    end

    it 'allows different users to have achievements with identical titles' do
      user1 =  FactoryBot.create(:user)
      user2 =  FactoryBot.create(:user)
      first_achievement = FactoryBot.create(:public_achievement, title: 'First Achievement', user: user1)
      new_achievement = Achievement.new(title: 'First Achievement', user: user2)
      expect(new_achievement.valid?).to be_truthy
    end

    it { should validate_uniqueness_of(:title).scoped_to(:user_id).with_message("you can't have two achievements with the same title") }
    # remplace les 2 blocs ci-dessus
    it { should validate_presence_of(:user) }
    # remplace le bloc it 'has belongs_to user association' ci-dessous
    it { should belong_to(:user) } #  remplace le bloc it 'belongs to user' ci-dessous
  end

  it 'belongs to user' do
    achievement = Achievement.new(title: 'some title', user: nil)
    expect(achievement.valid?).to be_falsy
  end

  it 'has belongs_to user association' do
    #   first approach
    user = FactoryBot.create(:user)
    achievement = Achievement.new(title: 'some title', user: user)
    expect(achievement.user).to eq(user)
    #   second approach
    u = Achievement.reflect_on_association(:user)
    expect(u.macro).to eq(:belongs_to)
  end

end
