class DonationsController < ApplicationController
  
  # Present donate button/form, optionally showing details of fund raiser user
  def donate
    @original_user = User.find_by_donate_token(params[:token])
  end
  
  # Paypal instant payment notification
  def ipn
    # TODO
  end
  
  # Dummy code to add a donation
  def fake_donation
    if params[:donate_token]
      User.transaction do
        @original_user = User.find_by_donate_token(params[:donate_token])
        if @original_user
          @original_user.update_attribute(:money, @original_user.money + params[:amount].to_i)
        end
      end
    end
    render :action => 'thanks'
  end
  
  def thanks
  end
  
end