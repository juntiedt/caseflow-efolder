class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.string :request_id
      t.string :file_number
      t.integer :status, default: 0
 
      t.timestamps null: false
    end
  end
end
