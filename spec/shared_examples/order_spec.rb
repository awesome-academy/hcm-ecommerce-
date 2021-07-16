RSpec.shared_examples "user don't login" do
  before {get :new}
  it "is store forwarding_url" do
    expect(session[:forwarding_url]).not_to be_nil
  end
  
  it "redirect to login path" do
    expect(response).to redirect_to login_path  
  end
end

RSpec.shared_examples "user is admin" do 
  let!(:admin) { FactoryBot.create :admin }
  before do
    loggin_user admin
    get :new
  end
  it "redirect to admin_root_path" do 
    expect(response).to redirect_to admin_root_path  
  end
end

RSpec.shared_examples "id order not found" do 
  it "assign @Order" do
    expect(assigns(:order)).to be_nil  
  end
  
  it "flash error" do
    expect(flash[:error]).to eq(I18n.t("common.flash.load_order_fail"))  
  end
  
  it "redirect to order path" do
    expect(response).to redirect_to orders_path  
  end
end
