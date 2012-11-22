module TeamsHelper
  def membership_partial membership
    membership.pending? ? 'pending_membership' : 'approved_membership'
  end
end