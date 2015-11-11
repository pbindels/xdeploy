class AddLoaddepAndLoadtokAndPerfdepAndPerftokToUser < ActiveRecord::Migration
  def change
    add_column :users, :loaddep, :boolean
    add_column :users, :loadtok, :boolean
    add_column :users, :perfdep, :boolean
    add_column :users, :perftok, :boolean
  end
end
