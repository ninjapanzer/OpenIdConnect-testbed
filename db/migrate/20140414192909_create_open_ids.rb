class CreateOmniauthConfigs < ActiveRecord::Migration
  def change
    create_table :OmniauthConfigs do |t|
      t.string :group_id
      t.text :description
      t.text :config_json
      t.timestamps
    end
  end
end
