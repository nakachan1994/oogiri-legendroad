class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail(
      from: ENV['SEND_MAIL'],
      to: contact.email,
      subject: 'お問い合わせを承りました',
      bcc: ENV['SEND_MAIL']
    )
  end
end
