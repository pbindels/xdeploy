require 'spec_helper'

describe Token do
  
  describe "associations" do

    it { should belong_to(:tokenable) }

  end

  describe "validations" do

    it{ should validate_presence_of(:name) }
    it{ should validate_uniqueness_of(:name) }
    it{ should validate_presence_of(:encrypted_value) }

  end
  
  describe "helpers" do
    
    describe "#digest_secret" do
      it "should create a hex digest based on a configuration token" do
        Token.new.digest_secret.should =~ /^[A-Z0-9]{40}$/i
      end
    end
    
    describe "#encryptor" do
      it "should create and instance of ActiveSupport::MessageEncryptor based of the digest secret" do
        token = Token.new
        
        token.encryptor.should be_a(ActiveSupport::MessageEncryptor)
        
      end
    end
    
    describe "#value=" do
      it "should encrypt the value and write it to encrypted_value" do

        token = Token.new
        token.value = "test"
        
        token.encrypted_value.should_not be_nil
        
      end 
    end
    
    describe "#value" do
      before(:each) do

        @token = Token.new
        @token.value = "test"
        
      end

      it "should return the value decrypted from the encrypted value field" do

        @token.value.should == "test"

      end

      it "should return the value decrypted from the encrypted value field" do      

        @token.encryptor.decrypt_and_verify(@token.encrypted_value).should == "test"

      end
      
      it "should return back nil if the encrypted_value is not set" do
        token = Token.new
        token.value.should == nil
      end
    end

  end
end
