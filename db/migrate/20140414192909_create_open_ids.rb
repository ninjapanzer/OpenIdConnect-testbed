class CreateOpenIds < ActiveRecord::Migration
  def change
    create_table :open_ids do |t|
      t.string :group_id
      t.text :description
      t.text :config_json
      t.timestamps
    end
  end
end
