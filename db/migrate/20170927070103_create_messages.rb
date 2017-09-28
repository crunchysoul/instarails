class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :sender, foreign_key: true
      t.references :recipient, foreign_key: true
      t.text :content

      t.timestamps

      t.index :created_at
    end
  end
end
