namespace :session do
  desc 'Cleans up sessions that are expired'
  task cleanup: :environment do
    puts 'Cleaning up expired sessions...'
    delete_count = Session.expired.delete_all
    puts "Ding! #{delete_count} sessions deleted!"
  end

end
