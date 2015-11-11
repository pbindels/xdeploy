class AddRecipientsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :recipients, :string
  end
end
