FactoryBot.define do

  sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
    frst_name 'John'
    last_name 'Carter'
    email 'test@test.com'
    password "asdfasdf"
    password confirmation "asdfasdf"
  end


  factory :admin_user, class: "AdminUser" do
    frst_name 'Admin'
    last_name 'User'
    email 'admin@user.com'
    password "asdfasdf"
    password confirmation "asdfasdf"
  end
end