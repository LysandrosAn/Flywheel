# Flywheel
Finite element simulation of rotating equipment in Julia language, featuring 1-D Euler beam shaft segments and linear bearing impedance.\

## Main features:
* Import of custom machinery geometry from file
* Calculation of the inertia, gyroscopy, damping and stiffness matrices
* Estimation of resonance frequencies
* Provisionings for time transient numerical simulation

## Usage
* Edit the text file "Rotor_Sample.txt" that comes with the installation, see the headers for the meaning of each column
* Ensure file is located in you current Julia directory
* Run `Flywheel_blueprint("Rotor_Sample")` in Julia to see blueprint, bearings are depicted as triangles, solid discs as grey elements
* Run `Flywheel_FEMatrices("Rotor_Sample")` in Julia to generate the finite element matrices based on your rotor dynamic system
<img src= "pictures/SampleBlue.PNG" >

## References
* *Linear and Nonlinear Rotordynamics: A Modern Treatment with Applications, Second Edition* by Yukio Ishida and Toshio Yamamoto (ISBN 978-3-527-40942-6)
* *Dynamics of Rotating Systems*" by Giancarlo Genta (ISBN 978-0-387-28687-7)
