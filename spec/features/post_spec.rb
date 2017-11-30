require 'rails_helper'

describe 'navigate' do

  before do
    @user = FactoryBot.create(:user)
    sign_in(@user, scope: :user)
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
      click_on "Save"
      expect(page).to have_content("Some rationale")
    end

    it 'will have a user associated with it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "User Association"
      click_on "Save"

      expect(User.last.posts.last.rationale).to eq("User Association")
    end

    describe 'edit' do

      before do
        @post = FactoryBot.create(:post)
      end
      it 'can be reached by clicking edit on the index page'

      visit posts_path
      click_link "edit #{@post.id}"
      expect(page.status_code).to eq(200)
    end

    it 'can be editied' do
      visit edit_post_path(@post)

      fill_in 'post[date]', width: Date.today
      fill_in 'post[rationale', with: "Edited Content"
      click_on "Save"

      expect(page).to have_content("Edited content")
    end
  end
end






