class DonationsController < ApplicationController
  
  def donate
    
  end
  
  # Paypal instant payment notification
  def ipn
    
  end
  
  def fake_donation
    @fake_donate = true
    render :action => 'donate'
  end
  
end