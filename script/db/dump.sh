publishers 9
  exlude id

SELECT
  title,
  endpoint,
  updated_at,
  created_at,
  active,
  city,
  icon,
  visible,
  state,
  description,
  tags
FROM
  publishers

subscriptions 1268
  add publisher_title
  exclude id
  exclude publisher_id
  join publisers.title = publisher_title, publishers.city = "nyc"

SELECT
  geom,
  updated_at,
  created_at,
  publisher_title,
  channel,
  phone_number,
  email_address,
  webhook_url,
  unsubscribed_at,
  last_notified
FROM
  subscriptions

events? no? 3176311 records events
http_requests? no? RequestLog
outages? no, irrelevant
sms_credentials? no, empty
spatial_ref_sys? no? generated?
