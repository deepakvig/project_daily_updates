class ProjectUserJoin < ActiveRecord::Migration
  def up
    create_table :projects_users, :force => true, :id => false do |t|
      t.references :project
      t.references :user
      t.timestamps
    end
  end

  def down
    drop_table :projects_users
  end
end
