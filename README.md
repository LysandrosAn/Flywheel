# Flywheel
Finite element formulation of rotating equipment in Julia language, featuring 1-D  Euler-Bernoulli beam shaft segments, gyroscoping coupling and linear bearing impedance.\
<img src= "pictures/SampleBlue.PNG"  width="400">

## Main features:
* Import of custom machinery geometry from file
* Calculation of the inertia, gyroscopy, damping and stiffness matrices
* Estimation of resonance frequencies and deformation due to gravity
* Provisionings for time transient numerical simulation

## Usage
* Edit the text file "Rotor_Sample.txt" that comes with the installation, cf. headers for the meaning of each column
* Ensure file is located in you current Julia directory
* Run `Flywheel_blueprint("Rotor_Sample")` to see blueprint, bearings are depicted as triangles, solid discs as grey elements
* Run `M,G,C,K=Flywheel_FEMatrices("Rotor_Sample")` to generate the finite element matrices based on your rotor dynamic system
* Run `A,B=Flywheel_statespace("Rotor_Sample")` to generate the state matrix A and input matrix B in the state-space domain

## References
* *Linear and Nonlinear Rotordynamics: A Modern Treatment with Applications, Second Edition* by Y. Ishida and T. Yamamoto (ISBN 978-3-527-40942-6)
* *Dynamics of Rotating Systems*" by G. Genta (ISBN 978-0-387-28687-7)

## License
Eclipse Public License 2.0

## Author
Lysandros Anastasopoulos
