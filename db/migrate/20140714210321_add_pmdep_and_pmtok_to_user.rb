class AddPmdepAndPmtokToUser < ActiveRecord::Migration
  def change
    add_column :users, :pmdep, :boolean
    add_column :users, :pmtok, :boolean
  end
end
