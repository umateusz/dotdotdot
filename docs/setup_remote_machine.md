# Add host to ansible/inventory/machine:

    <ip> ansible_user=<user>

# Run:

    ansible-playbook --ask-become-pass -i ansible/inventory/machine ansible/remote_minimal.yml --extra-vars '{"dotdotdot_path":"~/dotdotdot"}' --ask-pass