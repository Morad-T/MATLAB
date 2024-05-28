% Define parameters
mu = 0; % Mean for Gaussian and Rician
sigma = 1; % Standard deviation for Gaussian and Lognormal
sigma_Rician = 0.5; % Standard deviation for Rician noise
K = 2; % Rician K factor

% Define range of values for x-axis
x = -5:0.01:5;

% Plot Gaussian Distribution
y_gauss = normpdf(x, mu, sigma);
figure;
plot(x, y_gauss);
title('Gaussian Distribution');
xlabel('x');
ylabel('p(x)');

% Plot Rayleigh Distribution
y_rayleigh = raylpdf(x, sigma);
figure;
plot(x, y_rayleigh);
title('Rayleigh Distribution');
xlabel('x');
ylabel('p(x)');
xlim([0 5])

% Plot Rician Distribution
%(r^K * exp(-(r^2 + K^2)/(2*sigma_Rician^2))) / (2*sigma_Rician^2 * besselk(0,K^2/(2*sigma_Rician^2)));
y_rician = (x/sigma_Rician^2).*exp(-(x.^2+K^2)/(2*sigma_Rician^2)).*besseli(0,(x*K)/sigma_Rician^2);
  
figure;
plot(x, y_rician);
title('Rician Distribution')
xlabel('x')
ylabel('p(x)')
xlim([0 5])

% Plot Lognormal Distribution
y_lognormal = lognpdf(x, mu, sigma);
figure;
plot(x, y_lognormal)
title('Lognormal Distribution')
xlabel('x')
ylabel('p(x)')
xlim([0 5])