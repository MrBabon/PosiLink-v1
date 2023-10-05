class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users }
      t.references :followable, polymorphic: true, null: false

      t.timestamps
    end

    add_index :follows, [:followable_id, :followable_type]
    add_index :follows, [:follower_id, :followable_id, :followable_type], unique: true
    add_index :follows, :follower_id
  end
end
