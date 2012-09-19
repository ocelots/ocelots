desc 'dump the current list of users'
task user_dump: :environment do
  Person.order('id').each {|p| puts"#{p.id.to_s.rjust 5}, #{p.email}, #{p.persona_id}\n\t#{ENV['BASE_URL']}/profiles/#{p.account}\n\t#{ENV['BASE_URL']}/profile?auth_token=#{p.auth_token}"}
end

desc 'dump the current list of teams'
task team_dump: :environment do
  Team.order('id').each{|t| puts "#{t.id.to_s.rjust 5} #{ENV['BASE_URL']}/teams/#{t.slug}"}
end