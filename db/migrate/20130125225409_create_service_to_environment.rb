class CreateServiceToEnvironment < ActiveRecord::Migration
  def change
    create_table :service_to_environment do |t|
      t.references :service, index: true
      t.references :environment, index: true

      t.timestamps
    end
  end
end
