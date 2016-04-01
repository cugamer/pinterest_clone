require 'rails_helper'

RSpec.describe ProtectedAccountsHelper, type: :helper do
  describe 'check_for_protected method' do
    it 'returns true if the input account is in the protected arry' do
      expect(check_for_protected('sample@sample.com')).to be true
    end
    
    it 'returns false if the input account is not in the protected array' do
      expect(check_for_protected('madeup@madeup.com')).to be false
    end
  end
  
  
end