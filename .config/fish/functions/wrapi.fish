function wrapi
    exec bwrap \
        --ro-bind / / \
        --proc /proc \
        --dev /dev \
        --ro-bind /sys /sys \
        --bind "$PWD" "$PWD" \
        --bind /tmp /tmp \
        --tmpfs "$HOME/.ssh" \
        --tmpfs "$HOME/.gnupg" \
        --tmpfs "$HOME/.docker" \
        --tmpfs "$HOME/.config/gh" \
        --tmpfs /root/.ssh \
        --tmpfs /root/.gnupg \
        --tmpfs /root/.docker \
        --unsetenv SSH_AUTH_SOCK \
        --unsetenv GPG_AGENT_INFO \
        --unsetenv AWS_PROFILE \
        --unsetenv AWS_DEFAULT_PROFILE \
        --chdir "$PWD" \
        --die-with-parent \
        --new-session \
        pi $argv
end
