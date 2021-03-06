class Token < ActiveRecord::Base
  include PublicActivity::Model
  
 #has_paper_trail
  
  belongs_to :tokenable, :polymorphic => true


  attr_accessor :value

  validates :value, format: { without: /\A\s+|\s+\z/,  :message => "Only embedded whitespace is allowed in token value!  Whitespace is not allowed at the beginning or end of token value." }
  validates :name, :exclusion => { :in => ["ENV_NAME"], :message => "\"%{value}\" is reserved by Qdeploy."}, presence: true, uniqueness: { scope: [:tokenable_id, :tokenable_type] }
  validates :encrypted_value  , presence: true

  scope :global, -> { where(tokenable_type: nil, tokenable_id: nil) }
  
  def digest_secret
    Digest::SHA1.hexdigest(Rails.configuration.qdeploy.encryption.secret)
  end
  
  def encryptor
    @@encryptor ||= ActiveSupport::MessageEncryptor.new(digest_secret)
  end
  
  def value=(_value)
    write_attribute(:encrypted_value, encryptor.encrypt_and_sign(_value) )
  end
  
  
  def value
    return nil unless self.encrypted_value
    encryptor.decrypt_and_verify(self.encrypted_value)
  end
end