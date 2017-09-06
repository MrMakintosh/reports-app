class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|

      t.string :type, null:false
      t.string :message, null:false
      t.integer :allowed, default:0, null:false
      t.integer :complited, default:0, null:false
      t.string :admin, null:false
      t.belongs_to :user, index: {unique:true}

      t.timestamps null: false
    end
  end
end
