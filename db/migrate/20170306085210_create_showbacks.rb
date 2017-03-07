class CreateShowbacks < ActiveRecord::Migration[5.0]
  def up
    create_table :showbacks do |t|
      t.text       :data
      t.timestamp  :event_init
      t.timestamp  :event_end
      t.bigint     :id_obj
      t.string     :type_obj
      t.bigint     :showback_configuration_id
      t.timestamp  :updated_at
      t.timestamp  :created_at
    end
    add_index  :showbacks, :id_obj
    add_index  :showbacks, :showback_configuration_id
  end

  def down
    remove_index  :showbacks, :id_obj
    remove_index  :showbacks, :showback_configuration_id
    drop_table :showbacks
  end
end
