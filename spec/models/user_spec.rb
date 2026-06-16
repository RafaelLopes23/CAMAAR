require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a name, email, and password" do
    user = User.new(name: "Rebeca", email: "rebeca@example.com", password: "password123")
    expect(user).to be_valid
  end

  it "is invalid without an email" do
    user = User.new(name: "Rebeca", password: "password123")
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email" do
    User.create!(name: "Rebeca", email: "rebeca@example.com", password: "password123")
    user = User.new(name: "Outro", email: "rebeca@example.com", password: "password123")
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "is invalid without a name" do
    user = User.new(email: "rebeca@example.com", password: "password123")
    expect(user).to_not be_valid
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid if the password is too short" do
    user = User.new(name: "Rebeca", email: "rebeca@example.com", password: "123")
    expect(user).to_not be_valid
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  describe ".authenticate" do
    let!(:user) { User.create!(name: "Rebeca", email: "rebeca@example.com", password: "password123") }

    it "returns the user if credentials are correct" do
      expect(User.authenticate("rebeca@example.com", "password123")).to eq(user)
    end

    it "returns false if the password is wrong" do
      expect(User.authenticate("rebeca@example.com", "wrongpassword")).to be_falsey
    end

    it "returns nil if the email is not found" do
      expect(User.authenticate("notfound@example.com", "password123")).to be_nil
    end
  end
end
