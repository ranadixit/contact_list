class ContactsController < ApplicationController
  
  before_action :find_contact, only: %i[show]
  
  def index
    @contacts = Contact.all
    @contacts = @contacts.where("name LIKE :search OR email LIKE :search OR phone_number LIKE :search", search: "%#{params[:search_text]}%") if params[:search_text].present?
  end

  def show
  	respond_to do |format|
  		format.html { render '_contact_details_modal' }
  	end
  end

  private

  def contact_params
    params.require(contact).parmit(:name,:email, :mobile_number)
  end

  def find_contact
    @contact = Contact.find(params[:id])
  end
end
