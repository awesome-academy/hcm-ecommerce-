require "rails_helper"

RSpec.describe OrderDetail, type: :model do
  
  describe "Associations" do
    it { should belong_to(:order)}

    it { should belong_to(:product)}
  end
end
