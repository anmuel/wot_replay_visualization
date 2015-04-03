Fabricator(:wot_replay) do
  replay do
    fixtures_file_path_pattern = Rails.root.join('spec', 'fixtures',
      '**.wotreplay')

    file_path = Dir.glob(fixtures_file_path_pattern).sample
    Rack::Test::UploadedFile.new(file_path)
  end
end
