load('Bf.mat')
p = 0.001;  
m = length(BF);
n = round(-(m * log(p) / (log(2))^2));
k = round(((n / m) * log(2)) + 1);

senha = input('Digite uma palavra-passe para verificar: ', 's');
save('ultima_palavra_teste.mat', 'senha');
NaiveBays_input();
BloomFilter_input(k); 



