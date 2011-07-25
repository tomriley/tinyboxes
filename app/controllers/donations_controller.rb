class DonationsController < ApplicationController
  
  def donate
    @original_user = User.find_by_donate_token(params[:token])
  end
  
  # Paypal instant payment notification
  def ipn
    
  end
  
  def fake_donation
    @fake_donate = true
    render :action => 'donate'
  end
  
end