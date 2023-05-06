clc;
%clear;
format long


syms alpha beta x y %Define Symbols (Variables) of Symbolic Function
Original_Y_Function_RHS = (alpha*exp(beta/(x^2)))^3;
Original_Y_Function_LHS = y;

%Input Data Points Array
Original_X_Vector = [5 5.8 6.1 7.4];
Original_Y_Vector = [81 77 75 71];

%RHS Linearization
CubicRoot_Y_RHS = nthroot(Original_Y_Function_RHS, 3);
Ln_Y_RHS = log(CubicRoot_Y_RHS);
Linear_Y_Function_RHS = Ln_Y_RHS*x^2;

%LHS Linearization
CubicRoot_Y_LHS = nthroot(Original_Y_Function_LHS, 3);
Ln_Y_LHS = log(CubicRoot_Y_LHS);
Linear_Y_Function_LHS = Ln_Y_LHS*x^2;

%Define The New Linear Equation Data Points
x = Original_X_Vector;
y = Original_Y_Vector;
Linear_X_Vector = Original_X_Vector.^2;
Linear_Y_Vector = double(subs(Linear_Y_Function_LHS));

%Compute The Matrix Elements
Sum_X_Linear = sum(Linear_X_Vector);
Sum_Y_Linear = sum(Linear_Y_Vector);
Sum_X_Square = sum(Linear_X_Vector.^2);
Sum_XY = sum(Linear_X_Vector.*Linear_Y_Vector);

%Construct The Matricies
Matrix_A = [ length(Original_X_Vector) Sum_X_Linear ; Sum_X_Linear Sum_X_Square ];
Matrix_B = [ Sum_Y_Linear ; Sum_XY];

%Compute The Linearized Coefficients
Coefficient_Matrix = linsolve(Matrix_A, Matrix_B);
a0 = Coefficient_Matrix(1, 1);
a1 = Coefficient_Matrix(2, 1);

%Compute The Original Coefficients
alpha = exp(a1)
beta = a0


Approximate_Y_Vector = double(subs(Original_Y_Function_RHS));
S_r = sum((Original_Y_Vector - Approximate_Y_Vector).^2);

Y_Average = sum(Original_Y_Vector)/length(Original_Y_Vector);
S_t = sum((Original_Y_Vector - Y_Average).^2);

%Compute The Correlation Coefficient (r)
Correlation_Coefficient_r = sqrt((S_t - S_r)/S_t)

scatter(Original_X_Vector, Original_Y_Vector, 'filled');
hold on
%Test_Points_X = 0.001:0.001:10;
%x = Test_Points_X;
x = 4.5:0.001:8;
Test_Points_Y = double(subs(Original_Y_Function_RHS));
%fplot(Original_Y_Vector, [0, 10])
plot(x, Test_Points_Y)
