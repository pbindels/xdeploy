class CreateArtifacts < ActiveRecord::Migration
  def change
    create_table :artifacts do |t|
      t.references :project, index: true
      t.references :service, index: true
      t.string :name
      t.string :file_path

      t.timestamps
    end
  end
end
