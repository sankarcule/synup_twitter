class RenameColumnAttachments < ActiveRecord::Migration[5.1]
  def change
    rename_column :attachments, :attachment_id, :attachable_id
  end
end
