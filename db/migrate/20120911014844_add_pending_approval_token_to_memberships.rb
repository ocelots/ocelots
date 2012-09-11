class AddPendingApprovalTokenToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :pending_approval_token, :string
  end
end
