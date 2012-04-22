# Deliverance

Webhook for delivering Pivotal Tracker stories on deployment

# Config

In your config.ru, you must set your Tracker API token and project ID

`Deliverance::Server.token = 'foo'`

`Deliverance::Server.project_id = 'bar'`
