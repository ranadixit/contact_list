class ContactsController < ApplicationController
  
  before_action :find_contact, only: %i[show]
  
  def index
    @contacts = Contact.all
    combinations = combinations(params[:search_text])
    @contacts = @contacts.where("lower(name) iLIKE ANY ( array[?] )", combinations.map{|c| "%#{c}%"}) if params[:search_text].present?

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

  def combinations(digits, prefix ="", result = [])
    keypad = { '2'=> 'abc', '3'=> 'def', '4'=> 'ghi', '5'=> 'jkl', '6'=> 'mno', '7'=> 'pqrs', '8'=> 'tuv', '9'=> 'wxyz' }

    if digits && digits.empty?
      result << prefix

      return
    end

    latters = keypad[digits[0]] if digits.present?

    latters.chars.each do |char|
      combinations(digits[1..-1], prefix + char, result )
    end if latters

    return result
  end
end
