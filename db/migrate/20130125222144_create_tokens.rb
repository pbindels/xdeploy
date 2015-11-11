class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :tokenable_type
      t.integer :tokenable_id
      t.string :name
      t.string :encrypted_value
      
      t.timestamps
    end
  end
end
