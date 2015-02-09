class WotReplaysController < ApplicationController
  def index
    @wot_replays = WotReplay.all
    map_chart_data = MapChartPresenter.new(wot_replays: @wot_replays)
    @map_chart = LazyHighCharts::HighChart.new('map-chart') do |f|
      f.title(I18n.translate('map_chart_title', default: 'Map Dispersion'))
      f.xAxis(categories: map_chart_data.categories)
      map_chart_data.series.each do |serie|
        f.series(serie)
      end
      f.yAxis(min: 0,
        stackLabels: {
          enabled: true,
          style: {
            fontWeight: 'bold',
            color: 'gray'
          }
        })
      f.plotOptions(
        column: {
          stacking: 'normal',
          dataLabels: {
            enabled: true,
            color: 'white'
          }
        }
      )
    end
  end

  def new
    @wot_replay = WotReplay.new
  end

  def create
    @wot_replay = WotReplay.create!(wot_replay_params)
    redirect_to wot_replays_path
  end

  def show
    @wot_replay = WotReplay.find(params[:id])
    send_file @wot_replay.replay.path
  end

  private
  def wot_replay_params
    params.require(:wot_replay).permit(:replay)
  end
end
