class ChangeArtifactColumnToArtifactIdOnDeployments < ActiveRecord::Migration
  def change
    remove_column :deployments, :artifact
    add_column :deployments, :artifact_id, :integer, :null => false
  end
end
