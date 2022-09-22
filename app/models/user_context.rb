class UserContext
  attr_reader :user, :cookies, :params

  def initialize(user, cookies, params)
    @user    = user
    @cookies = cookies
    @params  = params
  end
end
