load("comprometidas.mat")
disp("Testes NaveBays :")
[precisao_seguras, precisao_nao_seguras] = NaiveBays();
p = 0.001;  % Probabilidade de falsos positivos
load('m_value.mat', 'm');
n = round(-(m * log(p) / (log(2))^2));
k = round(((n / m) * log(2)) + 1);
disp("Testes BloomFilter :")
BloomFilter(k);

