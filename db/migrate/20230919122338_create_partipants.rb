class CreatePartipants < ActiveRecord::Migration[7.0]
  def change
    create_table :partipants do |t|
      t.references :chatroom, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
