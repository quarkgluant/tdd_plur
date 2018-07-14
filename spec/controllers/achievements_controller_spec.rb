require 'rails_helper'

describe AchievementsController do
  describe 'guest Achievement' do
    describe 'GET index' do
      let(:achievement) { instance_double(Achievement) }

      before do
        allow(Achievement).to receive(:get_public_achievements) { [achievement] }
      end

      it 'renders :index template' do
        get :index
        expect(response).to render_template(:index)
      end
      it 'assigns public achievements to template' do
        get :index
        expect(assigns(:achievements)).to eq([achievement])
      end
    end
  end

  describe 'authenticated Achievement' do
    let(:user) { instance_double(User) }
    before do
      allow(controller).to receive(:current_user) { user }
      allow(controller).to receive(:authenticate_user!) { true }
    end

    # describe "#create" do
    #   let(:http_params) do
    #     { achievement:
    #           { title: 'title' } }
    #   end
    #
    #   let(:achievement_params) { double(:model_params) }
    #
    #   before do
    #     AchievementsController::AchievementParams.stub(:build) { model_params }
    #   end
    #
    #   it 'creates a Achievement with strong stubbing' do
    #     Achievementscontroller::AchievementParams.stub(:build).
    #         with(
    #             http_params.merge(controller: 'Achievements', action: 'create').
    #                 with_indifferent_access) { model_params }
    #     Achievement.should_receive(:create).with(model_params)
    #     post :create, http_params
    #   end
    #
    #   it 'creates a Achievement with weak stubbing' do
    #     Achievement.should_receive(:create).with(model_params)
    #     post :create, http_params
    #   end
    # end
    
    describe 'POST create' do
      let(:create_achievement) { instance_double(CreateAchievement) }
      let(:http_params) do
        { achievement:
              { title: 'title' } }
      end

      let(:achievement_params) { double(:model_params) }

      before do
        AchievementsController::AchievementParams.stub(:build) { model_params }
      end
      it 'sends create message to CreateAchievement' do
        # CreateAchievement.new(params, Achievement).create
        expect(CreateAchievement).to receive(:new).with(achievement_params, user)
        expect(create_achievement).to receive(:create)
        post :create,  params: achievement_params
      end

    end
  end

end