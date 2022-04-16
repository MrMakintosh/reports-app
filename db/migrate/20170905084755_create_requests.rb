class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|

      t.string :type_of_problem, null:false
      t.string :message, null:false
      t.integer :allowed, default:0, null:false
      t.integer :complited, default:0, null:false
      t.string :admin, null:false, default:''
      t.string :admin_message, default:''
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
