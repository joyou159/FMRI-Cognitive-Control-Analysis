
# Check if the correct number of arguments is provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <threshold> <subject_list or 'all'>" # all option allows for applying skull stripping to all subjects in the directory at which they exists. 
    exit 1
fi

# Extract threshold value from the first argument
threshold=$1

# Shift arguments to get the list of subjects or 'all'
shift

# Function to check if skull stripping file exists with the same threshold
skull_stripped_exists() {
    local subject_dir="$1"
    local threshold="$2"
    local skull_stripped_file="${subject_dir}/anat/${subject}_T1w_brain_${threshold}.nii.gz"
    [ -f "$skull_stripped_file" ] # check if the target file already exists in the subject directory. 
}


# Loop through subject numbers provided as arguments or process all directories
if [ "$1" = "all" ]; then
    for subject_dir in */; do # iterating over the entire folders in the current folder 
        subject="${subject_dir%/}" # Remove trailing slash 
        if ! skull_stripped_exists "$subject_dir" "$threshold"; then
            input_file="/home/joyou159/Downloads/Data/${subject}/anat/${subject}_T1w"
            output_file="${input_file}_brain_${threshold}"
            bet "$input_file" "$output_file" -f "$threshold" -g 0
        else
            echo "Skipping $subject_dir: skull stripping file already exists with the same threshold."
        fi
    done
else
    # Loop through subject numbers provided as arguments
    for subject in "$@"; do
        input_file="/home/joyou159/Downloads/Data/${subject}/anat/${subject}_T1w"
        output_file="${input_file}_brain_${threshold}"
        if ! skull_stripped_exists "/home/joyou159/Downloads/Data/${subject}/" "$threshold"; then
            bet "$input_file" "$output_file" -f "$threshold" -g 0
        else
            echo "Skipping ${subject}: skull stripping file already exists with the same threshold."
        fi
    done
fi

