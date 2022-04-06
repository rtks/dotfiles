# Defined in /tmp/fish.R9HA8B/set_abbr_custom.fish @ line 1
function set_abbr_custom
    abbr gfi 'git fixup'
    abbr gfia 'git add --all; git-fixup'
    abbr gau 'git add --update'

    abbr dco 'docker-compose'
    abbr dcup 'docker-compose up -d'
    abbr dcb 'docker-compose up -d --build'
    abbr dce 'docker-compose exec'
    abbr dclo 'docker-compose logs -ft --tail=1000'
end
