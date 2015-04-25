require 'rails_helper'

RSpec.describe Admin::GamesController, type: :controller do
  before(:each) { login_user user }

  describe 'POST #refresh' do
    subject(:do_post) { post :refresh, id: game.to_param }

    let(:user) { FactoryGirl.create(:user, :regular) }
    let!(:game) { FactoryGirl.create(:game) }

    before(:each) { allow_any_instance_of(Game).to receive(:refresh_stats) }

    it 'should redirect to game page' do
      do_post
      expect(response).to redirect_to admin_game_path(game)
    end

    it 'should not refresh game stats' do
      expect_any_instance_of(Game).to_not receive(:refresh_stats)
      do_post
    end

    context 'when user admin' do
      let(:user) { FactoryGirl.create(:user, :admin) }

      it 'should refresh game stats' do
        expect_any_instance_of(Game).to receive(:refresh_stats)
        do_post
      end

      it 'should set flash notice' do
        do_post
        expect(flash[:notice]).to eq 'Refreshed game summary'
      end
    end

    # context 'when game closed' do
    #   let!(:game) { FactoryGirl.create(:game, :closed) }

    #   it 'should not refresh game stats' do
    #     expect_any_instance_of(Game).to_not receive(:refresh_stats)
    #     do_post
    #   end
    # end
  end
end
