class WotReplaysController < ApplicationController
  def index
    @wot_replays = WotReplay.all
  end

  def new
    @wot_replay = WotReplay.new
  end

  def create
    @wot_replay = WotReplay.create!(wot_replay_params)
    redirect_to wot_replays_path
  end

  private
  def wot_replay_params
    params.require(:wot_replay).permit(:replay_file)
  end
end
