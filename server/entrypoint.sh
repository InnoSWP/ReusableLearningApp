#!/bin/bash
python3 ReusableLearningAppServer/manage.py migrate
python3 ReusableLearningAppServer/manage.py init_superadmin
exec "$@"