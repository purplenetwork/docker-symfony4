# Build arguments
ARG IMAGE
ARG APP_PATH=.

FROM purplenetworksrl/php

# Add the source
ONBUILD ADD --chown=application ${APP_PATH} /app
ONBUILD RUN ls -la /app
ONBUILD RUN rm -r /app/docker

# Set the working directory
ONBUILD WORKDIR /app

ONBUILD ADD ./docker/build/symfony4/post_deploy_commands.sh /post_deploy_commands.sh

ONBUILD RUN chmod -R a+rwX /app/public /app/var

# Download and run composer
ONBUILD USER application
ONBUILD RUN composer install --no-ansi --no-interaction --no-progress --optimize-autoloader --no-dev --no-scripts
ONBUILD RUN bin/console assets:install --symlink --relative public
ONBUILD RUN bin/console cache:warmup