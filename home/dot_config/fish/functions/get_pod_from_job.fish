function get_pod_from_job --description "Return pod names given a job name"
    if test (count $argv) -ne 1
        echo "Usage: get_pod_from_job <job_name>"
        return 1
    end

    set job_name $argv[1]
    set pod_name (kubectl get pods --selector=job-name=$job_name -o jsonpath='{.items[*].metadata.name}')

    if test -z "$pod_name"
        echo "No pod found for job: $job_name"
        return 1
    else
        echo $pod_name
    end
end
