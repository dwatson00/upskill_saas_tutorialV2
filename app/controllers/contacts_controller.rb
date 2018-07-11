class ContactsController < ApplicationController
  
  #GET request to /contact-us
  #show new contact form
  def new
    @contact = Contact.new
  end
  
  #POST request to /contacts
  def create
    #mass assignment of form fields into contact obj
    @contact = Contact.new(contact_params)
    #save the contact object into the DB
    if @contact.save
      #Stores form fields via paramters into variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      #plug variables into the contact 
      #mailer email method and send
      ContactMailer.contact_email(name, email, body).deliver
      #Store success message into flash hash
      #and redriect to new action
      flash[:success] = "Message Sent."
      redirect_to new_contact_path
    else
      #if  Contact object doesnt save,
      #store error in flash hash,
      #redrirect to new action
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end
  
  private
  #to collect data from from we need to use strong paramaters
  #and whitelist the form fields
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
    
end