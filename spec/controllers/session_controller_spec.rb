require "rails_helper"
include SessionsHelper

RSpec.shared_examples "check admin" do
  context "When admin loggin success" do
    it "will redirect to admin home" do
      admin = FactoryBot.create :admin
      loggin_user admin
      get :new
      expect(response).to redirect_to admin_root_path  
    end
  end
end

RSpec.shared_examples "login success" do
  it "assign @user" do
    expect(assigns(:user)).to eq(user)  
  end
  
  it "display flash success" do
    expect(flash[:success]).to eq(I18n.t("common.flash.login_success"))  
  end
end

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    it_behaves_like "check admin"
    
    context "when a user" do
      it "will render new template" do
        user = FactoryBot.create :user
        loggin_user user
        get :new
        expect(response).to render_template :new  
      end
    end
    
  end
  
  let!(:user) { FactoryBot.create :user, email: "nhuthahuu@gmail.com" }
  
  describe "POST #create" do
    it_behaves_like "check admin"
    
    context "succes when valid attributes " do
      before do 
        post :create, params: {
          session: {
            email: "nhuthahuu@gmail.com",
            password: "123456"
          }
        }
      end
      
      it_behaves_like "login success"
      
      it "redirect to forwarding_url" do
        expect(response).to redirect_to root_path
      end
    end
    
    context "When have forwarding_url" do
      before do 
        session[:forwarding_url] = new_cart_path
        post :create, params: {
          session: {
            email: "nhuthahuu@gmail.com",
            password: "123456"
          }
        }
      end
      
      it_behaves_like "login success"
      
      it "redirect to forwarding_url" do
        expect(response).to redirect_to new_cart_path
      end
    end
    
    context "When have remember" do
      before do 
        post :create, params: {
          session: {
            remember: 1,
            email: "nhuthahuu@gmail.com",
            password: "123456"
          }
        }
        user.reload
      end
      
      it_behaves_like "login success"
   
      it "Have remember digest" do
        expect(user.remember_digest).not_to be_nil   
      end
      
      it "Cookies have remember token" do
        expect(cookies[:remember_token]).not_to be_nil
      end
      
      it "Cookies have user id" do
        expect(cookies[:user_id]).not_to be_nil  
      end
    end
    
    context "fail when email user not found" do
      before do 
        post :create, params: {
          session: {
            email: "",
            password: "123456"
          }
        }
      end
      
      it "display flash error" do
        expect(flash[:error]).to eq(I18n.t("common.flash.login_invalid"))  
      end
      
      it "render new template" do
        expect(response).to render_template :new
      end
    end
    
    context "fail when password worong" do
      before do 
        post :create, params: {
          session: {
            email: "nhuthahuu@gmail.com",
            password: ""
          }
        }
      end

      it "assign @user" do
        expect(assigns(:user)).to eq(user)  
      end
      
      it "display flash error" do
        expect(flash[:error]).to eq(I18n.t("common.flash.login_invalid"))  
      end
      
      it "render new template" do
        expect(response).to render_template :new
      end
    end
  end
  
  describe "DELETE #destroy" do
    before do
      loggin_user user
      delete :destroy
      user.reload
    end
    
    it { expect(user.remember_digest).to be_nil  }
    
    it { expect(cookies[:remember_token]).to be_nil }
    
    it { expect(cookies[:user_id]).to be_nil }
    
    it { expect(session[:user_id]).to be_nil }
    
    it { expect(assigns(:user)).to be_nil }
    
    it { expect(response).to redirect_to root_path }
  end
  
end
