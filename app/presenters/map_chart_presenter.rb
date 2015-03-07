class MapChartPresenter
  include Virtus.model

  attribute :wot_replays, Array, default: []

  def categories
    map_table.values
  end

  def series
    map_table.keys.map do |map|
      serie = ChartSerie.new(attribute: :map).for(map,
        as: I18n.t("maps.#{map}")).with(wot_replays)
      Hash.try_convert(serie)
    end
  end

  private

  def map_table
    locale       = I18n.locale
    file_name    = Rails.root.join('config', 'locales', "#{locale}.yml")
    file_content = File.read(file_name)
    hash         = YAML.load(file_content).with_indifferent_access
    hash[locale][:maps]
  end
end
