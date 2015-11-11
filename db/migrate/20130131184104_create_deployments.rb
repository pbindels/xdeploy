class CreateDeployments < ActiveRecord::Migration
  def change
    create_table :deployments do |t|
      t.references :project, index: true
      t.references :service, index: true
      t.references :environment, index: true
      t.string :artifact
      t.string :job_uuid
      t.string :status
      t.string :pct_complete
      t.datetime :started_at
      t.datetime :ended_at
      
      t.timestamps
    end
  end
end
