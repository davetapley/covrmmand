task :update_locations => :environment do

  User.where(active: true).each { |user| user.update_location! }

end

