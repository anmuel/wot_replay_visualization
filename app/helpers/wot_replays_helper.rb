module WotReplaysHelper
  def country_code(country_name)
    {
        france: 'fr',
        germany: 'de',
        usa: 'us',
        ussr: 'ru',
        china: 'cn',
        japan: 'jp',
        uk: 'gb'
    }[country_name.downcase.to_sym] || country_name.downcase
  end
end
