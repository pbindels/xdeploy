class AddEnvIdToEnvironments < ActiveRecord::Migration
  def change
    add_column :environments, :env_id, :integer, null: false
  end
end
