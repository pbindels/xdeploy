class AddLogPathToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :log_path, :string
  end
end
