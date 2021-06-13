class ContactMailer < ApplicationMailer

  def contact_mail(contact)
    @contact = contact
    mail(
      from: 自分のメールアドレス,
      to: contact.email,
      subject: 'お問い合わせを承りました',
      bcc: 自分のメールアドレス
      )
  end
end
