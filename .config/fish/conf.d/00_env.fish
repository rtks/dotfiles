if status is-login
    if set -q MSYSTEM;
        set -gx MSYS2_PATH_TYPE inherit
    end
end
