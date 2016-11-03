require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post signup_path, params: { user: { 
        name: "",
        email: "abc",
        password: "12",
        password_confirmation: "123" } }
    end
    assert_template "users/new"
    assert_select "form[action=?]", signup_path
  end

  test "valid signup information" do
    get signup_path
    assert_difference "User.count", 1 do
      post signup_path, params: { user: { 
      name: "demo",
      email: "demo@demo.com",
      password: "123456",
      password_confirmation: "123456" } }
    end
    follow_redirect!
    assert_template "users/show"
    assert_not flash.empty?
  end
end
