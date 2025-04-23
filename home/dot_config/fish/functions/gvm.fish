function gvm --description 'Simple manager for GCP virtual machines'
  # Param1: instance name
  # Param2: operation (status/start/stop)
  set -l cmd_fullpath (status filename)
  set -l cmd_nameext (basename $cmd_fullpath)
  set -l cmd_name (string replace -r '\.[^.]*$' '' -- $cmd_nameext )
  set -l argc (count $argv)

  if test $argc -lt 2
    printf "Usage: %s <instance_name> <start|stop|status> [extra_args]" "$cmd_name"
    return 1
  end

  set -l instance_name $argv[1]
  set -l operation $argv[2]
  set -l gcp_project (gcloud config get-value project)
  set -l gcp_zone (gcloud config get-value compute/zone)
  #set -l gcp_region (gcloud config get-value compute/region)

  # Consuming named args after 3 to end
  # for arg in $argv[3..-1]
  #  switch $arg
  #    case "somearg=*'
  #      set somearg (string replace 'somearg=' ''-- $arg)
  #    # and more
  #  end
  # end

  switch $operation
    case "start"
      gcloud compute instances start $instance_name 
    case "stop"
      gcloud compute instances stop $instance_name
    case "reset"
      gcloud compute instances reset $instance_name
    case "status"
      set -l vm_status (gcloud compute instances describe $instance_name --format='value(status)')
      printf "%s/%s/%s: %s" \
        "$gcp_project" \
        "$gcp_zone" \
        "$instance_name" \
        "$vm_status"
    case "*"
      printf "Operation %s is unknown" "$operation"
  end
end
    
  

  

  
