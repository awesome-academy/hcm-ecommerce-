require 'rails_helper'

RSpec.describe User, type: :model do
  it "Check new token" do
    User.new_token
  end
end
