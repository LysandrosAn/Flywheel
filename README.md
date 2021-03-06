# Flywheel
Finite element simulation of rotating equipment in Julia language, based on 1-D Euler beam shaft segments and linear bearing impedance.
Based on "*Linear and Nonlinear Rotordynamics: A Modern Treatment with Applications, Second Edition*" by Yukio Ishida and Toshio Yamamoto. ISBN:9783527409426\
Main features:
* Import of machinery geometry from file
* Calculation of the inertia, gyroscopy, damping and stiffness matrices
* Estimation of resonance frequencies, critical speeds, Campbell diagram
* Linear harmonic unbalance (1xΩ) response
* Provisionings for time transient numerical simulation
