[Unit]
Description=Habitat Supervisor

[Service]
Restart=on-failure
ExecStart=/bin/hab run ${peers} \
                       --ring ${ring_name} \
                       --listen-ctl=0.0.0.0:9632

[Install]
WantedBy=default.target
