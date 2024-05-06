class CreateImageContainer < ActiveRecord::Migration[7.1]
  def change
    create_table :image_containers do |t|
      t.text     :hocr_data

      t.timestamps
    end
  end
end
