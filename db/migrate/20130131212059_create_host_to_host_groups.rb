class CreateHostToHostGroups < ActiveRecord::Migration
  def change
    create_table :host_to_host_group do |t|
      t.references :host
      t.references :host_group
      t.timestamps
    end
  end
end
