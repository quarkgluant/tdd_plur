require 'rails_helper'

feature 'achievement page' do
  scenario 'achievement public page' do
    achievement = FactoryBot.create(:achievement, title: 'Just did it')
    visit("/achievements/#{achievement.id}")

    expect(page).to have_content('Just did it')

    # achievements = FactoryBot.create_list(:achievement, 3)
    # p achievements
  end

  scenario 'render markdown description' do
    achievement = FactoryBot.create(:public_achievement, description: 'That *was* hard')
    visit("/achievements/#{achievement.id}")

    expect(page).to have_content('<em>was</em>')
  end
end