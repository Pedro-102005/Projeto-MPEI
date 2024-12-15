load("comprometidas.mat")
disp("Testes NaveBays :")
[precisao_seguras, precisao_nao_seguras] = NaiveBays();
p = 0.001; 
load('m_value.mat', 'm');
n = round(-(m * log(p) / (log(2))^2));
k = round(log(1/2) / (m * log(1 - 1/n)));
disp("Testes BloomFilter :")
BloomFilter(k);


disp("Exemplo de palavra com similaridade")
senha = 'kateritt';
Minhash_input(senha);

disp("Exemplo de palavra sem similaridade")
senha = 'kadedfefgg';
Minhash_input(senha);

disp("Exemplo de palavra nao segura")
senha = 'ola123';
NaiveBays_input(senha);

disp("Exemplo de palavra segura")
senha = 'SOPWinfr``3.';
NaiveBays_input(senha);

disp("Exemplo de palavra nao comprometida")
senha = 'JNXEUYGHdsd8.';
BloomFilter_input(k,senha);

disp("Exemplo de palavra comprometida")
senha = 'dyqocg7';
BloomFilter_input(k,senha);
