class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :name
      t.string :ohai_info
      
      t.timestamps
    end
  end
end
