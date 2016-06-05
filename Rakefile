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
full_path='eu.gcr.io/worldofnic-production/worldofnic'

# increment a revision x.y.z -> x.y.z+1
recent=$( docker images | grep ^${full_path} | awk '{print $2}' | grep -v '[:alpha:]' | grep -v ^v | sort -n | tail -1)
major_minor=$( echo ${recent} | cut -f1,2 -d . )
revision=$( echo ${recent} | cut -f3 -d . )
new_revision=echo $revision 1 + f | dc
tag=${major_minor}.${new_revision}

docker build --pull --rm -t ${full_path} .
docker tag ${full_path} ${full_path}:${tag}

gcloud docker push ${full_path}
gcloud docker push ${full_path}:${tag}

# Inject $version into app.yaml
yamlfile=$(mktemp)
cat rs/deployment.yaml | sed -e "s/__VERSION__/${tag}/" > yamlfile
kubectl apply -f yamlfile
rm yamlfile
