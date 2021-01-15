require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    params = {
      first_name: 'David', 
      last_name: 'Linardi', 
      email: 'david@test.com', 
      password: 'test123', 
      password_confirmation: 'test123'
    }

    before do
      @user = User.new(params)
    end

    it 'should create user if valid input' do
      @user.save
      expect(@user.errors.full_messages).not_to be_present
    end

    it 'should not allow an empty email' do
      @user.email = nil
      @user.save
      expect(@user.errors.full_messages).to be_present
    end

    it 'should not allow duplicate emails' do
      @user.save
      @another_user = User.new(
        first_name: "Testing",
        last_name: "Tester",
        email: "dave@test.com",
        password: "testing",
        password_confirmation: "testing"
      )
      @another_user.save
      expect(@another_user.errors.full_messages).to be_truthy
    end

    it 'should have a password and password confirmation' do
      @user.password = nil
      @user.password_confirmation = nil
      @user.save
      expect(@user.errors.full_messages).to be_present
    end

    it 'should have a password which matches password confirmation' do
      @user.password = 'test123'
      @user.password_confirmation = '123test'
      @user.save
      expect(@user.errors.full_messages).to be_present
    end

    it 'should have a password with a minimum length of 4' do
      @user.password = 'hi'
      @user.password_confirmation = 'hi'
      @user.save
      expect(@user.errors.full_messages).to be_present
    end

    it 'should have a first name' do
      @user.first_name = nil
      @user.save
      expect(@user.errors.full_messages).to be_present
    end

    it 'should have a last name' do
      @user.last_name = nil
      @user.save
      expect(@user.errors.full_messages).to be_present
    end

  end

  describe '.authenticate_with_credentials' do

    params = {
      first_name: 'David', 
      last_name: 'Linardi', 
      email: 'david@test.ca', 
      password: 'test123', 
      password_confirmation: 'test123'
    }

    before do
      @user = User.new(params)
    end

    it 'should return user when whitespaces occur in email' do
      @user = User.authenticate_with_credentials("   dave@test.ca    ", "test123")
      expect(@user).to eql(@user)
    end

    it 'should ignore case in emails' do
      @user = User.authenticate_with_credentials("dAve@tESt.ca", "test123")
      expect(@user).to eql(@user)
    end

    it "should return nil for invalid email" do
      @user = User.authenticate_with_credentials("dave@tes2E.lol", "test123")
      expect(@user).to be_nil
    end

    it "should return nil for invalid password" do
      @user = User.authenticate_with_credentials("dave@test.ca", "wrongpass11111")
      expect(@user).to be_nil
    end

    it 'should return user on correct credentials ' do
      @user = User.authenticate_with_credentials("dave@test.ca", "test123")
      expect(@user).to eql(@user)
    end

  end

end