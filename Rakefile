require 'rubygems' unless defined?(Gem)
require 'pathname'
require 'date'
require 'time'
require 'rake/clean'
require 'git'

# NOT A RAKE FILE YET
namespace "hugo" do
  $this_dir = Pathname.new(__FILE__).dirname.expand_path
  $hugo_dir = $this_dir.join('files/hugo')

  desc 'Run Hugo'
  task :hugo
    # cd $hugo_dir && run hugo
  hugo
end

namespace "git" do
  #version='git log | head -1 | awk '{print $2}'

end

# Current check-in

inject $version into footer - use this environment variable
export GIT_COMMIT=$(git log | head -1 | awk '{print $2}')
hugo

# docker build
full-path='eu.gcr.io/worldofnic-production/worldofnic'
docker build --pull --rm -t eu.gcr.io/worldofnic-production/worldofnic .
docker build -t eu.gcr.io/worldofnic-production/worldofnic:$version

gcloud docker push eu.gcr.io/worldofnic-production/worldofnic .
gcloud docker push eu.gcr.io/worldofnic-production/worldofnic:$version

# Inject $version into app.yaml
kubectl apply -f app.yaml
