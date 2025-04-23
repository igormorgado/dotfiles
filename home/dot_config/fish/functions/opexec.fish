function pexec --description "Open a Bash shell given a Pod Name"
    if test (count $argv) -eq 1
        set -l pod_name $argv[1]
        set phase (pstatus $pod_name)
        if test "$phase" = "running"
          kubectl exec -it $pod_name -- /bin/bash
        else
          echo "ERROR: Job '$job_name' is a '$phase' pod. Shell not available"
        end
    else
        echo "Usage: pexec POD_NAME"
        echo "Executes: kubectl exec -it POD_NAME -- /bin/bash"
    end
end
