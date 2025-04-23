function jstatus --description "Return the pod status given a job"
  if test (count $argv) -eq 0
    # If no arguments are passed, use the current directory name
    set job_name (basename $PWD)
  else if test (count $argv) -eq 1
    set job_name $argv[1]
  else
    echo "Usage: jstatus [JOB_NAME]"
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

  set phase (kubectl get pod $pod_name -o jsonpath="{.status.phase}")

  switch $phase
    case "Running"
      echo "running"
      return 0
    case "Pending"
      echo "pending"
      return 1
    case "Succeeded"
      echo "succeeded"
      return 0
    case "Failed"
      echo "failed"
      return 1
    case "*"
      echo "unknown: $phase"
      return 1
  end
end
