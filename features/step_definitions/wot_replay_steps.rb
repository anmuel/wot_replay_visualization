When(/^I upload the file "(.+)"$/) do |replay_file_name|
  @last_replay_file_name = replay_file_name
  replay_file_path = Rails.root.join('spec', 'fixtures', replay_file_name)
  attach_file('Replay', replay_file_path)
  click_button 'Upload'
end

And(/I see the uploaded replay's data in the table/) do
  wot_replay = WotReplay.last
  expect(@last_replay_file_name).to eq wot_replay.replay_file_name

  table = find(:css, '#wot-replays table')
  expect(table).to have_text('Download')

  table_columns = %w[time tank map country]
  table_columns.each do |column|
    expect(table.to have_text(wot_replay.send(column)))
  end
end
