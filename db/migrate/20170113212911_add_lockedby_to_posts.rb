class AddLockedbyToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :lockedby, index: true
    add_foreign_key :posts, :provers, column: :lockedby_id
  end
end
