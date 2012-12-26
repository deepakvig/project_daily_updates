class CreateStatusReports < ActiveRecord::Migration
  def change
    create_table :status_reports do |t|
      t.references :project
      t.references :user
      t.text :yesterday
      t.text :today
      t.date :status_date

      t.timestamps
    end
    add_index :status_reports, :project_id
    add_index :status_reports, :user_id
  end
end
