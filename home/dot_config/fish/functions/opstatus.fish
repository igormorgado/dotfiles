function pstatus --description "Return the pod status"
  # Check if required arguments are provided
  if test (count $argv) -lt 1
    echo "Usage: pstatus <pod>"
    return 1
  end

  set pod $argv[1]

  # Get the pod status
  set phase (kubectl get pod $pod -o jsonpath="{.status.phase}")

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
