class WotReplay < ActiveRecord::Base
  FILE_NAME_PATTERN = /(?<year>\d{4})(?<month>\d{2})(?<day>\d{2})_(?<hour>\d{2})(?<minute>\d{2})_(?<country>\w+)\-(?<tank>.*)_(?<count>\d+)_(?<map>\w+).*wotreplay$/

  has_attached_file :replay_file
  validates_attachment_file_name :replay_file, matches: FILE_NAME_PATTERN
  do_not_validate_attachment_file_type :replay_file

  attr_reader :plain_meta_data

  after_initialize :parse_meta_data_from_file_name

  def tank
    translate_plain_data(:tank)
  end

  def map
    translate_plain_data(:map)
  end

  def country
    plain_meta_data[:country].humanize
  end

  def time
    DateTime.new(plain_meta_data[:year].to_i,
                 plain_meta_data[:month].to_i,
                 plain_meta_data[:day].to_i,
                 plain_meta_data[:hour].to_i,
                 plain_meta_data[:minute].to_i)
  end

  private
  def translate_plain_data(value_name)
    plain_name = plain_meta_data[value_name]
    I18n.t("#{value_name.to_s.pluralize}.#{plain_name.downcase}",
           default: plain_name)
  end

  def parse_meta_data_from_file_name
    basename         = File.basename(replay_file_file_name.to_s)
    @plain_meta_data = basename.match(FILE_NAME_PATTERN)

    @plain_meta_data.present?
  end
end
