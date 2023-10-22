#!/bin/bash

# Initialize an array to keep track of failed jobs
failed_jobs=()
initial_path=$(pwd)

# Find all valid job scripts and store them in the temporary file
find . -type f -name 'posel_*.sh' > jobs_paths

# Check if the temporary file exists
if [ -f "jobs_paths" ]; then
    while IFS= read -r job_path; do
        job_name=$(basename "$job_path" | sed -n 's/posel_\(.*\)\.sh/\1/p')
        job_dir_path=$(dirname "$job_path")

        # Navigate to the job path
        cd "$job_dir_path" || continue

        # Check if the job script starts with #!/bin/bash
        if [ "$(head -n 1 "posel_${job_name}.sh")" != "#!/bin/bash" ]; then
            echo "Job posel_${job_name}.sh does not start with #!/bin/bash, skipping."
            cd "$initial_path"
            continue
        fi

        # Run the job using bash
        bash "posel_${job_name}.sh" > "posel_${job_name}.out"

        # Check the exit status of the job
        if [ "$(tail -n 1 "posel_${job_name}.out")" == "Fail" ]; then
            failed_jobs+=("${job_dir_path}/posel_${job_name}.sh")
        fi

        # Return to the original directory
        cd "$initial_path"
    done < jobs_paths

    # Remove the temporary file
    rm jobs_paths
fi

# Print a list of failed jobs
if [ ${#failed_jobs[*]} -ne 0 ]; then
    echo "Failes jobs:"
    for job in "${failed_jobs[@]}"; do
        echo "$job"
    done
fi

