class AddProddepAndProdtokAndIntdepAndInttokAndQadepAndQatokToUser < ActiveRecord::Migration
  def change
    add_column :users, :proddep, :boolean
    add_column :users, :prodtok, :boolean
    add_column :users, :intdep, :boolean
    add_column :users, :inttok, :boolean
    add_column :users, :qadep, :boolean
    add_column :users, :qatok, :boolean
  end
end
