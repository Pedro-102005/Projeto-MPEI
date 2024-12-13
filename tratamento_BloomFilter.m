senhas_nao_seguras = readtable('weak_passwords.csv', 'FileType', 'text', 'Delimiter', ',', 'Encoding', 'latin1');
comprometidas = table2array(senhas_nao_seguras);
senhas_nao_seguras_testeeeee = comprometidas(1:1000);

% Configuração do Bloom Filter
p = 0.001;  % Probabilidade de falsos positivos
m = length(comprometidas);
n = round(-(m * log(p) / (log(2))^2));
k = round(((n / m) * log(2)) + 1);
BF = inicializador(n);


for i = 1:length(comprometidas)
    BF = adicionar(BF, comprometidas{i}, k);
end

save('BF.mat', 'BF');
save('senhas_nao_seguras_testeeeee.mat', 'senhas_nao_seguras_testeeeee');



