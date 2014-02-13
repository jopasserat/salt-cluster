
# Munch provides authentication for SLURM

munge.key:
  file:
    - managed
    - source: salt://scheduling/munge.key

munge:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - require:
      - pkg: munge
      - file: /etc/munge/munge.key

slurm-user:
  user.present:
    - name: slurm
    - shell: /bin/bash

# The SLURM scheduling system

/etc/slurm/slurm.conf:
  file:
    - managed
    - source: salt://scheduling/slurm.conf
    - template: jinja

slurm:
  user:
    - present
  pkg.installed:
    - sources:
      - slurm:                 http://babushk.in/files/slurm-2.6.6-2.el6.x86_64.rpm
      - slurm-devel:           http://babushk.in/files/slurm-devel-2.6.6-2.el6.x86_64.rpm
      - slurm-munge:           http://babushk.in/files/slurm-munge-2.6.6-2.el6.x86_64.rpm
      - slurm-pam_slurm:       http://babushk.in/files/slurm-pam_slurm-2.6.6-2.el6.x86_64.rpm
      - slurm-perlapi:         http://babushk.in/files/slurm-perlapi-2.6.6-2.el6.x86_64.rpm
      - slurm-plugins:         http://babushk.in/files/slurm-plugins-2.6.6-2.el6.x86_64.rpm
      - slurm-sjobexit:        http://babushk.in/files/slurm-sjobexit-2.6.6-2.el6.x86_64.rpm
      - slurm-sjstat:          http://babushk.in/files/slurm-sjstat-2.6.6-2.el6.x86_64.rpm
      - slurm-slurmdbd:        http://babushk.in/files/slurm-slurmdbd-2.6.6-2.el6.x86_64.rpm
      - slurm-slurmdbd-direct: http://babushk.in/files/slurm-slurmdb-direct-2.6.6-2.el6.x86_64.rpm
      - slurm-slurm-sql:       http://babushk.in/files/slurm-sql-2.6.6-2.el6.x86_64.rpm
      - slurm-torque:          http://babushk.in/files/slurm-torque-2.6.6-2.el6.x86_64.rpm
  service.running:
    - running
    - enable: True
    - require:
      - pkg: slurm
      - user: slurm
      - pkg: munge
      - file: /etc/slurm/slurm.conf
