require 'csv'
require 'sendgrid-ruby'
include SendGrid

people = CSV.read('people.csv').first
couples = CSV.read('couples.csv')
emails = CSV.read('emails.csv')

santa_pairs = secretSanta(people, couples)

santa_pairs.each do |from_santa, to_santa|
  send_email(from_santa, emails[from_santa], to_santa)
end


def send_email(santa, santa_email, giftee)
  from = Email.new(email: 'phyujin@gmail.com')
  to = Email.new(email: santa_email)
  subject = 'Secret Santa Assignment!'
  content = Content.new(type: 'text/plain', value: "You have #{giftee}")
  mail = Mail.new(from, subject, to, content)

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  sg.client.mail._('send').post(request_body: mail.to_json)
end
