module ProtectedAccountsHelper
  def check_for_protected(account)
    protected_accounts = ["sample@sample.com"]
    return protected_accounts.include?(account)
  end
  
end