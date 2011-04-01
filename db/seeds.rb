Role.create! :name => "admin"
Role.create! :name => "client"
Role.create! :name => "member"

Admin.create! :email => "admin@gmail.com", :username => "admin", :password => "admin123", :password_confirmation => "admin123"
c = Client.create!:email => "client@gmail.com", :username => "client", :password => "client123", :password_confirmation => "client123", :confirmation_sent_at => "2011-01-01 11:00:00"
c.confirmed_at = DateTime.now
c.save!


def add_pictures(member,dir)
  1.upto 3 do |j|
    p = member.pictures.create!
    p.image = File.open(File.join("#{Rails.root}","test","pictures","#{dir}","#{j}.jpg"))
    p.save!
  end
end

1.upto 18 do |i|
  m = Member.create!:email => "member#{i}@gmail.com", :username => "member#{i}", :profile_name => "member#{i}", :password => "member123", :password_confirmation => "member123", :confirmation_sent_at => "2011-01-01 11:00:00"
  m.confirmed_at = DateTime.now
  m.save!
  add_pictures(m,i)
  m.save!
  puts "Member #{m.username} created with #{m.pictures.count} pictures"
end

puts "Admin has #{Admin.first.roles.count} role called #{Admin.first.roles.first.name}"
puts "Client has #{Client.first.roles.count} role called #{Client.first.roles.first.name}"
