class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :type
      t.string :name
      t.string :description
      t.string :uuid
      t.string :url
      t.text   :properties

      t.timestamps
    end
    
    add_index :repositories, :type
    add_index :repositories, :uuid
  end
end
