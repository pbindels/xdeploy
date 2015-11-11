class AddDescriptionToTokens < ActiveRecord::Migration
  def change
    add_column :tokens, :description, :string
  end
end
