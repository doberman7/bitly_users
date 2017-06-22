class CreateUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :urls do |t|
      t.string :long_url #url_original
      t.string :short_url
      t.integer :click_count
      t.integer :user_id
      t.timestamps
    end
  end
end
