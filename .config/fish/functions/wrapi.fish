function wrapi
    bwrap \
        --ro-bind / / \
        --proc /proc \
        --dev /dev \
        --ro-bind /sys /sys \
        --bind "$PWD" "$PWD" \
        --bind /tmp /tmp \
        --bind "$HOME/.pi" "$HOME/.pi" \
        --bind "$HOME/.cache" "$HOME/.cache" \
        --tmpfs "$HOME/.ssh" \
        --tmpfs "$HOME/.gnupg" \
        --tmpfs "$HOME/.docker" \
        --tmpfs "$HOME/.config/gh" \
        --unsetenv SSH_AUTH_SOCK \
        --unsetenv GPG_AGENT_INFO \
        --unsetenv AWS_PROFILE \
        --unsetenv AWS_DEFAULT_PROFILE \
        --chdir "$PWD" \
        --die-with-parent \
        --new-session \
        pi $argv
end
