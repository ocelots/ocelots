module TeamsHelper
  def membership_partial membership
    return 'my_membership' if membership.person == @current_person
    membership.pending? ? 'pending_membership' : 'approved_membership'
  end
end