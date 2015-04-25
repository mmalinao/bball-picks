require 'rails_helper'

RSpec.describe Admin::SeriesController, type: :controller do
  before(:each) { login_user user }

  describe 'POST #refresh' do
    subject(:do_post) { post :refresh }

    let(:user) { FactoryGirl.create(:user, :regular) }
    let!(:series) { FactoryGirl.create(:series) }

    before(:each) { allow(Series).to receive(:refresh) }

    it 'should not refresh series and game schedules' do
      expect(Series).to_not receive(:refresh)
      do_post
    end

    it 'should redirect to series index page' do
      do_post
      expect(response).to redirect_to admin_series_index_path
    end

    context 'when user is admin' do
      let(:user) { FactoryGirl.create(:user, :admin) }

      it 'should refresh series and game schedules' do
        expect(Series).to receive(:refresh)
        do_post
      end

      it 'should set flash notice' do
        do_post
        expect(flash[:notice]).to eq 'Refreshed series and game schedules'
      end
    end
  end
end
