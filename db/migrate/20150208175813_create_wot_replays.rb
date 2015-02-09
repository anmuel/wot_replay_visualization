class CreateWotReplays < ActiveRecord::Migration
  def change
    create_table :wot_replays do |t|
      t.timestamps
      t.attachment :replay
    end
  end
end
