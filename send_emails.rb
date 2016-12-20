#!/usr/bin/env ruby
# Send emails for secret santa

require 'csv'
require 'sendgrid-ruby'
require_relative 'link_santa'
include SendGrid

def main
  people = CSV.read('people.csv').first
  couples = CSV.read('couples.csv')
  emails = Hash[CSV.read('emails.csv')]

  santa_pairs = secretSanta(people, couples)

  santa_pairs.each do |from_santa, to_santa|
    send_email(from_santa, emails[from_santa], to_santa)
  end
end

def send_email(santa, santa_email, giftee)
  from = Email.new(email: 'landospear@gmail.com')
  to = Email.new(email: santa_email)
  subject = 'Secret Santa!!!'
  content = Content.new(type: 'text/html', value: "<p>Hey #{santa}, it's...<h2 style='color:red'>Time for Secret Santa!!</h2><img src='https://33.media.tumblr.com/df5485fd17eaa00cb4a9a2d5d9bc01fd/tumblr_inline_nguhe2IYCf1rf8so2.gif'><p>You have #{giftee}!</p><p>Good luck. We're all counting on you.</p>")
  mail = Mail.new(from, subject, to, content)

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  sg.client.mail._('send').post(request_body: mail.to_json)
end

main
