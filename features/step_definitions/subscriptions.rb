Given(/^there are (\d+) (\w+) Subscriptions$/) do |count, channel|
  create_list(:subscription, count, publisher: (Publisher.first || create(:publisher)), channel: channel.downcase)
end
