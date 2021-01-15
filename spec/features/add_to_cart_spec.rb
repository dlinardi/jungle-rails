require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see My Cart (val) change when new product is added" do
    visit root_path

    page.find_link("Signup").click

    expect(page).to have_content("Sign Up")
  
    fill_in 'user[first_name]', with: 'Capy'
    fill_in 'user[last_name]', with: 'Bara'
    fill_in 'user[email]', with: 'ruby@rails.com'
    fill_in 'user[password]', with: 'rails-ruby'
    fill_in 'user[password_confirmation]', with: 'rails-ruby'

    page.find_button("Submit").click
    save_screenshot("signed-up.png")

    expect(page).to have_content("My Cart (0)")

    first("article.product").click_on("Add")

    expect(page).to have_content("My Cart (1)")
    save_screenshot("top_nav_cart_check.png")
  end
end
