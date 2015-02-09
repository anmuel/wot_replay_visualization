require 'rails_helper'

describe WotReplaysController do
  describe 'GET index' do
    before do
      get :index
    end

    it 'successfully renders the index html' do
      expect(response).to be_successful
      expect(response.content_type).to eq 'text/html'
      expect(response).to render_template 'index'
    end

    specify { expect(assigns(:wot_replays)).to be }
    specify { expect(assigns(:map_chart)).to be }
  end

  describe 'GET new' do
    before do
      get :new
    end

    it 'successfully renders the new html' do
      expect(response).to be_successful
      expect(response.content_type).to eq 'text/html'
      expect(response).to render_template 'new'
    end

    specify { expect(assigns(:wot_replay)).to be }
  end

  describe 'POST create' do
    require 'rack/test'
    let(:params) do
      {
        wot_replay: {
          replay: Rack::Test::UploadedFile.new(
            Rails.root.join('spec', 'fixtures',
              '20140622_0021_germany-RhB_Waffentrager_10_hills.wotreplay'))
        }
      }
    end

    it 'creates a new WotReplay' do
      expect {
        post :create, params
      }.to change(WotReplay, :count).by(1)
    end

    it 'redirects to the index and assigns wot_replay' do
      post :create, params
      expect(response).to redirect_to wot_replays_path
      expect(assigns(:wot_replay)).to be
    end
  end
end
