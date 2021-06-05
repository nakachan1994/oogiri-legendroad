class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to complete_contacts_path, notice: 'お問い合わせ内容を送信しました'
    else
      render :new
    end

  end

  def complete
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end
