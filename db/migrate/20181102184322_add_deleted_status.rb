class AddDeletedStatus < ActiveRecord::Migration[5.0]
  def up
    deleted_status = Status.find_by_id(4)
    if deleted_status.nil?
      Status.create(:id => 4, :name => "Deleted")
    end
  end

  def down
    deleted_status = Status.find_by_id(4)
    unless deleted_status.nil?
      deleted_status.delete
    end
  end
end
