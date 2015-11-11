class CreateProjectRepositories < ActiveRecord::Migration
  def change
    create_table :projects_repositories do |t|
      t.references :project_id, index: true
      t.references :repository_id, index: true

      t.timestamps
    end
  end
end
