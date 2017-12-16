class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.integer :attachment_id
      t.string :attachable_type
      t.string :string

      t.timestamps
    end
  end
end
