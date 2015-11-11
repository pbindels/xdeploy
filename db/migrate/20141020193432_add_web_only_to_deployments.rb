class AddWebOnlyToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :web_only, :boolean
  end
end
