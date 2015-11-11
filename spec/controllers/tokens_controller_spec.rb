require 'spec_helper'

describe TokensController do
  before_each_basic_login
  let(:token){ create(:token) }
  
  describe "GET index" do
    before(:each) do
      token
    end
    it "assigns tokens" do
      get :index
      assigns(:global_tokens).should eq([token])
    end
    
    it "assigns tokens based on a polymorphic parent" do
      get :index
      assigns(:global_tokens).should eq([token])
    end
  end

  describe "GET show" do
    it "assigns the requested token as @token" do
      get :show, {:id => token.to_param}
      assigns(:token).should eq(token)
    end
  end

  describe "GET new" do
    it "assigns a new token as @token" do
      get :new, {}
      assigns(:token).should be_a_new(Token)
    end
  end

  describe "GET edit" do
    it "assigns the requested token as @token" do
      get :edit, {:id => token.to_param}
      assigns(:token).should eq(token)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Token" do
        expect {
          post :create, {:token => attributes_for(:token)}
        }.to change(Token, :count).by(1)
      end

      it "assigns a newly created token as @token" do
        post :create, {:token => attributes_for(:token)}
        assigns(:token).should be_a(Token)
        assigns(:token).should be_persisted
      end

      it "redirects to the created token" do
        post :create, {:token => attributes_for(:token)}
        response.should redirect_to(tokens_path)
      end
      
      it "should create a token based on the tokenable" do
        project = create(:project)
        post :create, {:token => attributes_for(:token, tokenable_type: project.class, tokenable_id: project.id) }
        
        project.tokens.count.should == 1
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved token as @token" do
        # Trigger the behavior that occurs when invalid params are submitted
        Token.any_instance.stub(:save).and_return(false)
        post :create, {:token => { "name" => "invalid value" }}
        assigns(:token).should be_a_new(Token)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Token.any_instance.stub(:save).and_return(false)
        post :create, {:token => { "name" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested token" do
        Token.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => token.to_param, :token => { "name" => "MyString" }}
      end

      it "assigns the requested token as @token" do
        
        put :update, {id: token.to_param, :token => attributes_for(:token)}
        assigns(:token).should eq(token)
      end

      it "redirects to the token" do
        
        put :update, {id: token.to_param, :token => attributes_for(:token)}
        response.should redirect_to(token_path(token))
      end
    end

    describe "with invalid params" do
      it "assigns the token as @token" do
      
        # Trigger the behavior that occurs when invalid params are submitted
        Token.any_instance.stub(:save).and_return(false)
        put :update, {:id => token.to_param, :token => { "name" => "invalid value" }}
        assigns(:token).should eq(token)
      end

      it "re-renders the 'edit' template" do
        
        # Trigger the behavior that occurs when invalid params are submitted
        Token.any_instance.stub(:save).and_return(false)
        put :update, {:id => token.to_param, :token => { "name" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested token" do
      token
      expect {
        delete :destroy, {:id => token.to_param}
      }.to change(Token, :count).by(-1)
    end

    it "redirects to the tokens list" do
      delete :destroy, {:id => token.to_param}
      response.should redirect_to(tokens_url)
    end
  end

end