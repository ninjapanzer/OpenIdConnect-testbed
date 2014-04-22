class CreateOmniAuthConfigs < ActiveRecord::Migration
  def change
    create_table :omni_auth_configs do |t|
      t.string :name
      t.string :strategy
      t.string :json

      t.timestamps
    end
  end
end
