class WotReplay < ActiveRecord::Base
  FILE_NAME_PATTERN = /(?<year>\d{4})(?<month>\d{2})(?<day>\d{2})_(?<hour>\d{2})(?<minute>\d{2})_(?<country>\w+)\-(?<tank>.*)_(?<count>\d+)_(?<map>\w+).*wotreplay$/

  has_attached_file :replay
  validates_attachment_file_name :replay, matches: FILE_NAME_PATTERN
  do_not_validate_attachment_file_type :replay
  validates_presence_of :replay

  attr_reader :plain_meta_data

  after_initialize :parse_meta_data_from_file_name

  %i[ tank map country ].each do |attribute|
    define_method attribute do
      plain_meta_data[attribute]
    end
  end


  def time
    DateTime.new(plain_meta_data[:year].to_i,
                 plain_meta_data[:month].to_i,
                 plain_meta_data[:day].to_i,
                 plain_meta_data[:hour].to_i,
                 plain_meta_data[:minute].to_i)
  end

  private

  def parse_meta_data_from_file_name
    basename         = File.basename(replay_file_name.to_s)
    @plain_meta_data = basename.match(FILE_NAME_PATTERN)

    @plain_meta_data.present?
  end
end
