[Unit]
Description=Habitat Supervisor

[Service]
Restart=on-failure
ExecStart=/bin/hab run ${peers} \
                       --listen-ctl=0.0.0.0:9632

[Install]
WantedBy=default.target
