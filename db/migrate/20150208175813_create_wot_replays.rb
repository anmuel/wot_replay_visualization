class CreateWotReplays < ActiveRecord::Migration
  def change
    create_table :wot_replays do |t|
      t.timestamps
      t.attachment :replay_file
    end
  end
end
