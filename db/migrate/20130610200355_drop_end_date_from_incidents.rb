class DropEndDateFromIncidents < ActiveRecord::Migration
  def change
    remove_column :incidents, :end_date
  end
end
