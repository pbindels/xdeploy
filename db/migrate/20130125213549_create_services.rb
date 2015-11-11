class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :code
      t.string :description
      t.references :project, index: true
      
      t.timestamps
    end
  end
end
