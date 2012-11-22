h = Hash.new
Membership.find(:all).each{|membership|
  if mem = h[[membership.person_id,membership.team_id]]
     Membership.destroy(mem)
  end
  h[[membership.person_id,membership.team_id]] = membership
}
