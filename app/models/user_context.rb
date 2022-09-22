class UserContext
  attr_reader :user, :pincode

  def initialize(user, pincode)
    @user     = user
    @pincode  = pincode
  end
end
