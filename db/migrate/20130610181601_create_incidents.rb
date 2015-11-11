class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :title
      t.text :content
      t.string :tag

      t.timestamps
    end
  end
end
