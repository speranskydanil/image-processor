# Image Processor

It is a simple rails application for processing image collections.

### Features

* authorization, managing users
* creating hierarchy of nodes (like directories) with names, descriptions, statuses
* uploading images
* ordering images
* inserting, duplicating
* rotating and cropping
* canceling changes
* nice interface for viewing and processing image collections

### Dependencies

* MySQL
* ImageMagick

### Quick Start

* git clone git@github.com:speranskydanil/image-processor.git
* cp config/database.example.yml config/database.yml; vim config/database.yml
* bin/rebuild -e p
* rails server

Default login and password (seeds.rb): name@company.com passwordexample

### Rebuilding

    bin/rebuild -h

    Usage: bin/rebuild [options]

    -f, --flags F        Flags for the rebuild script (by default all of them)
                         l - bundle exec rake log:clear
                         a - bundle exec rake assets:clean
                         d - bundle exec rake db:drop
                         c - bundle exec rake db:create
                         m - bundle exec rake db:migrate
                         s - bundle exec rake db:seed
                         p - RAILS_ENV=production bundle exec rake assets:precompile
                         j - [ -e bin/delayed_job ] && bin/delayed_job restart
                         Example: dcms

    -e, --except E       Except flags for the rebuild script
                         See documentation for --flags

### Updating

    bin/update -h

    Usage: bin/update [options]

    -f, --flags F        Flags for the update script (by default all of them)
                         l - bundle exec rake log:clear
                         a - bundle exec rake assets:clean
                         g - git pull
                         b - bundle install
                         m - bundle exec rake db:migrate
                         p - RAILS_ENV=production bundle exec rake assets:precompile
                         j - [ -e bin/delayed_job ] && bin/delayed_job restart
                         Example: gm

    -e, --except E       Except flags for the update script
                         See documentation for --flags

### Add Test Data

    rake atd[path] # where path -- path to a directory with images

### Screens

![screen](https://raw.github.com/speranskydanil/image-processor/master/screens/1.png)

![screen](https://raw.github.com/speranskydanil/image-processor/master/screens/2.png)

![screen](https://raw.github.com/speranskydanil/image-processor/master/screens/3.png)

![screen](https://raw.github.com/speranskydanil/image-processor/master/screens/4.png)

![screen](https://raw.github.com/speranskydanil/image-processor/master/screens/5.png)

![screen](https://raw.github.com/speranskydanil/image-processor/master/screens/6.png)

**Author (Speransky Danil):**
[Personal Page](http://dsperansky.info) |
[LinkedIn](http://ru.linkedin.com/in/speranskydanil/en) |
[GitHub](https://github.com/speranskydanil?tab=repositories) |
[StackOverflow](http://stackoverflow.com/users/1550807/speransky-danil)

