#!/bin/bash

bin/rails db:migrate RAILS_ENV=development 
bin/rails db:migrate RAILS_ENV=test
