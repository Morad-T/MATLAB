%% Question 1

A = [0, 1, 0;
    -1, -1, 0;
     1, 0, 0];

B = [0; 1; 0];
C = [0, 0, 1];
D = 0;

[Num, Den] = ss2tf(A, B, C, D)
TranferFunction = tf(Num, Den)

%% Question 2a

A = [-1, 0, 1;
     1, -2, 0;
     0, 0, -3];

B = [0; 0; 1];
C = [1, 1, 0];
D = 0;

%Controllability Matrix
CM = [B, A*B, A^2*B]

syms Lambda s
CharEq = det(s*eye(3) - A)
CharEqCoefficients = sym2poly(CharEq)

%Poles = root(CharEq,s)
%Roots = double(solve(CharEq == 0))
 
%[Num, Den] = ss2tf(A, B, C, D)

a_n = fliplr(CharEqCoefficients)

% Coefficients Matrix
W = [a_n(:, 2:end);
    a_n(:, 3:end), 0;
    a_n(:, 4:end), 0, 0;]

% Yes, I acknowledge this method is rather hacky and far from being robust

% Tranformatin Matrix

P = CM*W

A_CCF = inv(P)*A*P
B_CCF = inv(P)*B
C_CCF = C*P
D_CCF = D

%% Question 2b

A = [-1, 0, 1;
     1, -2, 0;
     0, 0, -3];

B = [0; 0; 1];
C = [1, 1, 0];
D = 0;

%Observability Matrix
OM = [C; C*A; C*A^2]

%Check Observability
Observability = det(OM)

if (0 ~= Observability)
    syms s
    CharEq = det(s*eye(3) - A)
    CharEqCoefficients = sym2poly(CharEq)

    %Poles = root(CharEq,s)
    %Roots = double(solve(CharEq == 0))
 
    %[Num, Den] = ss2tf(A, B, C, D)

    a_n = fliplr(CharEqCoefficients)

    % Coefficients Matrix
    % Yes, I acknowledge this method is rather hacky and far from being robust

    W = [a_n(:, 2:end);
        a_n(:, 3:end), 0;
        a_n(:, 4:end), 0, 0;]



    % Tranformatin Matrix

    Q = OM*W
    A_OCF = inv(Q)*A*Q
    B_OCF = inv(Q)*B
    C_OCF = C*Q
    D_OCF = D

else
    A_OCF = transpose(A_CCF)
    B_OCF = transpose(C_CCF)
    C_OCF = transpose(B_CCF)
    D_OCF = D_CCF
end



%%
% Lambdas = eig(A)
% 
% syms Lambda
% %Adjoint = 
% 
% Adjoint_Symbolic = adjoint(Lambda.*eye(3) - A)
% FirstSubstitution = subs(Adjoint_Symbolic,Lambdas(1))
% SecondSubstitution = subs(Adjoint_Symbolic,Lambdas(2))
% ThirdSubstitution = subs(Adjoint_Symbolic,Lambdas(3))
% 
% TransformationMatrix = [FirstSubstitution(:,3), SecondSubstitution(:,3), ThirdSubstitution(:,3)]
% Alpha  = inv(TransformationMatrix)*A*TransformationMatrix