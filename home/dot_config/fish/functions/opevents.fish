function events --description "Fetch the latest events from a given job"
  if test (count $argv) -eq 0
      # If no arguments are passed, use the current directory name
      set job_name (basename $PWD)
  else if test (count $argv) -eq 1
      set job_name $argv[1]
  else
      echo "Usage: events [JOB_NAME]"
      echo "If JOB_NAME is not provided, the current directory name will be used."
      return 1
  end
  
  # Check if the job exists
  if test -n "$job_name"
    if not kubectl get job $job_name &>/dev/null
      echo "Error: Job '$job_name' does not exist."
      return 1
    end
  end
  
  set pod_names (get_pod_from_job $job_name)
  set pod_name (string split ' ' $pod_names)[1]

  if test -n $pod_name
    kubectl describe pod $pod_name | grep -A 999 Events:
  end
end

