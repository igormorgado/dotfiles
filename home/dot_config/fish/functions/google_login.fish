function google_login --description 'Login in GCP only if needed'

  set -l ACCESSTOKEN (echo | gcloud auth application-default print-access-token)

  if test -z "$ACCESSTOKEN"
      echo "You're not authenticated at Google Cloud Platform. CTRL-C to skip it"
      gcloud auth login --update-adc
  end
end
