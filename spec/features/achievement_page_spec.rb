require 'rails_helper'

feature 'achievement page' do
  scenario 'achievement public page' do
    achievement = FactoryBot.create(:achievement, title: 'Just did it')
    visit("/achievements_steps/#{achievement.id}")

    expect(page).to have_content('Just did it')

    # achievements_steps = FactoryBot.create_list(:achievement, 3)
    # p achievements_steps
  end

  scenario 'render markdown description' do
    achievement = FactoryBot.create(:public_achievement, description: 'That *was* hard')
    visit("/achievements_steps/#{achievement.id}")

    expect(page).to have_css('em', text: 'was')
  end
end