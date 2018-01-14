require 'rails_helper'

describe 'navigate' do
  let(:user) { FactoryBot.create(:user) }

  let(:post) do
    Post.create(date: Date.today, rationale: "Rationale", user_id: user.id, overtime_request: 3.5)
  end

  before do
    login_as(user, scope: :user)
  end

  describe 'index' do
    before do
      visit posts_path
    end
    it 'can be reached successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title of posts' do
      expect(page).to have_content(/Posts/)
    end

    it 'has a list of posts' do
      post1 = FactoryBot.create(:post)
      post2 = FactoryBot.create(:second_post)
      visit posts_path
      expect(page).to have_content(/Rationale|content/)
    end

    it 'has a scope so that users can only see their own posts' do
      other_user = User.create(first_name: "hacker", last_name: "man", email: "asdf@blah.com", password: "asdfasdf", password_confirmation: "asdfasdf")

      post_from_other_user = Post.create(date: Date.today, rationale: "This cant be seen", user_id: other_user.id, overtime_request: 3.5 )
      
      expect(@page).to_not have_content(/This cant be seen/)
    end
  end

  describe 'new' do
    it 'has a link from the homepage' do
      visit root_path

      click_link("new_post_from_nav")
      expect(page.status_code).to eq(200)
    end
  end


  describe 'delete' do
    it 'can be deleted' do
      logout(:user)

      delete_user = FactoryBot.create(:user)
      login_as(delete_user, :scope => :user)

      post_to_delete = Post.create(date: Date.today, rationale: 'asdf', user_id: delete_user.id, overtime_request: 3.5)

      visit posts_path

      click_link("delete_post_#{post_to_delete.id}_from_index")
      expect(page.status_code).to eq(200)
    end
  end

  describe 'creation' do
    before do
      user = User.create(email: "test@test.com", password: "asdfasdf", password_confirmation: "asdfasdf", first_name: "John", last_name: "Carter")
      login_as(user, :scope => :user)
      visit new_post_path
    end
    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do
      visit new_post_path
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Some rationale"
      fill_in 'post[overtime_request]', with: 4.5
      expect { click_on "Save" }.to change(Post, :count).by(1)
    end

    it 'will have a user associated with it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "User Association"
      fill_in 'post[overtime_request]', with: 4.5
      click_on "Save"

      expect(User.last.posts.last.rationale).to eq("User Association")
    end
  end

  describe 'edit' do
    it 'can be edited' do
      visit edit_post_path(post)

      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Edited Content"
      click_on "Save"

      expect(page).to have_content("Edited Content")
    end

    it 'cannot be edited by a non authorized user' do
      logout(:user)
      non_authorized_user = FactoryBot.create(:non_authorized_user)
      login_as(non_authorized_user, :scope => :user)

      visit edit_post_path(post)

      expect(current_path).to eq(root_path)
    end
  end
end






