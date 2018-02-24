namespace :notification do
  desc "Sends SMS notification to employees asking them to log overtime"
  task sms: :environment do

    # User.all.each do |user|
    #   SmsTool.send_sms()
    # end
  end

  desc "Sends email notification to managers each day to inform them of pending overtime requests"
  task manager_email: :environment do
    submitted_posts = Post.submitted
    admin_users = AdminUser.all

    if submitted_posts.count > 0
      admin_users.each do |admin|
        ManagerMailer.email(admin).deliver_now
      end
    end
  end
end
