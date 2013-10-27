class AddInReplyToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :in_reply_to, :integer
  end
end
