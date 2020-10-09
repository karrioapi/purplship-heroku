#!/bin/sh

python app migrate --noinput &&
python app collectstatic

# Create super user for demo
(echo "from django.contrib.auth.models import User; User.objects.create_superuser('$ADMIN_USERNAME', 'admin@example.com', '$ADMIN_PASSWORD')" | python app shell)

# Connect to canada post sandbox server
(echo "from django.contrib.auth.models import User; from purpleserver.providers.models import CanadaPostSettings; CanadaPostSettings.objects.create(carrier_id='canadapost', test=True, username='6e93d53968881714', customer_number='2004381', contract_id='42708517', password='0bfa9fcb9853d1f51ee57a', user=User.objects.first())" | python app shell)
