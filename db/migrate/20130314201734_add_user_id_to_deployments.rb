class AddUserIdToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :user_id, :integer, null: false
  end
end
