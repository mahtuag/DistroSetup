#!/usr/bin/env python3

import subprocess
n_cpu = int(subprocess.run(['nproc', '--all'], stdout=subprocess.PIPE).stdout.decode('utf-8'))
print('Detected {} CPUs!\n'.format(n_cpu))
for index in range(n_cpu):
    print('Running Command "cpufreq-set -c {} -g performance"'.format(index))
    cmd_result = subprocess.run(['cpufreq-set', '-c', '{}'.format(index), '-g', 'performance'], stdout=subprocess.PIPE)
    print(cmd_result.stdout.decode('utf-8'))
print('\nDone!')
