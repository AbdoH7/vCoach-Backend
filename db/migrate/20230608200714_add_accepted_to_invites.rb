class AddAcceptedToInvites < ActiveRecord::Migration[7.0]
  def change
    add_column :invites, :accepted, :boolean, default: 'false', null: false
  end
end
